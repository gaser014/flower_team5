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

  // Best Seller
  static const String bestSeller = "Best Seller";
  static const String bestSellerSubtitle = "Find your favorite products";

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
  static String get confirmPassword => "Confirm password".tr();
  static String get firstName => "First name".tr();
  static String get firstNameHint => "Enter first name".tr();
  static String get lastName => "Last name".tr();
  static String get lastNameHint => "Enter last name".tr();
  static String get genderLabel => "Gender".tr();
  static String get maleLabel => "Male".tr();
  static String get femaleLabel => "Female".tr();
  static String get termsAndConditionsView =>
      'By creating an account, you agree to use the application in a lawful manner, provide accurate information, and respect all applicable rules. We may update these terms from time to time, and your continued use of the app means you accept those updates.'.tr();
  static String get termsConditionsPart1 =>
      "By creating an account, you agree to our ".tr();
  static String get termsConditionsPart2 => "Terms & Conditions".tr();
  static String get accountCreatedSuccessfully =>
      "Account created successfully".tr();

  // Product
  static String get currencyEGP => "EGP".tr();
  static String get allPricesIncludeTax => "All prices include tax".tr();
  static String get productHeroTag => "product_".tr();

  // Product Details
  static String get inStock => "In stock".tr();
  static String get description => "Description".tr();
  static String get bouquetInclude => "Bouquet include".tr();
  static String get addToCart => "Add to cart".tr();

  // API Query Parameters
  static const String queryPage = "page";
  static const String queryLimit = "limit";
  static const String queryId = "id";

  // Cart
  static String get cartTitle => "Cart".tr();
  static String get checkout => "Checkout".tr();
  static String get emptyCart => "Your cart is empty".tr();
  static String get itemAddedSuccess => "Item added successfully to your cart".tr();

  // Checkout
  static String get checkoutTitle => "Checkout".tr();
  static String get deliveryTime => "Delivery time".tr();
  static String get deliveryFee => "Delivery Fee".tr();
  static String get subtotal => "Sub Total".tr();
  static String get subTotal => "Sub Total".tr();
  static String get totalPrice => "Total".tr();
  static String get placeOrder => "Place order".tr();
  static String get schedule => "Schedule".tr();
  static String get arriveBy => "Arrive by".tr();
  static String get paymentSuccessful => "Payment Successful!".tr();
  static String get paymentFailed => "Payment Failed!".tr();
  static String get selectAddress => "Select Address".tr();
  static String get selectAddressError => "Please select a delivery address".tr();
  static String get paymentMethod => "Payment method".tr();
  static String get cash => "Cash".tr();
  static String get creditCard => "Credit card".tr();
  static String get shippingAddress => "Shipping Address".tr();
  static String get deliveryAddress => "Delivery address".tr();
  static String get cashOnDelivery => "Cash on delivery".tr();
  static String get sendAsGift => "Send as a gift".tr();
  static String get itIsAGift => "It is a gift".tr();
  static String get receiverName => "Receiver Name".tr();
  static String get receiverPhone => "Receiver Phone".tr();
  static String get nameLabel => "Name".tr();
  static String get enterNameHint => "Enter the name".tr();
  static String get enterPhoneHint => "Enter the phone number".tr();
  static String get homeLabel => "Home".tr();
  static String get officeLabel => "Office".tr();
  static String get addNew => "Add new".tr();
  static String get instant => "Instant".tr();
  static String get orderPlaced => "Order Placed!".tr();
  static String get thankYou => "Thank You!".tr();
  static String get thankYouMessage =>
      "Your order has been placed successfully.".tr();
  static String get continueShopping => "Continue Shopping".tr();
  static String get paymentCompleted => "Payment Completed".tr();

  // Profile & Address
  static String get myOrders => "My orders".tr();
  static String get savedAddresses => "Saved addresses".tr();
  static String get logout => "Logout".tr();
  static String get editProfile => "Edit profile".tr();
  static String get addNewAddress => "Add New Address".tr();
  static String get notification => "Notification".tr();
  static String get language => "Language".tr();
  static String get english => "English".tr();
  static String get arabic => "العربية".tr();
  static String get changeLanguage => "Change Language".tr();
  static String get aboutUs => "About us".tr();
  static String get termsConditions => "Terms & conditions".tr();
  static String get termsAndConditions => "Terms & conditions".tr();

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
  static String get pleaseConfirmYourPassword =>
      "Please confirm your password".tr();
  static String get confirmPasswordInvalid =>
      "Passwords don't match, please try again".tr();
  static String get phoneInvalid => "Please enter a valid phone number".tr();
  static String get alreadyHaveAnAccount => "Already have an account?".tr();
  static String get nameRequired => "Please enter your name".tr();
  static String get pinInvalid => "Please enter a valid PIN".tr();
  static String get profileImage => "Please add a profile image".tr();
  static String get anUnexpectedErrorOccurred =>
      "An unexpected error occurred".tr();
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

  // Home
  static const String categories = "Categories";
  static const String viewAll = "View All";
  static const String deliverTo = "Deliver to";
  static const String egp = "EGP";

  // Category Names
  static const String flowers = "Flowers";
  static const String gift = "Gift";
  static const String card = "Card";
  static const String jewellery = "Jewellery";

  // Occasion Names
  static const String wedding = "Wedding";
  static const String birthday = "Birthday";
  static const String graduation = "Graduation";

  // Dummy Product Names
  static const String sunnyProduct = "Sunny";
  static const String redRosesProduct = "Red roses";
  static const String springVaseProduct = "Spring vase";

  // Navigation
  static const String cart = "Cart";
  static const String profile = "Profile";
  static const String home = "Home";

  // Reset Password
  static const String resetPasswordTitle = "Reset password";
  static const String passwordUpdatedSuccess = "Password updated successfully!";
  static const String invalidPassword = "Invalid password";
  static const String currentPassword = "Current password";
  static const String enterCurrentPassword = "Please enter current password";
  static const String newPassword = "New password";
  static const String enterNewPassword = "Please enter new password";
  static const String confirmPasswordLabel = "Confirm password";
  static const String pleaseConfirmNewPassword = "Please confirm new password";
  static const String passwordsDoNotMatch = "Passwords do not match";
  static const String update = "Update";

  static String questionOf({required int current, required int total}) =>
      "question $current of $total".tr(args: [current.toString(), total.toString()]);

  static String get sortBy => "Sort by".tr();
  static String get lowestPrice => "Lowest Price".tr();
  static String get highestPrice => "Highest Price".tr();
  static String get newArrival => "New".tr();
  static String get old => "Old".tr();
  static String get discount => "Discount".tr();
  static String get filter => "Filter".tr();
  static String get searchForAnyProduct => "Search For Any Product You Want".tr();
}
