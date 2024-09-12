import * as Vue from "vue"
import HelloWorld from "./components/HelloWorld"

document.addEventListener("DOMContentLoaded", () => {
    const element = document.querySelector("#app");
    if (element !== null) {
        const app = Vue.createApp({});

        // register your components
        app.component('hello-world', HelloWorld);

        app.mount("#app");
    }
});
