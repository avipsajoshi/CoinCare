<%-- 
    Document   : loader
    Created on : 28 Jul 2024, 23:46:50
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
      @font-face {
        font-family: 'Roboto';
        src: url('..\\components\\Font\\Roboto-Thin.ttf');
      }

      :root{
        --primary-color:#13262f;
        --primary-color-alt:#fffdf7;
        --primary-text: #eee;
        --primary-text-alt:#102;
        --action:#b5ffe9;
        --action-alt:#5b85aa;
      }
      .loader-wrapper {
        width: 100%;
        height: 100%;
        position: absolute;
        top: 0;
        left: 0;
        background-color: var(--primary-color);
        display:flex;
        justify-content: center;
        align-items: center;
      }
      .loader {
        display: inline-block;
        width: 30px;
        height: 30px;
        position: relative;
        border: 4px solid #Fff;
        animation: loader 2s infinite ease;
      }
      .loader-inner {
        vertical-align: top;
        display: inline-block;
        width: 100%;
        background-color: #fff;
        animation: loader-inner 2s infinite ease-in;
      }

      @keyframes loader {
        0% {
          transform: rotate(0deg);
        }
        25% {
          transform: rotate(180deg);
        }
        50% {
          transform: rotate(180deg);
        }
        75% {
          transform: rotate(360deg);
        }
        100% {
          transform: rotate(360deg);
        }
      }

      @keyframes loader-inner {
        0% {
          height: 0%;
        }
        25% {
          height: 0%;
        }
        50% {
          height: 100%;
        }
        75% {
          height: 100%;
        }
        100% {
          height: 0%;
        }
      }

    </style>
  </head>
  <body>
    <div class="loader-wrapper">
      <span class="loader"><span class="loader-inner"></span></span>
    </div>
    <script>
      $(window).on("load", function () {
        $(".loader-wrapper").fadeOut("slow");
      });

    </script>
  </body>
</html>