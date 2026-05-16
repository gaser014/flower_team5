import 'package:easy_localization/easy_localization.dart';

class AppStrings {
  AppStrings._();

  // API Failures
  static String get connectionError => "Failed to connect to the server".tr();
  static String get connectionTimeout => "Failed to connect to the server".tr();
  static String get cancelled => "The request to the server was cancelled".tr();
  static String get unknownError =>
      "An unexpected error occurred while connecting to the server, please try again later!"
          .tr();
  static String get serverError => "Server error, please try again later!".tr();
  static String get receiveTimeout =>
      "Failed to connect to the server while receiving data".tr();
  static String get sendTimeout =>
      "Failed to connect to the server while sending data".tr();
  static String get unexpectedError => "An unexpected error occurred".tr();
  static String get badCertificate => "Invalid certificate from the server".tr();
  static String get expiredToken => "Session expired, please log in again".tr();

  // Custom Widgets
  static String get loadingAccessibilityLabel => "Loading...".tr();
  static String get retryButton => "Retry...".tr();
  static String get invalidCode => "Invalid code".tr();
  static String get occasion => "Occasion".tr();
  static String get occasionSubTitle =>
      "Bloom with our exquisite best sellers".tr();
  static String get enterUserName => "Enter first name".tr();
  static String get codeNotReceived => "Didn't receive the code?".tr();
  static String get resendCodeIn => "Resend in {}".tr();
  static String get resend => "Resend".tr();
  static String get noProductsFound => "No products found".tr();
  static String get enterEmail => "Enter you email".tr();
  static String get password => "Password".tr();
  static String get phoneNumber => "Phone Number".tr();
  static String get enterPhoneNumber => "01012345678".tr();
  static String get search => "Search".tr();

  // Date Time
  static String get amLong => "AM".tr();
  static String get pmLong => "PM".tr();
  static String get ago => "ago".tr();
  static String get seconds => "seconds".tr();
  static String get passwordHint => "Password is required".tr();
  static String get second => "second".tr();
  static String get twoSeconds => "two seconds".tr();
  static String get hourLabel => "hour".tr();
  static String get hour => "hour".tr();
  static String get twoHours => "two hours".tr();
  static String get hours => "hours".tr();
  static String get day => "day".tr();
  static String get twoDays => "two days".tr();
  static String get days => "days".tr();
  static String get week => "week".tr();
  static String get twoWeeks => "two weeks".tr();
  static String get weeks => "weeks".tr();
  static String get months => "months".tr();
  static String get month => "month".tr();
  static String get year => "year".tr();
  static String get twoYears => "two years".tr();
  static String get years => "years".tr();
  static String get minutes => "minutes".tr();
  static String get twoMinutes => "two minutes".tr();
  static String get minute => "minute".tr();
  static String get amShort => "AM".tr();
  static String get pmShort => "PM".tr();
  static String get justNow => "just now".tr();
  static String get remaining => "remaining".tr();

  // Global
  static String get currencyIQD => "IQD".tr();
  static String get ok => "OK".tr();
  static String get confirm => "Confirm".tr();
  static String get cancel => "Cancel".tr();
  static String get close => "Close".tr();
  static String get yes => "Yes".tr();
  static String get no => "No".tr();
  static String get error => "Error".tr();
  static String get success => "Success".tr();
  static String get warning => "Warning".tr();
  static String get info => "Info".tr();
  static String get submit => "Submit".tr();
  static String get loading => "Loading...".tr();
  static String get product => "Product".tr();
  static String get oneProduct => "One product".tr();
  static String get twoProducts => "Two products".tr();
  static String get products => "Products".tr();
  static String get noInternet => "No internet connection!".tr();
  static String get changeImage => "Change image".tr();
  static String get removeImage => "Remove image".tr();
  static String get addImage => "Add image".tr();
  static String get camera => "Camera".tr();
  static String get gallery => "Gallery".tr();
  static String get save => "Save".tr();
  static String get version => "Version".tr();
  static String get appName => "Flowers".tr();
  static String get appSlogan => "The most beautiful flowers to your doorstep".tr();
  static String get tryAgain => "Try again".tr();
  static String get appTitle => "Flowery".tr();

