<p align="center">
<a href="http://papertrain.io"><img alt="Papertrain" src="_papertrain/logo.png"/></a><br/>
<img style="display:inline-block;" src="https://img.shields.io/badge/templating%20engine-Twig-orange.svg?style=flat-square"/>
<img style="display:inline-block;" src="https://img.shields.io/badge/style-SASS-blue.svg?style=flat-square"/>
<img style="display:inline-block;" src="https://img.shields.io/badge/typescript-3.4-yellow.svg?style=flat-square"/>
<img style="display:inline-block;" src="https://img.shields.io/badge/bundler-webpack-5299c8.svg?style=flat-square"/>
<img style="display:inline-block;" src="https://img.shields.io/badge/CMS-Craft%203.1-ff69b4.svg?style=flat-square"/>
<a style="display:inline-block;" href="https://github.com/AndrewK9/papertrain/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-MIT-lightgray.svg?style=flat-square"/></a>
</p>

# Usage

## Globals

A Global is a unique style for a [Basic HTML Element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element). Globals will **NEVER** apply the style to the raw HTML element and they **DO NOT** inherently have any functionality but can be assigned functionality by a Component.

Globals are defined as a single Style file.

File: `Button.scss`

**Correct Usage**

```scss
.g-button{
    border: 2px solid aqua;
    border-radius: 2px;
    padding: 0 16px;
    height: 36px;
    line-height: 36px;

    &.-solid{
        background-color: aqua;
    }
}
```

**Incorrect Usage**

```scss
button{
    border: 2px solid aqua;
    border-radius: 2px;
    padding: 0 16px;
    height: 36px;
    line-height: 36px;
}
```

## Objects

Objects can exists anywhere within the page as visual elements. Objects **DO NOT** inherently have any functionality but can be assigned functionality by a Component.

Objects can be composed of Globals and other Objects.

Objects are defined as a combination of the following files:

### HTML

```html
<div class="o-card">
    <img src="img.jpg" alt="Lorem Ipsume" />
    <h3 class="o-card_heading">Lorem Ipsum</h3>
    <p>Lorem ipsum dolor sit amet...</p>
    <a href="page.html" class="g-button">Read More</a>
</div>
```

### Style

```scss
.o-card{
    width: 256px;
    height: 512px;
    border-radius: 4px;
    background-color: #ffffff;
    box-shadow: 0 2px 4px rgba(41,41,41,0.1);

    img{
        width: 100%;
        height: 128px;
        object-fit: cover;
    }

    .o-card_heading{
        font-size: 24px;
        margin-bottom: 16px;
    }

    p{
        font-size: 16px;
        line-height: 1.618;
    }
}
```

## Components

A Component is similar to an Object except that is has a uniquely defined piece of functionality.

Components can be composed of Objects and Globals.

Components are defined as a combination of following files:

### HTML

```html
<div class="c-DemoComponent" data-component="DemoComponent">
    <div class="c-DemoComponent_card"></div>
    <div class="c-DemoComponent_card"></div>
    <div class="c-DemoComponent_card"></div>
    <div class="c-DemoComponent_card"></div>
    <div class="c-DemoComponent_card"></div>
    <div class="c-DemoComponent_card"></div>
</div>
```

### Style

```scss
.c-DemoComponent{
    display: grid;
    gap: 16px;
    grid-template-columns: 1fr 1fr 1fr;

    .c-DemoComponent_card{
        border-radius: 4px;
        background-color: #ffffff;
        box-shadow: 0 2px 4px rgba(41,41,41,0.1);
        min-height: 256px;
    }
}
```

### Script

