/**
 * Checks if the supplied elemente is within the viewport.
 * @param {Element} el Element
 * @returns boolean
 */
export function isInView(el:Element){
    const rect = el.getBoundingClientRect();
    return (rect.height > 0 || rect.width > 0) && rect.bottom >= 0 && rect.right >= 0 && rect.top <= (window.innerHeight || document.documentElement.clientHeight) && rect.left <= (window.innerWidth || document.documentElement.clientWidth);
}
