const ABSOLUTE_URL_RE = /^(?:https?:)?\/\//

export function resolvePublicAssetUrl(path: string, cdnURL = ''): string {
  if (!path || ABSOLUTE_URL_RE.test(path) || !path.startsWith('/')) {
    return path
  }

  const normalizedCdnURL = cdnURL.replace(/\/$/, '')
  return normalizedCdnURL ? `${normalizedCdnURL}${path}` : path
}
