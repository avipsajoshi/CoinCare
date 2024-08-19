<%-- 
    Document   : index
    Created on : 25 Jul 2024, 07:12:59
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.coincare.helper.FactoryProvider" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Homepage | CoinCare</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="icon" type="image/png" href="./images/coincarelogo.png">
    <link rel="stylesheet" href="css/fontAndColors.css">
    <link
      href="https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css"
      rel="stylesheet"
      />
    <link href="./custom.css" rel="stylesheet" />
    <script
      src="https://code.jquery.com/jquery-3.5.1.min.js"
      integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
      crossorigin="anonymous"
    ></script>
    <script
      type="text/javascript"
      src="https://code.jquery.com/ui/1.8.23/jquery-ui.min.js"
    ></script>
  </head>

  <body class="">
    <!--Section one starts-->
    <nav class="w-full">
      <div class="container mx-auto px-6 flex items-center justify-between">
        <div class="flex items-center">
          <svg
            width="199px"
            height="48px"
            viewBox="0 0 199 48"
            version="1.1"
            xmlns="http://www.w3.org/2000/svg"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            >
          <g
            id="Work-in-Progress"
            stroke="none"
            stroke-width="1"
            fill="none"
            fill-rule="evenodd"
            >
          <g
            id="Header---3-Copy"
            class="mode"
            transform="translate(-146.000000, -31.000000)"
            >
          <g id="Group-4" transform="translate(146.000000, 31.000000)">
          <g id="Group-6">
          <text
            id="Retra-Insights"
            font-size="20"
            font-weight="400"
            letter-spacing="0.1"
            fill="#2D3748"
            >
            <tspan x="60" y="30">CoinCare</tspan>
          </text>
          <g id="Group">
          <polyline
            id="Fill-18"
            fill="var(--logo1)"
            points="36 5.99986676 24 0 24 12 36 5.99986676"
            ></polyline>
          <polyline
            id="Fill-19"
            fill="var(--logo2)"
            points="48 12.0001332 36 6 36 18 48 12.0001332"
            ></polyline>
          <polyline
            id="Fill-20"
            fill="var(--logo1)"
            points="48 24 48 12 36 17.9999334 48 24"
            ></polyline>
          <polyline
            id="Fill-21"
            fill="var(--logo3)"
            points="12 6 12 18 24 12.0001332 12 6"
            ></polyline>
          <polyline
            id="Fill-22"
            fill="var(--logo2)"
            points="24 0 12 5.99986676 24 12 24 0"
            ></polyline>
          <polyline
            id="Fill-23"
            fill="var(--logo3)"
            points="0 12 0 24 12 17.9999334 0 12"
            ></polyline>
          <polyline
            id="Fill-24"
            fill="var(--logo4)"
            points="12 6 0 12.0001332 12 18 12 6"
            ></polyline>
          <polyline
            id="Fill-25"
            fill="var(--logo1)"
            points="24 24.0000666 12 18 12 30 24 24.0000666"
            ></polyline>
          <polyline
            id="Fill-26"
            fill="var(--logo3)"
            points="0 24 0 36 12 29.9999334 0 24"
            ></polyline>
          <polyline
            id="Fill-27"
            fill="var(--logo2)"
            points="12 18 0 24.0000666 12 30 12 18"
            ></polyline>
          <polyline
            id="Fill-28"
            fill="var(--logo4)"
            points="12 30 0 35.9999334 12 42 12 30"
            ></polyline>
          <polyline
            id="Fill-29"
            fill="var(--logo1)"
            points="24 48 36 42.0001332 24 36 24 48"
            ></polyline>
          <polyline
            id="Fill-30"
            fill="var(--logo2)"
            points="24 36 12 42.0001332 24 48 24 36"
            ></polyline>
          <polyline
            id="Fill-31"
            fill="var(--logo2)"
            points="48 24 36 18 36 30 48 24"
            ></polyline>
          <polyline
            id="Fill-32"
            fill="var(--logo3)"
            points="48 36 48 24 36 29.9999334 48 36"
            ></polyline>
          <polyline
            id="Fill-33"
            fill="var(--logo4)"
            points="36 42 48 35.9999334 36 30 36 42"
            ></polyline>
          <polyline
            id="Fill-34"
            fill="var(--logo3)"
            points="36 18 24 24 36 30 36 18"
            ></polyline>
          <polyline
            id="Fill-35"
            fill="var(--logo3)"
            points="36 30 24 35.9999334 36 42 36 30"
            ></polyline>
          </g>
          </g>
          </g>
          </g>
          </g>
          </svg>
        </div>
        <ul class="hidden sm:flex items-center py-8">
          <li
            class="text-gray-600 logobodybody cursor-pointer text-base ml-10"
            >
            <a href="#">Features</a>
          </li>
          <li
            class="text-gray-600 logobodybody cursor-pointer text-base ml-10"
            >
            <a href="#">Contact</a>
          </li>
          <li
            class="text-gray-600 logobodybody cursor-pointer text-base ml-10"
            >
            <a href="./login.jsp">Login</a>
          </li>
          <li
            class="text-white logobody cursor-pointer text-base ml-10"
            >
            <a href="./register.jsp">Get Started</a>
          </li>
        </ul>
        <svg
          aria-haspopup="true"
          aria-label="Main Menu"
          xmlns="http://www.w3.org/2000/svg"
          class="icon icon-tabler icon-tabler-menu sm:hidden"
          width="24"
          height="24"
          viewBox="0 0 24 24"
          stroke-width="1.5"
          stroke="#2c3e50"
          fill="none"
          stroke-linecap="round"
          >
        <path stroke="none" d="M0 0h24v24H0z" />
        <line x1="4" y1="8" x2="20" y2="8" />
        <line x1="4" y1="16" x2="20" y2="16" />
        </svg>
      </div>
    </nav>
    <div class="w-full px-6">
      <div
        class="mt-8 relative rounded-lg logobody container mx-auto flex flex-col items-center pt-12 sm:pt-24 pb-24 sm:pb-32 md:pb-48 lg:pb-56 xl:pb-64"
        >
        <svg
          class="mr-2 lg:mr-12 mt-2 lg:mt-12 absolute right-0 top-0"
          width="104px"
          height="95px"
          viewBox="0 0 104 95"
          version="1.1"
          xmlns="http://www.w3.org/2000/svg"
          xmlns:xlink="http://www.w3.org/1999/xlink"
          >
        <g
          id="Work-in-Progress"
          stroke="none"
          stroke-width="1"
          fill="none"
          fill-rule="evenodd"
          opacity="0.122837612"
          >
        <g transform="translate(-1139.000000, -175.000000)" fill="#FFFFFF">
        <g id="Group-5" transform="translate(1139.000000, 175.000000)">
        <path
          d="M1.99948119,4 C0.897535668,4 0,3.10246433 0,1.99948119 C0,0.896498054 0.897535668,0 1.99948119,0 C3.10350195,0 4,0.896498054 4,1.99948119 C4,3.10246433 3.10350195,4 1.99948119,4"
          id="Fill-46"
          ></path>
        <path
          d="M22,4 C20.8973029,4 20,3.10246433 20,1.99948119 C20,0.896498054 20.8973029,0 22,0 C23.1037344,0 24,0.896498054 24,1.99948119 C24,3.10246433 23.1037344,4 22,4"
          id="Fill-47"
          ></path>
        <path
          d="M42,4 C40.8962656,4 40,3.10246433 40,1.99948119 C40,0.896498054 40.8962656,0 42,0 C43.1016598,0 44,0.896498054 44,1.99948119 C44,3.10246433 43.1016598,4 42,4"
          id="Fill-48"
          ></path>
        <path
          d="M62.0005188,4 C60.8964981,4 60,3.10246433 60,1.99948119 C60,0.896498054 60.8964981,0 62.0005188,0 C63.1024643,0 64,0.896498054 64,1.99948119 C64,3.10246433 63.1024643,4 62.0005188,4"
          id="Fill-49"
          ></path>
        <path
          d="M81.9984436,4 C80.8964981,4 80,3.10246433 80,1.99948119 C80,0.896498054 80.8964981,0 81.9984436,0 C83.1024643,0 84,0.896498054 84,1.99948119 C84,3.10246433 83.1024643,4 81.9984436,4"
          id="Fill-50"
          ></path>
        <path
          d="M102,4 C100.89834,4 100,3.10246433 100,1.99948119 C100,0.896498054 100.89834,0 102,0 C103.103734,0 104,0.896498054 104,1.99948119 C104,3.10246433 103.103734,4 102,4"
          id="Fill-51"
          ></path>
        <path
          d="M1.99948119,22 C0.897535668,22 0,21.1024643 0,19.9994812 C0,18.8964981 0.897535668,18 1.99948119,18 C3.10350195,18 4,18.8964981 4,19.9994812 C4,21.1024643 3.10350195,22 1.99948119,22"
          id="Fill-52"
          ></path>
        <path
          d="M22,22 C20.8973029,22 20,21.1024643 20,19.9994812 C20,18.8964981 20.8973029,18 22,18 C23.1037344,18 24,18.8964981 24,19.9994812 C24,21.1024643 23.1037344,22 22,22"
          id="Fill-53"
          ></path>
        <path
          d="M42,22 C40.8962656,22 40,21.1024643 40,19.9994812 C40,18.8964981 40.8962656,18 42,18 C43.1016598,18 44,18.8964981 44,19.9994812 C44,21.1024643 43.1016598,22 42,22"
          id="Fill-54"
          ></path>
        <path
          d="M62.0005188,22 C60.8964981,22 60,21.1024643 60,19.9994812 C60,18.8964981 60.8964981,18 62.0005188,18 C63.1024643,18 64,18.8964981 64,19.9994812 C64,21.1024643 63.1024643,22 62.0005188,22"
          id="Fill-55"
          ></path>
        <path
          d="M81.9984436,22 C80.8964981,22 80,21.1024643 80,19.9994812 C80,18.8964981 80.8964981,18 81.9984436,18 C83.1024643,18 84,18.8964981 84,19.9994812 C84,21.1024643 83.1024643,22 81.9984436,22"
          id="Fill-56"
          ></path>
        <path
          d="M102,22 C100.89834,22 100,21.1024643 100,19.9994812 C100,18.8964981 100.89834,18 102,18 C103.103734,18 104,18.8964981 104,19.9994812 C104,21.1024643 103.103734,22 102,22"
          id="Fill-57"
          ></path>
        <path
          d="M1.99948119,40 C0.897535668,40 0,39.1026971 0,38 C0,36.8973029 0.897535668,36 1.99948119,36 C3.10350195,36 4,36.8973029 4,38 C4,39.1026971 3.10350195,40 1.99948119,40"
          id="Fill-58"
          ></path>
        <path
          d="M22,40 C20.8973029,40 20,39.1026971 20,38 C20,36.8973029 20.8973029,36 22,36 C23.1037344,36 24,36.8973029 24,38 C24,39.1026971 23.1037344,40 22,40"
          id="Fill-59"
          ></path>
        <path
          d="M42,40 C40.8962656,40 40,39.1026971 40,38 C40,36.8973029 40.8962656,36 42,36 C43.1016598,36 44,36.8973029 44,38 C44,39.1026971 43.1016598,40 42,40"
          id="Fill-60"
          ></path>
        <path
          d="M62.0005188,40 C60.8964981,40 60,39.1026971 60,38 C60,36.8973029 60.8964981,36 62.0005188,36 C63.1024643,36 64,36.8973029 64,38 C64,39.1026971 63.1024643,40 62.0005188,40"
          id="Fill-61"
          ></path>
        <path
          d="M81.9984436,40 C80.8964981,40 80,39.1026971 80,38 C80,36.8973029 80.8964981,36 81.9984436,36 C83.1024643,36 84,36.8973029 84,38 C84,39.1026971 83.1024643,40 81.9984436,40"
          id="Fill-62"
          ></path>
        <path
          d="M102,40 C100.89834,40 100,39.1026971 100,38 C100,36.8973029 100.89834,36 102,36 C103.103734,36 104,36.8973029 104,38 C104,39.1026971 103.103734,40 102,40"
          id="Fill-63"
          ></path>
        <path
          d="M1.99948119,59 C0.897535668,59 0,58.1026971 0,57 C0,55.8973029 0.897535668,55 1.99948119,55 C3.10350195,55 4,55.8973029 4,57 C4,58.1026971 3.10350195,59 1.99948119,59"
          id="Fill-64"
          ></path>
        <path
          d="M22,59 C20.8973029,59 20,58.1026971 20,57 C20,55.8973029 20.8973029,55 22,55 C23.1037344,55 24,55.8973029 24,57 C24,58.1026971 23.1037344,59 22,59"
          id="Fill-65"
          ></path>
        <path
          d="M42,59 C40.8962656,59 40,58.1026971 40,57 C40,55.8973029 40.8962656,55 42,55 C43.1016598,55 44,55.8973029 44,57 C44,58.1026971 43.1016598,59 42,59"
          id="Fill-66"
          ></path>
        <path
          d="M62.0005188,59 C60.8964981,59 60,58.1026971 60,57 C60,55.8973029 60.8964981,55 62.0005188,55 C63.1024643,55 64,55.8973029 64,57 C64,58.1026971 63.1024643,59 62.0005188,59"
          id="Fill-67"
          ></path>
        <path
          d="M81.9984436,59 C80.8964981,59 80,58.1026971 80,57 C80,55.8973029 80.8964981,55 81.9984436,55 C83.1024643,55 84,55.8973029 84,57 C84,58.1026971 83.1024643,59 81.9984436,59"
          id="Fill-68"
          ></path>
        <path
          d="M102,59 C100.89834,59 100,58.1026971 100,57 C100,55.8973029 100.89834,55 102,55 C103.103734,55 104,55.8973029 104,57 C104,58.1026971 103.103734,59 102,59"
          id="Fill-69"
          ></path>
        <path
          d="M1.99948119,77 C0.897535668,77 0,76.1026971 0,75 C0,73.8973029 0.897535668,73 1.99948119,73 C3.10350195,73 4,73.8973029 4,75 C4,76.1026971 3.10350195,77 1.99948119,77"
          id="Fill-70"
          ></path>
        <path
          d="M22,77 C20.8973029,77 20,76.1026971 20,75 C20,73.8973029 20.8973029,73 22,73 C23.1037344,73 24,73.8973029 24,75 C24,76.1026971 23.1037344,77 22,77"
          id="Fill-71"
          ></path>
        <path
          d="M42,77 C40.8962656,77 40,76.1026971 40,75 C40,73.8973029 40.8962656,73 42,73 C43.1016598,73 44,73.8973029 44,75 C44,76.1026971 43.1016598,77 42,77"
          id="Fill-72"
          ></path>
        <path
          d="M62.0005188,77 C60.8964981,77 60,76.1026971 60,75 C60,73.8973029 60.8964981,73 62.0005188,73 C63.1024643,73 64,73.8973029 64,75 C64,76.1026971 63.1024643,77 62.0005188,77"
          id="Fill-73"
          ></path>
        <path
          d="M81.9984436,77 C80.8964981,77 80,76.1026971 80,75 C80,73.8973029 80.8964981,73 81.9984436,73 C83.1024643,73 84,73.8973029 84,75 C84,76.1026971 83.1024643,77 81.9984436,77"
          id="Fill-74"
          ></path>
        <path
          d="M102,77 C100.89834,77 100,76.1026971 100,75 C100,73.8973029 100.89834,73 102,73 C103.103734,73 104,73.8973029 104,75 C104,76.1026971 103.103734,77 102,77"
          id="Fill-75"
          ></path>
        <path
          d="M1.99948119,95 C0.897535668,95 0,94.1024643 0,92.9994812 C0,91.8964981 0.897535668,91 1.99948119,91 C3.10350195,91 4,91.8964981 4,92.9994812 C4,94.1024643 3.10350195,95 1.99948119,95"
          id="Fill-76"
          ></path>
        <path
          d="M22,95 C20.8973029,95 20,94.1024643 20,92.9994812 C20,91.8964981 20.8973029,91 22,91 C23.1037344,91 24,91.8964981 24,92.9994812 C24,94.1024643 23.1037344,95 22,95"
          id="Fill-77"
          ></path>
        <path
          d="M42,95 C40.8962656,95 40,94.1024643 40,92.9994812 C40,91.8964981 40.8962656,91 42,91 C43.1016598,91 44,91.8964981 44,92.9994812 C44,94.1024643 43.1016598,95 42,95"
          id="Fill-78"
          ></path>
        <path
          d="M62.0005188,95 C60.8964981,95 60,94.1024643 60,92.9994812 C60,91.8964981 60.8964981,91 62.0005188,91 C63.1024643,91 64,91.8964981 64,92.9994812 C64,94.1024643 63.1024643,95 62.0005188,95"
          id="Fill-79"
          ></path>
        <path
          d="M81.9984436,95 C80.8964981,95 80,94.1024643 80,92.9994812 C80,91.8964981 80.8964981,91 81.9984436,91 C83.1024643,91 84,91.8964981 84,92.9994812 C84,94.1024643 83.1024643,95 81.9984436,95"
          id="Fill-80"
          ></path>
        <path
          d="M102,95 C100.89834,95 100,94.1024643 100,92.9994812 C100,91.8964981 100.89834,91 102,91 C103.103734,91 104,91.8964981 104,92.9994812 C104,94.1024643 103.103734,95 102,95"
          id="Fill-81"
          ></path>
        <polyline
          id="Fill-82"
          points="75 87 13 26 75 26 75 87"
          ></polyline>
        </g>
        </g>
        </g>
        </svg>
        <svg
          class="ml-2 lg:ml-12 mb-2 lg:mb-12 absolute bottom-0 left-0"
          width="104px"
          height="95px"
          viewBox="0 0 104 95"
          version="1.1"
          xmlns="http://www.w3.org/2000/svg"
          xmlns:xlink="http://www.w3.org/1999/xlink"
          >
        <g
          id="Work-in-Progress"
          stroke="none"
          stroke-width="1"
          fill="none"
          fill-rule="evenodd"
          opacity="0.122837612"
          >
        <g transform="translate(-206.000000, -596.000000)" fill="#FFFFFF">
        <g
          id="Group-5"
          transform="translate(258.000000, 643.500000) scale(-1, -1) translate(-258.000000, -643.500000) translate(206.000000, 596.000000)"
          >
        <path
          d="M1.99948119,4 C0.897535668,4 0,3.10246433 0,1.99948119 C0,0.896498054 0.897535668,0 1.99948119,0 C3.10350195,0 4,0.896498054 4,1.99948119 C4,3.10246433 3.10350195,4 1.99948119,4"
          id="Fill-46"
          ></path>
        <path
          d="M22,4 C20.8973029,4 20,3.10246433 20,1.99948119 C20,0.896498054 20.8973029,0 22,0 C23.1037344,0 24,0.896498054 24,1.99948119 C24,3.10246433 23.1037344,4 22,4"
          id="Fill-47"
          ></path>
        <path
          d="M42,4 C40.8962656,4 40,3.10246433 40,1.99948119 C40,0.896498054 40.8962656,0 42,0 C43.1016598,0 44,0.896498054 44,1.99948119 C44,3.10246433 43.1016598,4 42,4"
          id="Fill-48"
          ></path>
        <path
          d="M62.0005188,4 C60.8964981,4 60,3.10246433 60,1.99948119 C60,0.896498054 60.8964981,0 62.0005188,0 C63.1024643,0 64,0.896498054 64,1.99948119 C64,3.10246433 63.1024643,4 62.0005188,4"
          id="Fill-49"
          ></path>
        <path
          d="M81.9984436,4 C80.8964981,4 80,3.10246433 80,1.99948119 C80,0.896498054 80.8964981,0 81.9984436,0 C83.1024643,0 84,0.896498054 84,1.99948119 C84,3.10246433 83.1024643,4 81.9984436,4"
          id="Fill-50"
          ></path>
        <path
          d="M102,4 C100.89834,4 100,3.10246433 100,1.99948119 C100,0.896498054 100.89834,0 102,0 C103.103734,0 104,0.896498054 104,1.99948119 C104,3.10246433 103.103734,4 102,4"
          id="Fill-51"
          ></path>
        <path
          d="M1.99948119,22 C0.897535668,22 0,21.1024643 0,19.9994812 C0,18.8964981 0.897535668,18 1.99948119,18 C3.10350195,18 4,18.8964981 4,19.9994812 C4,21.1024643 3.10350195,22 1.99948119,22"
          id="Fill-52"
          ></path>
        <path
          d="M22,22 C20.8973029,22 20,21.1024643 20,19.9994812 C20,18.8964981 20.8973029,18 22,18 C23.1037344,18 24,18.8964981 24,19.9994812 C24,21.1024643 23.1037344,22 22,22"
          id="Fill-53"
          ></path>
        <path
          d="M42,22 C40.8962656,22 40,21.1024643 40,19.9994812 C40,18.8964981 40.8962656,18 42,18 C43.1016598,18 44,18.8964981 44,19.9994812 C44,21.1024643 43.1016598,22 42,22"
          id="Fill-54"
          ></path>
        <path
          d="M62.0005188,22 C60.8964981,22 60,21.1024643 60,19.9994812 C60,18.8964981 60.8964981,18 62.0005188,18 C63.1024643,18 64,18.8964981 64,19.9994812 C64,21.1024643 63.1024643,22 62.0005188,22"
          id="Fill-55"
          ></path>
        <path
          d="M81.9984436,22 C80.8964981,22 80,21.1024643 80,19.9994812 C80,18.8964981 80.8964981,18 81.9984436,18 C83.1024643,18 84,18.8964981 84,19.9994812 C84,21.1024643 83.1024643,22 81.9984436,22"
          id="Fill-56"
          ></path>
        <path
          d="M102,22 C100.89834,22 100,21.1024643 100,19.9994812 C100,18.8964981 100.89834,18 102,18 C103.103734,18 104,18.8964981 104,19.9994812 C104,21.1024643 103.103734,22 102,22"
          id="Fill-57"
          ></path>
        <path
          d="M1.99948119,40 C0.897535668,40 0,39.1026971 0,38 C0,36.8973029 0.897535668,36 1.99948119,36 C3.10350195,36 4,36.8973029 4,38 C4,39.1026971 3.10350195,40 1.99948119,40"
          id="Fill-58"
          ></path>
        <path
          d="M22,40 C20.8973029,40 20,39.1026971 20,38 C20,36.8973029 20.8973029,36 22,36 C23.1037344,36 24,36.8973029 24,38 C24,39.1026971 23.1037344,40 22,40"
          id="Fill-59"
          ></path>
        <path
          d="M42,40 C40.8962656,40 40,39.1026971 40,38 C40,36.8973029 40.8962656,36 42,36 C43.1016598,36 44,36.8973029 44,38 C44,39.1026971 43.1016598,40 42,40"
          id="Fill-60"
          ></path>
        <path
          d="M62.0005188,40 C60.8964981,40 60,39.1026971 60,38 C60,36.8973029 60.8964981,36 62.0005188,36 C63.1024643,36 64,36.8973029 64,38 C64,39.1026971 63.1024643,40 62.0005188,40"
          id="Fill-61"
          ></path>
        <path
          d="M81.9984436,40 C80.8964981,40 80,39.1026971 80,38 C80,36.8973029 80.8964981,36 81.9984436,36 C83.1024643,36 84,36.8973029 84,38 C84,39.1026971 83.1024643,40 81.9984436,40"
          id="Fill-62"
          ></path>
        <path
          d="M102,40 C100.89834,40 100,39.1026971 100,38 C100,36.8973029 100.89834,36 102,36 C103.103734,36 104,36.8973029 104,38 C104,39.1026971 103.103734,40 102,40"
          id="Fill-63"
          ></path>
        <path
          d="M1.99948119,59 C0.897535668,59 0,58.1026971 0,57 C0,55.8973029 0.897535668,55 1.99948119,55 C3.10350195,55 4,55.8973029 4,57 C4,58.1026971 3.10350195,59 1.99948119,59"
          id="Fill-64"
          ></path>
        <path
          d="M22,59 C20.8973029,59 20,58.1026971 20,57 C20,55.8973029 20.8973029,55 22,55 C23.1037344,55 24,55.8973029 24,57 C24,58.1026971 23.1037344,59 22,59"
          id="Fill-65"
          ></path>
        <path
          d="M42,59 C40.8962656,59 40,58.1026971 40,57 C40,55.8973029 40.8962656,55 42,55 C43.1016598,55 44,55.8973029 44,57 C44,58.1026971 43.1016598,59 42,59"
          id="Fill-66"
          ></path>
        <path
          d="M62.0005188,59 C60.8964981,59 60,58.1026971 60,57 C60,55.8973029 60.8964981,55 62.0005188,55 C63.1024643,55 64,55.8973029 64,57 C64,58.1026971 63.1024643,59 62.0005188,59"
          id="Fill-67"
          ></path>
        <path
          d="M81.9984436,59 C80.8964981,59 80,58.1026971 80,57 C80,55.8973029 80.8964981,55 81.9984436,55 C83.1024643,55 84,55.8973029 84,57 C84,58.1026971 83.1024643,59 81.9984436,59"
          id="Fill-68"
          ></path>
        <path
          d="M102,59 C100.89834,59 100,58.1026971 100,57 C100,55.8973029 100.89834,55 102,55 C103.103734,55 104,55.8973029 104,57 C104,58.1026971 103.103734,59 102,59"
          id="Fill-69"
          ></path>
        <path
          d="M1.99948119,77 C0.897535668,77 0,76.1026971 0,75 C0,73.8973029 0.897535668,73 1.99948119,73 C3.10350195,73 4,73.8973029 4,75 C4,76.1026971 3.10350195,77 1.99948119,77"
          id="Fill-70"
          ></path>
        <path
          d="M22,77 C20.8973029,77 20,76.1026971 20,75 C20,73.8973029 20.8973029,73 22,73 C23.1037344,73 24,73.8973029 24,75 C24,76.1026971 23.1037344,77 22,77"
          id="Fill-71"
          ></path>
        <path
          d="M42,77 C40.8962656,77 40,76.1026971 40,75 C40,73.8973029 40.8962656,73 42,73 C43.1016598,73 44,73.8973029 44,75 C44,76.1026971 43.1016598,77 42,77"
          id="Fill-72"
          ></path>
        <path
          d="M62.0005188,77 C60.8964981,77 60,76.1026971 60,75 C60,73.8973029 60.8964981,73 62.0005188,73 C63.1024643,73 64,73.8973029 64,75 C64,76.1026971 63.1024643,77 62.0005188,77"
          id="Fill-73"
          ></path>
        <path
          d="M81.9984436,77 C80.8964981,77 80,76.1026971 80,75 C80,73.8973029 80.8964981,73 81.9984436,73 C83.1024643,73 84,73.8973029 84,75 C84,76.1026971 83.1024643,77 81.9984436,77"
          id="Fill-74"
          ></path>
        <path
          d="M102,77 C100.89834,77 100,76.1026971 100,75 C100,73.8973029 100.89834,73 102,73 C103.103734,73 104,73.8973029 104,75 C104,76.1026971 103.103734,77 102,77"
          id="Fill-75"
          ></path>
        <path
          d="M1.99948119,95 C0.897535668,95 0,94.1024643 0,92.9994812 C0,91.8964981 0.897535668,91 1.99948119,91 C3.10350195,91 4,91.8964981 4,92.9994812 C4,94.1024643 3.10350195,95 1.99948119,95"
          id="Fill-76"
          ></path>
        <path
          d="M22,95 C20.8973029,95 20,94.1024643 20,92.9994812 C20,91.8964981 20.8973029,91 22,91 C23.1037344,91 24,91.8964981 24,92.9994812 C24,94.1024643 23.1037344,95 22,95"
          id="Fill-77"
          ></path>
        <path
          d="M42,95 C40.8962656,95 40,94.1024643 40,92.9994812 C40,91.8964981 40.8962656,91 42,91 C43.1016598,91 44,91.8964981 44,92.9994812 C44,94.1024643 43.1016598,95 42,95"
          id="Fill-78"
          ></path>
        <path
          d="M62.0005188,95 C60.8964981,95 60,94.1024643 60,92.9994812 C60,91.8964981 60.8964981,91 62.0005188,91 C63.1024643,91 64,91.8964981 64,92.9994812 C64,94.1024643 63.1024643,95 62.0005188,95"
          id="Fill-79"
          ></path>
        <path
          d="M81.9984436,95 C80.8964981,95 80,94.1024643 80,92.9994812 C80,91.8964981 80.8964981,91 81.9984436,91 C83.1024643,91 84,91.8964981 84,92.9994812 C84,94.1024643 83.1024643,95 81.9984436,95"
          id="Fill-80"
          ></path>
        <path
          d="M102,95 C100.89834,95 100,94.1024643 100,92.9994812 C100,91.8964981 100.89834,91 102,91 C103.103734,91 104,91.8964981 104,92.9994812 C104,94.1024643 103.103734,95 102,95"
          id="Fill-81"
          ></path>
        <polyline
          id="Fill-82"
          points="75 87 13 26 75 26 75 87"
          ></polyline>
        </g>
        </g>
        </g>
        </svg>
        <div class="w-11/12 sm:w-2/3 mb-5 sm:mb-10">
          <h1
            class="text-2xl sm:text-3xl text-center text-white font-bold leading-tight"
            >
            Stay on Top of Your Spending
          </h1>
          <p class="pt-4 w-10/12 text-center mx-auto text-white">
            Easily track your spending, set budgets, and reach your financial
            goals with our powerful expense management tool. Stay informed with
            real-time insights and achieve financial freedom. <br />
            Start now and watch your savings grow!
          </p>
        </div>
      </div>
      <div
        class="container mx-auto flex justify-center md:-mt-56 -mt-20 sm:-mt-40"
        >
        <div class="relative sm:w-2/3 w-11/12 relative">
          <div class="relative z-20 xl:py-12 xl:px-8 py-8 px-4">
            <img src="./images/picMgm1.jpg" alt="" />
          </div>
        </div>
      </div>
    </div>

    <!--Section one ends-->
    <!--Features one-->
    <div class="bg-gray-200 mt-32">
      <section class="max-w-8xl mx-auto container pt-16">
        <p class="pb-2 text-center text-gray-800 text-4xl font-bold">
          Begin your journey to financial freedom and prosperity in three simple
          steps:
        </p>
        <p class="pb-4 text-center text-gray-400"></p>
        <div class="flex flex-col md:flex-row md:items-center mt-8">
          <div class="w-full md:w-1/2 mt-8 md:mt-0 mr-4">
            <div class="px-4 md:px-12 py-10 rounded">
              <div class="flex pb-10 items-center">
                <div
                  class="mr-2 h-16 w-16 rounded-full flex items-center justify-center"
                  >
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width="20"
                    height="20"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="var(--logobody1)"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    >
                  <path
                    d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"
                    ></path>
                  </svg>
                </div>
                <div>
                  <h4 class="text-lg font-bold leading-tight text-gray-800">
                    <strong>Record Your Daily Transactions</strong><br />
                  </h4>
                  <p class="text-base text-gray-600 leading-normal">
                    Track your daily expenses and manage your cash flow
                    effectively with ease.
                  </p>
                </div>
              </div>
              <div class="flex pb-10 items-center">
                <div
                  class="mr-2 h-16 w-16 rounded-full flex items-center justify-center"
                  >
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width="50"
                    height="20"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="var(--logobody1)"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    >
                  <line x1="4" y1="21" x2="4" y2="14"></line>
                  <line x1="4" y1="10" x2="4" y2="3"></line>
                  <line x1="12" y1="21" x2="12" y2="12"></line>
                  <line x1="12" y1="8" x2="12" y2="3"></line>
                  <line x1="20" y1="21" x2="20" y2="16"></line>
                  <line x1="20" y1="12" x2="20" y2="3"></line>
                  <line x1="1" y1="14" x2="7" y2="14"></line>
                  <line x1="9" y1="8" x2="15" y2="8"></line>
                  <line x1="17" y1="16" x2="23" y2="16"></line>
                  </svg>
                </div>
                <div>
                  <h4 class="text-lg font-bold leading-tight text-gray-800">
                    <strong
                      >Obtain Transaction Summaries and Detailed Reports</strong
                    >
                  </h4>
                  <p class="text-base text-gray-600 leading-normal">
                    Gain valuable insights through transaction summaries and
                    comprehensive reports, categorized by parties and purposes,
                    illustrated with colorful charts.
                  </p>
                </div>
              </div>
              <div class="flex pb-10 items-center">
                <div
                  class="mr-2 h-16 w-16 rounded-full flex items-center justify-center"
                  >
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width="20"
                    height="20"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="var(--logobody1)"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    >
                  <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
                  <polyline points="22 4 12 14.01 9 11.01"></polyline>
                  </svg>
                </div>
                <div>
                  <h4 class="text-lg font-bold leading-tight text-gray-800">
                    <strong>Make Informed Financial Decisions</strong>
                  </h4>
                  <p class="text-base text-gray-600 leading-normal">
                    Utilize these insights to make smarter and more informed
                    financial decisions.
                  </p>
                </div>
              </div>
            </div>
          </div>
          <div class="flex w-full md:w-1/2 px-4 md:pr-12">
            <img src="./images/graph.png" alt="" class="h-auto" />
          </div>
        </div>
      </section>
    </div>
    <!--Features one ends-->

    <!--Features three -->
    <div class="bg-gray-200">
      <section class="max-w-8xl mx-auto container pt-16">
        <p class="pb-2 text-center text-gray-800 text-4xl font-bold">
          WE TAKE CARE OF THE TECH, SO YOU CAN FOCUS ON YOUR FINANCE
        </p>
        <p class="pb-4 text-center text-gray-400"></p>
        <div class="flex flex-col md:flex-row md:items-center mt-8">
          <div class="w-full md:w-1/2 mt-8 md:mt-0 mr-4">
            <div class="px-4 md:px-12 py-10 rounded">
              <div class="flex pb-10 items-center">
                <div
                  class="mr-2 h-16 w-16 rounded-full flex items-center justify-center"
                  >
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width="20"
                    height="20"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="var(--logobody1)"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    >
                  <path
                    d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"
                    ></path>
                  </svg>
                </div>
                <div>
                  <h4 class="text-lg font-bold leading-tight text-gray-800">
                    Intuitive and beautiful UI
                  </h4>
                  <p class="text-base text-gray-600 leading-normal"></p>
                </div>
              </div>
              <div class="flex pb-10 items-center">
                <div
                  class="mr-2 h-16 w-16 rounded-full flex items-center justify-center"
                  >
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width="20"
                    height="20"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="var(--logobody1)"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    >
                  <line x1="4" y1="21" x2="4" y2="14"></line>
                  <line x1="4" y1="10" x2="4" y2="3"></line>
                  <line x1="12" y1="21" x2="12" y2="12"></line>
                  <line x1="12" y1="8" x2="12" y2="3"></line>
                  <line x1="20" y1="21" x2="20" y2="16"></line>
                  <line x1="20" y1="12" x2="20" y2="3"></line>
                  <line x1="1" y1="14" x2="7" y2="14"></line>
                  <line x1="9" y1="8" x2="15" y2="8"></line>
                  <line x1="17" y1="16" x2="23" y2="16"></line>
                  </svg>
                </div>
                <div>
                  <h4 class="text-lg font-bold leading-tight text-gray-800">
                    Simple setup and administration
                  </h4>
                  <p class="text-base text-gray-600 leading-normal"></p>
                </div>
              </div>
              <div class="flex pb-10 items-center">
                <div
                  class="mr-2 h-16 w-16 rounded-full flex items-center justify-center"
                  >
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width="20"
                    height="20"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="var(--logobody1)"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    >
                  <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
                  <polyline points="22 4 12 14.01 9 11.01"></polyline>
                  </svg>
                </div>
                <div>
                  <h4 class="text-lg font-bold leading-tight text-gray-800">
                    Just the right features
                  </h4>
                  <p class="text-base text-gray-600 leading-normal"></p>
                </div>
              </div>
            </div>
          </div>
          <div class="flex w-full md:w-1/2 px-4 md:pr-12">
            <img
              src="./images/Report.png"
              alt=""
              class="h-auto xl:w-5/6"
              />
          </div>
        </div>
      </section>
    </div>
    <!--Features one ends-->

    <!--Footer starts-->

    <div class="pt-16">
      <div
        class="w-full border-gray-300 border-t lg:w-11/12 md:w-11/12 lg:mx-auto md:mx-auto"
        >
        <div class="container mx-auto py-12">
          <div class="xl:flex lg:flex md:flex pt-6">
            <div class="w-11/12 xl:w-3/6 lg:w-2/5 mx-auto lg:mx-0 xl:mx-0">
              <div class="flex items-center mb-6 xl:mb-0 lg:mb-0">
                <svg
                  width="199px"
                  height="48px"
                  viewBox="0 0 199 48"
                  version="1.1"
                  xmlns="http://www.w3.org/2000/svg"
                  xmlns:xlink="http://www.w3.org/1999/xlink"
                  >
                <g
                  id="Work-in-Progress"
                  stroke="none"
                  stroke-width="1"
                  fill="none"
                  fill-rule="evenodd"
                  >
                <g
                  id="Header---3-Copy"
                  transform="translate(-146.000000, -31.000000)"
                  >
                <g
                  id="Group-4"
                  transform="translate(146.000000, 31.000000)"
                  >
                <g id="Group-6">
                <text
                  id="Retra-Insights"
                  font-family="Body"
                  font-size="20"
                  font-weight="400"
                  letter-spacing="0.1"
                  fill="#2D3748"
                  >
                <tspan x="60" y="30">CoinCare</tspan>
                </text>
                <g id="Group">
                <polyline
                  id="Fill-18"
                  fill="var(--logo1)"
                  points="36 5.99986676 24 0 24 12 36 5.99986676"
                  ></polyline>
                <polyline
                  id="Fill-19"
                  fill="var(--logo2)"
                  points="48 12.0001332 36 6 36 18 48 12.0001332"
                  ></polyline>
                <polyline
                  id="Fill-20"
                  fill="var(--logo1)"
                  points="48 24 48 12 36 17.9999334 48 24"
                  ></polyline>
                <polyline
                  id="Fill-21"
                  fill="var(--logo3)"
                  points="12 6 12 18 24 12.0001332 12 6"
                  ></polyline>
                <polyline
                  id="Fill-22"
                  fill="var(--logo2)"
                  points="24 0 12 5.99986676 24 12 24 0"
                  ></polyline>
                <polyline
                  id="Fill-23"
                  fill="var(--logo3)"
                  points="0 12 0 24 12 17.9999334 0 12"
                  ></polyline>
                <polyline
                  id="Fill-24"
                  fill="var(--logo4)"
                  points="12 6 0 12.0001332 12 18 12 6"
                  ></polyline>
                <polyline
                  id="Fill-25"
                  fill="var(--logo1)"
                  points="24 24.0000666 12 18 12 30 24 24.0000666"
                  ></polyline>
                <polyline
                  id="Fill-26"
                  fill="var(--logo3)"
                  points="0 24 0 36 12 29.9999334 0 24"
                  ></polyline>
                <polyline
                  id="Fill-27"
                  fill="var(--logo2)"
                  points="12 18 0 24.0000666 12 30 12 18"
                  ></polyline>
                <polyline
                  id="Fill-28"
                  fill="var(--logo4)"
                  points="12 30 0 35.9999334 12 42 12 30"
                  ></polyline>
                <polyline
                  id="Fill-29"
                  fill="var(--logo1)"
                  points="24 48 36 42.0001332 24 36 24 48"
                  ></polyline>
                <polyline
                  id="Fill-30"
                  fill="var(--logo2)"
                  points="24 36 12 42.0001332 24 48 24 36"
                  ></polyline>
                <polyline
                  id="Fill-31"
                  fill="var(--logo2)"
                  points="48 24 36 18 36 30 48 24"
                  ></polyline>
                <polyline
                  id="Fill-32"
                  fill="var(--logo3)"
                  points="48 36 48 24 36 29.9999334 48 36"
                  ></polyline>
                <polyline
                  id="Fill-33"
                  fill="var(--logo4)"
                  points="36 42 48 35.9999334 36 30 36 42"
                  ></polyline>
                <polyline
                  id="Fill-34"
                  fill="var(--logo3)"
                  points="36 18 24 24 36 30 36 18"
                  ></polyline>
                <polyline
                  id="Fill-35"
                  fill="var(--logo3)"
                  points="36 30 24 35.9999334 36 42 36 30"
                  ></polyline>
                </g>
                </g>
                </g>
                </g>
                </g>
                </svg>
              </div>
            </div>
            <div
              class="w-11/12 xl:w-1/6 lg:w-2/5 mx-auto lg:mx-0 xl:mx-0 pt-3 xl:flex xl:justify-end pl-3 sm:pl-0"
              >
              <ul>
                <li class="text-gray-800 font-bold text-xl mb-6">Community</li>
                <li class="text-base text-gray-600 hover:text-gray-700 mb-5">
                  <a href="#">About Us</a>
                </li>
                <li class="text-base text-gray-600 hover:text-gray-700 mb-5">
                  <a href="#">Guidelines and how to</a>
                </li>
              </ul>
            </div>
            <div
              class="w-11/12 xl:w-1/6 lg:w-2/5 mx-auto lg:mx-0 xl:mx-0 pt-3 xl:flex xl:justify-end pl-3 sm:pl-0"
              >
              <ul>
                <li class="text-gray-800 font-bold text-xl mb-6">
                  Getting Started
                </li>
                <li class="text-base text-gray-600 hover:text-gray-700 mb-5">
                  <a href="#">About Us</a>
                </li>
                <li class="text-base text-gray-600 hover:text-gray-700 mb-5">
                  <a href="#">Guidelines and how to</a>
                </li>
              </ul>
            </div>
            <div
              class="w-11/12 xl:w-1/6 lg:w-2/5 mx-auto lg:mx-0 xl:mx-0 pt-3 xl:flex xl:justify-end pl-3 sm:pl-0"
              >
              <ul>
                <li class="text-gray-800 font-bold text-xl mb-6">Resources</li>
                <li class="text-base text-gray-600 hover:text-gray-700 mb-5">
                  <a href="#">Accessibility</a>
                </li>
                <li class="text-base text-gray-600 hover:text-gray-700 mb-5">
                  <a href="#">Usability</a>
                </li>
              </ul>
            </div>
          </div>
          <div
            class="xl:flex flex-wrap justify-between xl:mt-24 mt-16 pb-6 pl-3 sm:pl-0"
            >
            <div class="w-11/12 xl:w-2/6 mx-auto lg:mx-0 xl:mx-0 mb-6 xl:mb-0">
              <p class="text-gray-800 text-base">
                2024 CoinCare. All Rights Reserved
              </p>
            </div>
            <div
              class="w-11/12 xl:w-2/6 mx-auto lg:mx-0 xl:mx-0 mb-6 lg:mb-0 xl:mb-0"
              >
              <ul class="xl:flex lg:flex md:flex sm:flex justify-between">
                <li
                  class="text-gray-800 hover:text-gray-900 text-base mb-4 sm:mb-0"
                  >
                  <a href="#">Terms of service</a>
                </li>
                <li
                  class="text-gray-800 hover:text-gray-900 text-base mb-4 sm:mb-0"
                  >
                  <a href="#">Privacy Policy</a>
                </li>
                <li
                  class="text-gray-800 hover:text-gray-900 text-base mb-4 sm:mb-0"
                  >
                  <a href="#">Security</a>
                </li>
                <li
                  class="text-gray-800 hover:text-gray-900 text-base mb-4 sm:mb-0"
                  >
                  <a href="#">Sitemap</a>
                </li>
              </ul>
            </div>
            <div
              class="w-11/12 xl:w-1/6 lg:w-1/6 sm:w-11/12 mx-auto lg:mx-0 xl:mx-0 mb-6 lg:mb-0 xl:mb-0 mt-8 lg:mt-8 xl:mt-0"
              >
              <div
                class="flex justify-start sm:justify-start xl:justify-end space-x-6 pr-2 xl:pr-0 lg:pr-0 md:pr-0 sm:pr-0"
                >
                <div>
                  <a href="#">
                    <svg
                      aria-label="Twitter"
                      xmlns="http://www.w3.org/2000/svg"
                      width="24"
                      height="24"
                      viewBox="0 0 24 24"
                      fill="none"
                      stroke="#718096"
                      stroke-width="1.5"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      class="feather feather-twitter"
                      >
                    <path
                      d="M23 3a10.9 10.9 0 0 1-3.14 1.53 4.48 4.48 0 0 0-7.86 3v1A10.66 10.66 0 0 1 3 4s-4 9 5 13a11.64 11.64 0 0 1-7 2c9 5 20 0 20-11.5a4.5 4.5 0 0 0-.08-.83A7.72 7.72 0 0 0 23 3z"
                      ></path>
                    </svg>
                  </a>
                </div>
                <div>
                  <a href="#">
                    <svg
                      aria-label="Instagram"
                      xmlns="http://www.w3.org/2000/svg"
                      width="24"
                      height="24"
                      viewBox="0 0 24 24"
                      fill="none"
                      stroke="#718096"
                      stroke-width="1.5"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      class="feather feather-instagram"
                      >
                    <rect
                      x="2"
                      y="2"
                      width="20"
                      height="20"
                      rx="5"
                      ry="5"
                      ></rect>
                    <path
                      d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"
                      ></path>
                    <line x1="17.5" y1="6.5" x2="17.51" y2="6.5"></line>
                    </svg>
                  </a>
                </div>
                <div>
                  <a href="#">
                    <svg
                      aria-label="Dribble"
                      xmlns="http://www.w3.org/2000/svg"
                      class="icon icon-tabler icon-tabler-dribbble"
                      width="24"
                      height="24"
                      viewBox="0 0 24 24"
                      stroke-width="1.5"
                      stroke="#718096"
                      fill="none"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      >
                    <path stroke="none" d="M0 0h24v24H0z" />
                    <circle cx="12" cy="12" r="9" />
                    <path d="M9 3.6c5 6 7 10.5 7.5 16.2" />
                    <path d="M6.4 19c3.5-3.5 6-6.5 14.5-6.4" />
                    <path d="M3.1 10.75c5 0 9.814-.38 15.314-5" />
                    </svg>
                  </a>
                </div>
                <div>
                  <a href="#">
                    <svg
                      aria-label="Github"
                      xmlns="http://www.w3.org/2000/svg"
                      width="24"
                      height="24"
                      viewBox="0 0 24 24"
                      fill="none"
                      stroke="#718096"
                      stroke-width="1.5"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      class="feather feather-github"
                      >
                    <path
                      d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"
                      ></path>
                    </svg>
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!--Footer ends-->
    <script src="https://unpkg.com/flickity@2/dist/flickity.pkgd.min.js"></script>
    <script src="./js/indexscript.js"></script>
  </body>
</html>
