const CACHE_NAME = "cost-accounting-cache-v1";
const FILES_TO_CACHE = [
  "/cost_accounting_standard.html",
  "/manifest.json",
  "/icon-192x192.png",
  "/icon-512x512.png"
];

// インストール時にキャッシュ
self.addEventListener("install", (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      return cache.addAll(FILES_TO_CACHE);
    })
  );
});

// オフライン対応
self.addEventListener("fetch", (event) => {
  event.respondWith(
    caches.match(event.request).then((response) => {
      return response || fetch(event.request);
    })
  );
});
