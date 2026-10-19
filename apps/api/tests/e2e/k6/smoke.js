// Smoke test k6 : l'API répond vite sur les sondes. À étoffer par EP-06 (charge : 400 ruches x24 accéléré,
// API p95 < 500 ms, ROADMAP §5.6).
import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  vus: 5,
  duration: '20s',
  thresholds: {
    http_req_failed: ['rate<0.01'],
    http_req_duration: ['p(95)<500'],
  },
};

const BASE_URL = __ENV.BASE_URL || 'http://localhost:8000';

export default function () {
  const res = http.get(`${BASE_URL}/health`);
  check(res, { 'health 200': (r) => r.status === 200 });
  sleep(0.5);
}
