export function loadRouteModule() {
  const route = window.location.pathname.replace(/\/$/, '') || '/';

  const routeMap = {
    '/': () => import('./home.js'),
  };

  const loadModule = routeMap[route];
  if (loadModule) {
    return loadModule();
  }

  return import('./404.js').catch(() => {
    return Promise.reject(new Error(`No module for route: ${route}`));
  });
}