  // Validations
  static String get emailRequired => "Email is required".tr();
  static String get email => "email".tr();
  static String get emailInvalid => "Please enter a valid email address".tr();
  static String get usernameRequired => "Username is required".tr();
  static String get firstNameRequired => "First name is required".tr();
  static String get lastNameRequired => "Last name is required".tr();
  static String get passwordRequired => "Password is required".tr();
  static String get confirmPasswordRequired => "Confirm password is required".tr();
  static String get confirmPasswordMismatch =>
      "Confirm password does not match".tr();
  static String get phoneRequired => "Phone number is required".tr();
  static String get pinRequired => "Verification code is required".tr();

  // Login
  static String get loginTitle => "Login".tr();
  static String get loginSubtitle => "Welcome back! Please login to continue".tr();
  static String get rememberMe => "Remember me".tr();
  static String get forgotPassword => "Forgot password?".tr();
  static String get loginButton => "Login".tr();
  static String get continueAsGuest => "Continue as guest".tr();
  static String get noAccount => "Don't have an account? ".tr();
  static String get signUp => "Sign up".tr();
  static String get loginSuccessfully => "Login successfully".tr();
  static String get loginError => "Invalid Phone Number or Password".tr();

  // Register
  static String get registerTitle => "Sign up".tr();
  static String get genderLabel => "Gender".tr();
  static String get maleLabel => "Male".tr();
  static String get femaleLabel => "Female".tr();
  static String get termsConditionsPart1 =>
      "By creating an account, you agree to our ".tr();
  static String get termsConditionsPart2 => "Terms & Conditions".tr();

  // Product Details
  static String get inStock => "In stock".tr();
  static String get description => "Description".tr();
  static String get bouquetInclude => "Bouquet include".tr();
  static String get addToCart => "Add to cart".tr();

  // Cart
  static String get cartTitle => "Cart".tr();
  static String get checkout => "Checkout".tr();
  static String get emptyCart => "Your cart is empty".tr();
  static String get itemAddedSuccess => "Item added successfully to your cart".tr();

  // Checkout
  static String get deliveryTime => "Delivery Time".tr();
  static String get deliveryFee => "Delivery Fee".tr();
  static String get totalPrice => "Total".tr();
  static String get placeOrder => "Place Order".tr();
  static String get paymentMethod => "Payment method".tr();
  static String get cash => "Cash".tr();
  static String get creditCard => "Credit Card".tr();

  // Profile & Address
  static String get myOrders => "My orders".tr();
  static String get savedAddresses => "Saved addresses".tr();
  static String get logout => "Logout".tr();
  static String get editProfile => "Edit profile".tr();
  static String get addNewAddress => "Add New Address".tr();
  static String get notification => "Notification".tr();
  static String get language => "Language".tr();
  static String get aboutUs => "About us".tr();
  static String get termsAndConditions => "Terms & conditions".tr();
  static String get arabic => "Arabic".tr();
  static String get english => "English".tr();
  static String get changeLanguage => "Change Language".tr();

  // Remaining values from provided dart source
  static String get setPassword1ConditionError =>
      "Add at least one lowercase letter to make it stronger".tr();
  static String get setPassword2ConditionError =>
      "Add at least one uppercase letter to make it stronger".tr();
  static String get setPassword3ConditionError =>
      "Add at least one number to make it stronger".tr();
  static String get setPassword4ConditionError =>
      "Add a special character to make it more secure".tr();
  static String get setPassword5ConditionError =>
      "Password should be between 6 and 30 characters".tr();
  static String get confirmPassword => "Please confirm your password".tr();
  static String get confirmPasswordInvalid =>
      "Passwords don't match, please try again".tr();
  static String get phoneInvalid => "Please enter a valid phone number".tr();
  static String get nameRequired => "Please enter your name".tr();
  static String get pinInvalid => "Please enter a valid PIN".tr();
  static String get profileImage => "Please add a profile image".tr();
  static String get usernameInvalid =>
      "Username can only contain letters, numbers, dots and underscores".tr();
  static String get username => "Username".tr();
  static String get egyptianPhoneInvalid =>
      "Phone must start with 01 and be 11 digits".tr();
  static String get didntReceiveCode => "Didn't receive code?".tr();
  static String get resendIn => "Resend in".tr();
  static String get requestCancelled => "Request cancelled".tr();
  static String get apiServerError => "Server error".tr();
  static String get sessionExpired => "Session expired, please login again".tr();
  static String get somethingWentWrong =>
      "Something went wrong, please try again".tr();

  static String get token => "token".tr();
  static String get user => "user".tr();

  static String questionOf({required int current, required int total}) =>
      "question $current of $total".tr(args: [current.toString(), total.toString()]);
}
