/** Object storing module functions */
declare var modules: { [index:string]: Function };

declare module 'uuid/v4';

interface IEasingObject{
    ease:   string;
    in:     string;
    out:    string;
    sharp:  string;
}
