import 'package:flutter/material.dart';

// API
const apiUrl = "https://datacollectorbackend.azurewebsites.net";

// Colors
Color appBgColor = Colors.blue[50];
Color appBarColor = Colors.blue[800];
Color appBarTextColor = Colors.white;
Color appBtnDefaultColor = Colors.blue[300];
Color appBtnSecondColor = Colors.orange[300];
Color labelColor = Colors.black54;

// Strings
const appTitle = "මනුස්සකම";
const usernameHintText = "Email / විද්යුත් තැපැල් ලිපිනය";
const passwordHintText = "Password / මුර පදය ";
const fullNameHintText = "Full Name / සම්පූර්ණ නම ";
const loginButtonText = "Login / ඇතුල් වන්න";
const registerButtonText = "Register / ලියාපදිංචි වන්න";
const registerSuccessText = "Registration Success / ලියාපදිංචිය සාර්ථකයි";
const registerSuccessButtonText = "Continue / ඉදිරියට යමු";
const addNewEntryText = "Add New Entry / අලුතින් එකතු කරන්න";
const homepageTitleText = "Welcome / සාදරයෙන් පිළිගනිමු";
const addNewTitleText = "Add New Voter / නව ඡන්ද දායකයෙක්";
const registerWithUsText = "Register Now / අප හා සම්බන්ධ වන්න";

const voterRegFirstName = "First Name / මුල් නම*";
const voterRegLastName = "Last Name / වාසගම";
const voterRegAddress = "Address / ලිපිනය*";
const voterRegCity = "City / නගරය";
const voterRegPostalCode = "Postal Code / තැපැල් කේතය";
const voterRegPollingDivision = "Polling Divison / ආසනය";
const voterRegPollingCentre = "Polling Center / ඡන්ද මධ්‍යස්ථානය";
const voterRegEmail = "Email / විද්යුත් තැපැල් ලිපිනය*";
const voterRegPhone = "Contact No / දුරකථන අංකය*";
const voterRegConfirm = "Confirm / තහවුරු කරන්න";
const voterRegSubmit = "Submit / ඉදිරිපත් කරන්න";

// Images
Image appLogo = Image.asset("assets/logo.png");

// Sizes
const bigRadius = 72.0;
const buttonHeight = 24.0;

// Pages
const loginPageTag = "Login Page";
const homePageTag = "Home Page";
const registerPageTag = "Register Page";
const registerSuccessTag = "Register Success Page";
const addNewVoterTag = "Add New Page";
