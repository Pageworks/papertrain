/**
 * Send an XMLHttpRequest and return a promise
 * Method should be a string with a value of `POST` or `GET`
 * @param method
 * @param url
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