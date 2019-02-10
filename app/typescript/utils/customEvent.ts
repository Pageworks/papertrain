/**
 * Fires a custom event on the `document`.
 * @param { string } eventType - custom event name
 * @param { object } detail - custom event details object
 */
export function customEvent(eventType:string, detail:object = {}){
    const event = new CustomEvent(eventType, { detail });
    document.dispatchEvent(event);
}
