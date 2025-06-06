'use strict';
document.addEventListener("DOMContentLoaded", scriptregistrarse);

function scriptregistrarse() {
    let textocaptcha = document.querySelector("#textocaptcha");
    let numerocaptcha = Math.floor(Math.random() * (999999 - 100000) + 100000);
    textocaptcha.innerHTML = numerocaptcha;
    let formularioregistro = document.querySelector("#formularioregistro");
    formularioregistro.addEventListener("submit", e => {
        // e.preventDefault();
        validarregistro();
    });

    function validarregistro() {
        let inputcaptcha = document.querySelector("#inputcaptcha");
        let numero = numerocaptcha.toString();
        if (inputcaptcha.value === numero) {
            inputcaptcha.className = "form-control p-4 is-valid";
            document.querySelector("#captchavalido").innerHTML = "Captcha correcto";
            numerocaptcha = Math.floor(Math.random() * (999999 - 100000) + 100000);
            textocaptcha.innerHTML = numerocaptcha;
            inputcaptcha.value = "";
        } else {
            numerocaptcha = Math.floor(Math.random() * (999999 - 100000) + 100000);
            textocaptcha.innerHTML = numerocaptcha;
            inputcaptcha.value = "";
            inputcaptcha.className = "form-control p-4 is-invalid";
            document.querySelector("#captchainvalido").innerHTML = "Captcha Incorrecto";
        }
    }
}