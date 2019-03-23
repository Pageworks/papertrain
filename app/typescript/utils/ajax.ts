/**
 * Send an XMLHttpRequest and return a promise.
 * Method should be a string with a value of `POST` or `GET`.
 * To get the XMLHttpRequest from the `ProgressEvent` use `const request = <XMLHttpRequest>e.target`.
 * @param {string} method Is the reqeust a `GET` or `POST` request?
 * @param {string} url
 * @returns `ProgressEvent`
 */
export function sendRequest(method:string, url:string){
    return new Promise((resolve, reject)=>{
        const xhr = new XMLHttpRequest();
        xhr.open(method, url);
        xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
        xhr.onload = resolve;
        xhr.onerror = reject;
        xhr.send();
    });
}