```typescript
export class DemoComponent extends BaseComponent {
    
    public static String COMPONENT_NAME = "DemoComponent";
    
    constructor(el:HTMLElement, uuid:String, manager:ManagerClass){
        super(el, uuid, manager);
    };

    private changeColor:EventListener = ()=>{
        console.log(`Creating a new ${ DemoComponent.MODULE_NAME } module`);
        this.el.style.backgroundColor = 'rgb(66, 134, 244)';
    }

    /**
     * Called when the module is created.
     */
    init():void{
        this.el.addEventListener('click', this.changeColor);
    }

    /**
     * Called when the module is being removed.
     */
    destroy():void{
        super.destroy(DemoComponent.MODULE_NAME);
    }
}
```

## Managers

A Manager is a group of Components that need to work together to perform a tasks that would be too advanced for any single Component to achieve on it's own. The role of a Manager is to manage the Components that are assigned to it along with any additional 3rd party packages.

Managers are defined as a combination of the following files:

### HTML

```html
<!doctype <!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Manager Demo Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
    <main id="Manager">

    ...snip...

    </main>
    <script src="Manager.js"></script>
</body>
</html>
```

### Style

```scss
#Manager{
    position: relative;
    display: block;
    margin: 0 auto;
    width: 100vw;
    max-width: 1200px;
}
```

### Script

```typescript
import { ModuleManager } from 'ModuleManager';
import { Pjax } from '@codewithkyle/pjax';

class Manager{
    constructor(){
        console.log('The Manager has started their shift');
        this.init();
    }

    /**
     * Called when Pjax fires it's custom `pjax:complete` event on the `document`.
     */
    private handlePageLoad:EventListener = ()=>{
        this.reinit();
    }

    private init():void{
        // Start Pjax
        new Pjax({ debug: true });

        // Start the Module Manager
        new ModuleManager();

        // Listen for a successful page transition event
        document.addEventListener('pjax:complete', this.handlePageLoad);
    }

    /**
     * Called when a new page is loaded via Pjax.
     * Any classes/packages that need to manage their DOM hooks should be told to reinit.
     */
    public reinit():void{
        ModuleManager.manageModules();
    }
}

// IIFE used to start the Manager class
(()=>{
    new Manager();
})();
```

# Interfaces

## Manager

```typescript
interface ManagerClass {
    constructor();
    public Function init():void;
    private Function update():void;
    private EventListener reload = update;
}
```

`ManagerClass.init()` is called after the class has been instantiated. It is used to instantiate any utility classes that the Manager will need.

`ManagerClass.update()` is called when the `reload` Event Listener is triggered. It is responsible for updating, managing, or informing any of the Managers utility classes that a page transition occurred.

`reload` is an [Event Listener](https://developer.mozilla.org/en-US/docs/Web/API/EventListener) that fires whenever a page transition occures.

## Base Component

```typescript
interface BaseComponent {
    constructor(el, uuid, manager);
    
    // Variables
    public HTMLElement el;
    public String uuid;
    public ManagerClass manager;

    // Methods
    public Function init():void;
    public Function destroy():void;
}
```

`BaseComponent.el` is the top-level element that the functionality of the Component should be scoped within.

`BaseComponent.uuid` is the [Universally Unique Identifier](https://en.wikipedia.org/wiki/Universally_unique_identifier) that is assigned to the Component so it can be easily identified by the Manager.

`BaseComponent.manger` is the reference to the Manager that manages the Component.

`BaseComponent.init()` is called after the class has been instantiated. It is used to setup event listeners or call any initial methods.

`BaseComponent.destroy()` is called when the Component is about to be destroyed. It is used to remove any event listeners or call any final methods.

## Component

```typescript
interface Component extends BaseComponent {
    constructor(el:HTMLElement, uuid:String, manager:ManagerClass){
        super(el, uuid, manager);
    };
    
    // Variables
    public static String COMPONENT_NAME;

    // Methods
    Function init():void;
    Function destroy():void;
}
```

`Component.COMPONENT_NAME` is key index value string that the Manager will use to instantiate an new instance of the Component.

# Feedback
Feel free to [open an issue](https://github.com/Pageworks/papertrain/issues).

# License
[MIT](https://github.com/Pageworks/papertrain/blob/master/LICENSE)
