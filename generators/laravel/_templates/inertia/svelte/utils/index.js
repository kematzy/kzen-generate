export function isEnterKey(e) {
  return e.keyCode && e.keyCode === 13
}

export function isEscKey(e) {
  return e.keyCode && e.keyCode === 27
}

export const route = window.route

/**
 * Check if `string` starts with `search`
 * @param {string} string
 * @param {string} search
 * @return {boolean}
 */
export function startsWith(string, search) {
  return string.substr(0, search.length) === search;
}
