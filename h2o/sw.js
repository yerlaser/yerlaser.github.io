const cacheName = 'v7'
const urlsToCache = [
  '../favicon.ico',
  './web/',
  './web/favicon-192x192.png',
  './web/favicon-512x512.png',
  './web/index.html',
  './web/manifest.json',
  './web/css/index.css',
  './web/css/zzspinner.css',
  './web/mjs/backend.mjs',
  './web/mjs/controller.mjs',
  './web/mjs/index.mjs',
  './web/mjs/meta.mjs',
  './web/mjs/model.mjs',
  './web/mjs/settings.mjs',
  './web/mjs/status.mjs',
  './web/mjs/utils.mjs',
  './web/mjs/view.mjs',
]

self.addEventListener('install', (event) => {
  event.waitUntil(caches.open(cacheName).then((cache) => {
    return cache.addAll(urlsToCache)
  }))
})

self.addEventListener('fetch', (event) => {
  console.log(event.request.url)
  if (event.request.url.startsWith('http://0.0.0.0:8003')) return
  event.respondWith(caches.match(event.request).then((response) => {
    if (response) {
      return response
    }
    return fetch(event.request)
  }))
})

self.addEventListener('fetch', (event) => {
  console.log(event.request.url)
  if (event.request.url.startsWith('http://0.0.0.0:8003')) return
  event.respondWith(caches.match(event.request).then((response) => {
    if (response) {
      return response
    }

    return fetch(event.request).then((response) => {
        if(!response || response.status !== 200 || response.type !== 'basic') {
          return response
        }

        let responseToCache = response.clone()

        caches.open(cacheName).then((cache) => {
          cache.put(event.request, responseToCache)
        })

        return response
      }
    )
  }))
})

self.addEventListener('activate', (event) => {
  const cacheWhitelist = [cacheName]

  event.waitUntil(caches.keys().then((cacheNames) => {
    return Promise.all(cacheNames.map((cacheName) => {
      if (cacheWhitelist.indexOf(cacheName) === -1) {
        return caches.delete(cacheName)
      }
    }))
  }))
})

self.addEventListener('message', async event => {
  const url = event.data
  let response
  let responseText
  try {
    response = await fetch(url, {cache: 'no-cache'})
    responseText = await response.text()
  } catch(e) {
    console.log('sw fetch error:')
    event.ports[0].postMessage(null)
    return
  }
  if (response.ok) {
    event.ports[0].postMessage(responseText)
  } else {
    console.log(`Status=${response.status}`)
    event.ports[0].postMessage(null)
  }
})
