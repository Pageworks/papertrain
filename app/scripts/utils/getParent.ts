/**
 * Attempt to find the elements parent with the desired class
 * @param {Element} el starting element
 * @param {String} selector parent elements class
 * @returns parent or starting element
 */
export function getParent(el:Element, selector:string){
    let parent = el;
    do{
        parent = parent.parentElement;
        if(parent.classList.contains(selector)) return parent;
    } while (parent.parentElement !== null)
    return el;
}