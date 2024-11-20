const registerForm = document.querySelector("#register-form");
const loginForm = document.querySelector("#login-form");
const btn = document.getElementById("submitButton");
const nameInput = document.getElementById("user_name");
const emailInput = document.getElementById("email");
const passwordInput = document.getElementById("password");
const confirmPasswordInput = document.getElementById("password2");
const nameError = document.getElementById("name-error");
const emailError = document.getElementById("email-error");
const passwordError = document.getElementById("password-error");
const confirmPasswordError = document.getElementById("password2-error");

console.log(emailInput);
console.log(passwordInput);

registerForm.addEventListener("submit", function (event) {
  event.preventDefault();
  if (
    validateName() &&
    validateEmail() &&
    validatePassword() &&
    validateConfirmPassword()
  ) {
    registerForm.submit();
  }
});
loginForm.addEventListener("submit", function (event) {
  event.preventDefault();
  if (
    validateEmail() &&
    validateLoginPassword()
  ) {
    loginForm.submit();
  }
});

function validateName() {
  const namevalue = nameInput.value.trim();
  const nameregex = /^[a-zA-Z\s]+$/;
  if (namevalue === "") {
    setError(nameInput, " Name needs to be filled out", "name-error");
    return false;
  } else if (!nameregex.test(namevalue)) {
    setError(nameInput, " Name shouldn't contain number.", "name-error");
    return false;
  } else {
    removeError(nameInput, "name-error");
    return true;
  }
}

function validateEmail() {
  const emailValue = emailInput.value.trim();
  const emailRegex = /^[A-Za-z][A-Za-z0-9._%+-]*@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;
  if (emailValue === "") {
    setError(emailInput, " Email is required", "email-error");
  } else if (!emailRegex.test(emailValue)) {
    setError(emailInput, " Invalid email format!", "email-error");
  } else {
    removeError(emailInput, "email-error");
    return true;
  }
}

function validateLoginPassword() {
  const passValue = passwordInput.value.trim();
  const passRegex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_]).{8,}$/;
  if (passValue === "") {
    setError(passwordInput, " Password is required", "password-error");
    return false;
  } else if (passValue.length < 8) {
    setError(
      passwordInput,
      " Invalid Password",
      "password-error"
    );
    return false;
  }
  else {
    removeError(passwordInput, "password-error");
    return true;
  }
}


function validatePassword() {
  const passValue = passwordInput.value.trim();
  const passRegex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_]).{8,}$/;
  if (passValue === "") {
    setError(passwordInput, " Password is required", "password-error");
    return false;
  } else if (passValue.length < 8) {
    setError(
      passwordInput,
      " Password must be atleast 8 characters",
      "password-error"
    );
    return false;
  }
   else if (!passRegex.test(passValue)) {
     setError(
       passwordInput,
       "Password must contain at least least one uppercase letter, one lowercase letter, one digit, and one special character.",
       "password-error"
     );
     return false;
   }
  else {
    removeError(passwordInput, "password-error");
    return true;
  }
}

function validateConfirmPassword() {
  const confirmPassValue = confirmPasswordInput.value.trim();
  const passValue = passwordInput.value.trim();
  if (confirmPassValue === "") {
    setError(
      confirmPasswordInput,
      " Confirm password is required",
      "password2-error"
    );
    return false;
  } else if (confirmPassValue !== passValue) {
    setError(
      confirmPasswordInput,
      " Passwords do not match",
      "password2-error"
    );
    return false;
  } else {
    removeError(confirmPasswordInput, "password2-error");
    return true;
  }
}

// Set error message
function setError(inputElement, message, errorId) {
  const errorElement = document.getElementById(errorId);
  errorElement.textContent = message;
  errorElement.classList.add("error-message");
}

// Remove error message
function removeError(inputElement, errorId) {
  const errorElement = document.getElementById(errorId);
  errorElement.textContent = "";
  errorElement.classList.remove("error-message");
}

function togglePassword() {
  const x = passwordInput;
  const show = document.getElementById("hideopen");
  const hide = document.getElementById("hideclose");
  if (x.type === "password") {
    x.type = "text";
    show.style.display = "block";
    hide.style.display = "none";
  } else {
    x.type = "password";
    show.style.display = "none";
    hide.style.display = "block";
  }
}
function toggleCPassword() {
  const y = confirmPasswordInput;
  const show = document.getElementById("Chideopen");
  const hide = document.getElementById("Chideclose");
  if (y.type === "password") {
    y.type = "text";
    show.style.display = "block";
    hide.style.display = "none";
  } else {
    y.type = "password";
    show.style.display = "none";
    hide.style.display = "block";
  }
}