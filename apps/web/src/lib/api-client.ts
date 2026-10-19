/**
 * Client HTTP typé vers l'API FastAPI (préfixe /api/v1, contrat : docs/openapi.yaml).
 *
 * Règles (PLAYBOOK §7 WEB) :
 *  - les types viennent d'OpenAPI : `npm run gen:api` -> src/lib/api-types.gen.ts ;
 *  - erreurs au format RFC 9457 (application/problem+json) -> ApiError ;
 *  - pagination par curseur, ETag géré par le navigateur/le cache Next ;
 *  - POST : en-tête Idempotency-Key ;
 *  - jamais de jeton dans localStorage ; cookies httpOnly envoyés avec credentials.
 *
 * TODO(KAN-xxx, EP-08) : remplacer `unknown` par les types générés (paths[...]).
 */

/** Corps d'erreur RFC 9457. */
export type ProblemDetails = {
  type?: string;
  title: string;
  status: number;
  detail?: string;
  instance?: string;
  [extension: string]: unknown;
};

export class ApiError extends Error {
  readonly status: number;
  readonly problem: ProblemDetails;

  constructor(problem: ProblemDetails) {
    super(problem.title);
    this.name = "ApiError";
    this.status = problem.status;
    this.problem = problem;
  }
}

/** Page de résultats à curseur. */
export type Page<T> = { items: T[]; next_cursor: string | null };

/** Côté serveur (conteneur web) on appelle l'API par le réseau interne. */
function baseUrl(): string {
  if (typeof window === "undefined") {
    return process.env.API_INTERNAL_URL ?? process.env.NEXT_PUBLIC_API_URL ?? "";
  }
  return process.env.NEXT_PUBLIC_API_URL ?? "";
}

type RequestOptions = {
  method?: "GET" | "POST" | "PATCH" | "PUT" | "DELETE";
  query?: Record<string, string | number | boolean | undefined>;
  body?: unknown;
  idempotencyKey?: string;
  signal?: AbortSignal;
  /** Options de cache Next (ex. { revalidate: 60 }). */
  next?: { revalidate?: number | false; tags?: string[] };
};

export async function apiFetch<T>(path: string, opts: RequestOptions = {}): Promise<T> {
  const params = new URLSearchParams();
  for (const [k, v] of Object.entries(opts.query ?? {})) {
    if (v !== undefined) params.set(k, String(v));
  }
  const queryString = params.toString();
  const finalUrl = `${baseUrl()}${path}${queryString ? `?${queryString}` : ""}`;

  const headers: Record<string, string> = { Accept: "application/json" };
  if (opts.body !== undefined) headers["Content-Type"] = "application/json";
  if (opts.idempotencyKey) headers["Idempotency-Key"] = opts.idempotencyKey;

  const res = await fetch(finalUrl, {
    method: opts.method ?? "GET",
    headers,
    body: opts.body === undefined ? undefined : JSON.stringify(opts.body),
    credentials: "include",
    signal: opts.signal,
    next: opts.next,
  });

  if (!res.ok) {
    const problem = (await res.json().catch(() => null)) as ProblemDetails | null;
    throw new ApiError(
      problem ?? { title: "Erreur réseau ou serveur", status: res.status },
    );
  }
  if (res.status === 204) return undefined as T;
  return (await res.json()) as T;
}
