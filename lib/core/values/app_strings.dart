import 'package:easy_localization/easy_localization.dart';

abstract class AppStrings {
  // ── OTP ──────────────────────────────────────────────────────────────────
  static String get otpRequired => 'otpRequired'.tr();
  static String get otpMustBe4Digits => 'otpMustBe4Digits'.tr();

  // ── API Failures ─────────────────────────────────────────────────────────
  static String get connectionError => 'connectionError'.tr();
  static String get connectionTimeout => 'connectionTimeout'.tr();
  static String get cancelled => 'cancelled'.tr();
  static String get unknownError => 'unknownError'.tr();
  static String get serverError => 'serverError'.tr();
  static String get receiveTimeout => 'receiveTimeout'.tr();
  static String get sendTimeout => 'sendTimeout'.tr();
  static String get unexpectedError => 'unexpectedError'.tr();
  static String get badCertificate => 'badCertificate'.tr();
  static String get expiredToken => 'expiredToken'.tr();
  static String get requestCancelled => 'requestCancelled'.tr();
  static String get apiServerError => 'apiServerError'.tr();
  static String get sessionExpired => 'sessionExpired'.tr();
  static String get somethingWentWrong => 'somethingWentWrong'.tr();
  static String get anUnexpectedErrorOccurred =>
      'anUnexpectedErrorOccurred'.tr();

  // ── Custom Widgets ────────────────────────────────────────────────────────
  static String get loadingAccessibilityLabel =>
      'loadingAccessibilityLabel'.tr();
  static String get retryButton => 'retryButton'.tr();
  static String get invalidCode => 'invalidCode'.tr();

  // ── Global Actions ────────────────────────────────────────────────────────
  static String get ok => 'ok'.tr();
  static String get confirm => 'confirm'.tr();
  static String get cancel => 'cancel'.tr();
  static String get close => 'close'.tr();
  static String get yes => 'yes'.tr();
  static String get no => 'no'.tr();
  static String get save => 'save'.tr();
  static String get submit => 'submit'.tr();
  static String get tryAgain => 'tryAgain'.tr();
  static String get resend => 'resend'.tr();
  static String get resendCode => 'resendCode'.tr();
  static String get resendCodeIn => 'resendCodeIn'.tr();
  static String get resendIn => 'resendIn'.tr();

  // ── Global State Labels ───────────────────────────────────────────────────
  static String get error => 'error'.tr();
  static String get success => 'success'.tr();
  static String get warning => 'warning'.tr();
  static String get info => 'info'.tr();
  static String get loading => 'loading'.tr();
  static String get noInternet => 'noInternet'.tr();

  // ── Global UI ─────────────────────────────────────────────────────────────
  static String get search => 'search'.tr();
  static String get searchForAnyProduct => 'searchForAnyProduct'.tr();
  static String get filter => 'filter'.tr();
  static String get sortBy => 'sortBy'.tr();
  static String get lowestPrice => 'lowestPrice'.tr();
  static String get highestPrice => 'highestPrice'.tr();
  static String get newArrival => 'newArrival'.tr();
  static String get old => 'old'.tr();
  static String get discount => 'discount'.tr();
  static String get viewAll => 'viewAll'.tr();
  static String get changeLanguage => 'changeLanguage'.tr();

  // ── App Info ──────────────────────────────────────────────────────────────
  static String get appName => 'appName'.tr();
  static String get appTitle => 'appTitle'.tr();
  static String get appSlogan => 'appSlogan'.tr();
  static String get version => 'version'.tr();

  // ── Date & Time ───────────────────────────────────────────────────────────
  static String get amLong => 'amLong'.tr();
  static String get pmLong => 'pmLong'.tr();
  static String get amShort => 'amShort'.tr();
  static String get pmShort => 'pmShort'.tr();
  static String get ago => 'ago'.tr();
  static String get justNow => 'justNow'.tr();
  static String get remaining => 'remaining'.tr();
  static String get second => 'second'.tr();
  static String get twoSeconds => 'twoSeconds'.tr();
  static String get seconds => 'seconds'.tr();
  static String get minute => 'minute'.tr();
  static String get twoMinutes => 'twoMinutes'.tr();
  static String get minutes => 'minutes'.tr();
  static String get hourLabel => 'hourLabel'.tr();
  static String get hour => 'hour'.tr();
  static String get twoHours => 'twoHours'.tr();
  static String get hours => 'hours'.tr();
  static String get day => 'day'.tr();
  static String get twoDays => 'twoDays'.tr();
  static String get days => 'days'.tr();
  static String get week => 'week'.tr();
  static String get twoWeeks => 'twoWeeks'.tr();
  static String get weeks => 'weeks'.tr();
  static String get month => 'month'.tr();
  static String get months => 'months'.tr();
  static String get year => 'year'.tr();
  static String get twoYears => 'twoYears'.tr();
  static String get years => 'years'.tr();

  // ── Currency ──────────────────────────────────────────────────────────────
  static String get currencyIQD => 'currencyIQD'.tr();
  static String get egp => 'egp'.tr();

  // ── Image Actions ─────────────────────────────────────────────────────────
  static String get changeImage => 'changeImage'.tr();
  static String get removeImage => 'removeImage'.tr();
  static String get addImage => 'addImage'.tr();
  static String get camera => 'camera'.tr();
  static String get gallery => 'gallery'.tr();

  // ── Validations ────────────────────────────────────────────────────────────
  static String get emailRequired => 'emailRequired'.tr();
  static String get emailInvalid => 'emailInvalid'.tr();
  static String get usernameRequired => 'usernameRequired'.tr();
  static String get usernameInvalid => 'usernameInvalid'.tr();
  static String get firstNameRequired => 'firstNameRequired'.tr();
  static String get lastNameRequired => 'lastNameRequired'.tr();
  static String get passwordRequired => 'passwordRequired'.tr();
  static String get passwordHint => 'passwordHint'.tr();
  static String get confirmPasswordRequired => 'confirmPasswordRequired'.tr();
  static String get confirmPasswordMismatch => 'confirmPasswordMismatch'.tr();
  static String get confirmPasswordInvalid => 'confirmPasswordInvalid'.tr();
  static String get pleaseConfirmYourPassword =>
      'pleaseConfirmYourPassword'.tr();
  static String get phoneRequired => 'phoneRequired'.tr();
  static String get phoneInvalid => 'phoneInvalid'.tr();
  static String get egyptianPhoneInvalid => 'egyptianPhoneInvalid'.tr();
  static String get pinRequired => 'pinRequired'.tr();
  static String get pinInvalid => 'pinInvalid'.tr();
  static String get nameRequired => 'nameRequired'.tr();
  static String get profileImage => 'profileImage'.tr();
  static String get setPassword1ConditionError =>
      'setPassword1ConditionError'.tr();
  static String get setPassword2ConditionError =>
      'setPassword2ConditionError'.tr();
  static String get setPassword3ConditionError =>
      'setPassword3ConditionError'.tr();
  static String get setPassword4ConditionError =>
      'setPassword4ConditionError'.tr();
  static String get setPassword5ConditionError =>
      'setPassword5ConditionError'.tr();

  // ── Payment ────────────────────────────────────────────────────────────────
  static String get paymentLoginHint => 'paymentLoginHint'.tr();
  static String get paymentLoggedInAs => 'paymentLoggedInAs'.tr();
  static String get enterCardDataSecurely => 'enterCardDataSecurely'.tr();
  static String get saveCard => 'saveCard'.tr();
  static String get deleteCard => 'deleteCard'.tr();
  static String get cardHolderName => 'cardHolderName'.tr();
  static String get enterCardHolderName => 'enterCardHolderName'.tr();
  static String get cardNumber => 'cardNumber'.tr();
  static String get enterCardNumber => 'enterCardNumber'.tr();
  static String get invalidCardNumber => 'invalidCardNumber'.tr();
  static String get cardHolderNameThreeWords => 'cardHolderNameThreeWords'.tr();
  static String get expiryDate => 'expiryDate'.tr();
  static String get enterExpiryDate => 'enterExpiryDate'.tr();
  static String get invalidExpiryDate => 'invalidExpiryDate'.tr();
  static String get cvc => 'cvc'.tr();
  static String get enterCvc => 'enterCvc'.tr();
  static String get invalidCvc => 'invalidCvc'.tr();
  static String get savedCardDetails => 'savedCardDetails'.tr();
  static String get noSavedCard => 'noSavedCard'.tr();
  static String get cardEnding => 'cardEnding'.tr();
  static String get cardSavedSuccessfully => 'cardSavedSuccessfully'.tr();
  static String get paymentLoginToSave => 'paymentLoginToSave'.tr();
  static String get cardDeletedSuccessfully => 'cardDeletedSuccessfully'.tr();

  // ── Products ──────────────────────────────────────────────────────────────
  static String get product => 'product'.tr();
  static String get oneProduct => 'oneProduct'.tr();
  static String get twoProducts => 'twoProducts'.tr();
  static String get products => 'products'.tr();
  static String get noProductsFound => 'noProductsFound'.tr();
  static String get inStock => 'inStock'.tr();
  static String get description => 'description'.tr();
  static String get bouquetInclude => 'bouquetInclude'.tr();
  static String get addToCart => 'addToCart'.tr();
  static String get itemAddedSuccess => 'itemAddedSuccess'.tr();

  // Checkout
  static const String checkoutTitle = "Checkout";
  static const String deliveryTime = "Delivery time";
  static const String deliveryFee = "Delivery Fee";
  static const String subtotal = "Sub Total";
  static const String totalPrice = "Total";
  static const String placeOrder = "Place order";
  static const String schedule = "Schedule";
  static const String arriveBy = "Arrive by";
  static const String paymentSuccessful = "Payment Successful!";
  static const String paymentFailed = "Payment Failed!";
  static const String selectAddress = "Select Address";
  static const String paymentMethod = "Payment method";
  static const String cash = "Cash";
  static const String creditCard = "Credit card";
  static const String shippingAddress = "Shipping Address";
  static const String deliveryAddress = "Delivery address";
  static const String cashOnDelivery = "Cash on delivery";
  static const String sendAsGift = "Send as a gift";
  static const String itIsAGift = "It is a gift";
  static const String receiverName = "Receiver Name";
  static const String receiverPhone = "Receiver Phone";
  static const String nameLabel = "Name";
  static const String enterNameHint = "Enter the name";
  static const String enterPhoneHint = "Enter the phone number";
  static const String homeLabel = "Home";
  static const String officeLabel = "Office";
  static const String addNew = "Add new";
  static const String instant = "Instant";
  static const String orderPlaced = "Order Placed!";
  static const String thankYou = "Thank You!";
  static const String thankYouMessage = "Your order has been placed successfully.";
  static const String continueShopping = "Continue Shopping";
  static const String paymentCompleted = "Payment Completed";

  // ── Home ──────────────────────────────────────────────────────────────────
  static String get home => 'home'.tr();
  static String get categories => 'categories'.tr();
  static String get deliverTo => 'deliverTo'.tr();
  static String get occasion => 'occasion'.tr();
  static String get occasionSubTitle => 'occasionSubTitle'.tr();
  static String get bestSeller => 'bestSeller'.tr();
  static String get bestSellerSubtitle => 'bestSellerSubtitle'.tr();

  // ── Category Names ────────────────────────────────────────────────────────
  static String get flowers => 'flowers'.tr();
  static String get gift => 'gift'.tr();
  static String get card => 'card'.tr();
  static String get jewellery => 'jewellery'.tr();

  // ── Occasion Names ────────────────────────────────────────────────────────
  static String get wedding => 'wedding'.tr();
  static String get birthday => 'birthday'.tr();
  static String get graduation => 'graduation'.tr();

  // ── Dummy Products ────────────────────────────────────────────────────────
  static String get sunnyProduct => 'sunnyProduct'.tr();
  static String get redRosesProduct => 'redRosesProduct'.tr();
  static String get springVaseProduct => 'springVaseProduct'.tr();

  // ── Navigation ────────────────────────────────────────────────────────────
  static String get cart => 'cart'.tr();
  static String get profile => 'profile'.tr();
  // Home
  static const String categories = "Categories";
  static const String viewAll = "View All";
  static const String deliverTo = "Deliver to";
  static const String egp = "EGP";
  // ── Cart ──────────────────────────────────────────────────────────────────
  static String get cartTitle => 'cartTitle'.tr();
  static String get checkout => 'checkout'.tr();
  static String get emptyCart => 'emptyCart'.tr();

  // ── Checkout ──────────────────────────────────────────────────────────────
  static String get deliveryTime => 'deliveryTime'.tr();
  static String get schedule => 'schedule'.tr();
  static String get arriveBy => 'arriveBy'.tr();
  static String get instant => 'instant'.tr();
  static String get deliveryAddress => 'deliveryAddress'.tr();
  static String get homeLabel => 'homeLabel'.tr();
  static String get officeLabel => 'officeLabel'.tr();
  static String get addNew => 'addNew'.tr();
  static String get showAllAddresses => 'showAllAddresses'.tr();
  static String get deliveryFee => 'deliveryFee'.tr();
  static String get totalPrice => 'totalPrice'.tr();
  static String get placeOrder => 'placeOrder'.tr();
  static String get paymentMethod => 'paymentMethod'.tr();
  static String get cash => 'cash'.tr();
  static String get creditCard => 'creditCard'.tr();
  static String get cashOnDelivery => 'cashOnDelivery'.tr();
  static String get itIsAGift => 'itIsAGift'.tr();
  static String get nameLabel => 'nameLabel'.tr();
  static String get enterNameHint => 'enterNameHint'.tr();
  static String get enterPhoneHint => 'enterPhoneHint'.tr();
  static String get subTotal => 'subTotal'.tr();
  static String get selectAddress => 'selectAddress'.tr();
  static String get paymentSuccessful => 'paymentSuccessful'.tr();
  static String get paymentFailed => 'paymentFailed'.tr();
  static String get orderPlaced => 'orderPlaced'.tr();
  static String get thankYouMessage => 'thankYouMessage'.tr();
  static String get continueShopping => 'continueShopping'.tr();
  static String get active => 'active'.tr();
  static String get completed => 'completed'.tr();
  static String get noActiveOrders => 'noActiveOrders'.tr();
  static String get noCompletedOrders => 'noCompletedOrders'.tr();
  static String get trackOrder => 'trackOrder'.tr();
  static String get orderNumber => 'orderNumber'.tr();

  // ── Track Order ───────────────────────────────────────────────────────────
  static String get orderPlacedSuccessfully => 'orderPlacedSuccessfully'.tr();
  static String get preparingYourOrder => 'preparingYourOrder'.tr();
  static String get outForDelivery => 'outForDelivery'.tr();
  static String get orderDelivered => 'orderDelivered'.tr();
  static String get orderCancelled => 'orderCancelled'.tr();
  static String get itemsLabel => 'itemsLabel'.tr();
  static String get showMap => 'showMap'.tr();
  static String get payWithCash => 'payWithCash'.tr();
  static String get payWithCard => 'payWithCard'.tr();
  static String get orderNotFound => 'orderNotFound'.tr();

  // ── Auth — Login ──────────────────────────────────────────────────────────
  static String get loginTitle => 'loginTitle'.tr();
  static String get loginSubtitle => 'loginSubtitle'.tr();
  static String get rememberMe => 'rememberMe'.tr();
  static String get forgotPassword => 'forgotPassword'.tr();
  static String get loginButton => 'loginButton'.tr();
  static String get continueAsGuest => 'continueAsGuest'.tr();
  static String get noAccount => 'noAccount'.tr();
  static String get signUp => 'signUp'.tr();
  static String get loginSuccessfully => 'loginSuccessfully'.tr();
  static String get loginError => 'loginError'.tr();

  // ── Auth — Forget Password ────────────────────────────────────────────────
  static String get forgetPasswordTitle => 'forgetPasswordTitle'.tr();
  static String get forgetPasswordSubtitle => 'forgetPasswordSubtitle'.tr();
  static String get confirmForgetPassword => 'confirmForgetPassword'.tr();

  // ── Auth — Verification ───────────────────────────────────────────────────
  static String get verificationCodeTitle => 'verificationCodeTitle'.tr();
  static String get verificationCodeSubtitle => 'verificationCodeSubtitle'.tr();
  static String get codeNotReceived => 'codeNotReceived'.tr();
  static String get didntReceiveCode => 'didntReceiveCode'.tr();

  // ── Auth — Reset Password ─────────────────────────────────────────────────
  static String get resetPasswordTitle => 'resetPasswordTitle'.tr();
  static String get resetPasswordSubtitle => 'resetPasswordSubtitle'.tr();
  static String get newPassword => 'newPassword'.tr();
  static String get confirmNewPassword => 'confirmNewPassword'.tr();

  // ── Auth — Register ───────────────────────────────────────────────────────
  static String get registerTitle => 'registerTitle'.tr();
  static String get alreadyHaveAnAccount => 'alreadyHaveAnAccount'.tr();
  static String get firstName => 'firstName'.tr();
  static String get firstNameHint => 'firstNameHint'.tr();
  static String get lastName => 'lastName'.tr();
  static String get lastNameHint => 'lastNameHint'.tr();
  static String get email => 'email'.tr();
  static String get enterEmail => 'enterEmail'.tr();
  static String get password => 'password'.tr();
  static String get confirmPassword => 'confirmPassword'.tr();
  static String get phoneNumber => 'phoneNumber'.tr();
  static String get enterPhoneNumber => 'enterPhoneNumber'.tr();
  static String get username => 'username'.tr();
  static String get enterUserName => 'enterUserName'.tr();
  static String get genderLabel => 'genderLabel'.tr();
  static String get maleLabel => 'maleLabel'.tr();
  static String get femaleLabel => 'femaleLabel'.tr();
  static String get termsAndConditionsView => 'termsAndConditionsView'.tr();
  static String get termsConditionsPart1 => 'termsConditionsPart1'.tr();
  static String get termsConditionsPart2 => 'termsConditionsPart2'.tr();
  static String get accountCreatedSuccessfully =>
      'accountCreatedSuccessfully'.tr();

  // ── Profile & Settings ────────────────────────────────────────────────────
  static String get myOrders => 'myOrders'.tr();
  static String get savedAddresses => 'savedAddresses'.tr();
  static String get logout => 'logout'.tr();
  static String get editProfile => 'editProfile'.tr();
  static String get addNewAddress => 'addNewAddress'.tr();
  static String get notification => 'notification'.tr();
  static String get language => 'language'.tr();
  static String get english => 'english'.tr();
  static String get arabic => 'arabic'.tr();
  static String get aboutUs => 'aboutUs'.tr();
  static String get termsConditions => 'termsConditions'.tr();
  static String get termsAndConditions => 'termsAndConditions'.tr();

  // ── Misc ──────────────────────────────────────────────────────────────────
  static String get token => 'token'.tr();
  static String get user => 'user'.tr();

  static String get questionOf => 'questionOf'.tr();
  static String get addressTitle => 'title'.tr();
  static String get addressLabel => 'address_label'.tr();
  static String get enterAddress => 'enter_address'.tr();
  // static String get phoneNumber => 'phone_number'.tr();
  // static String get enterPhoneNumber => 'enter_phone_number'.tr();
  static String get recipientName => 'recipient_name'.tr();
  static String get enterRecipientName => 'enter_recipient_name'.tr();
  static String get cityLabel => 'city'.tr();
  static String get areaLabel => 'area'.tr();
  static String get selectCity => 'select_city'.tr();
  static String get selectArea => 'select_area'.tr();
  static String get saveAddress => 'save_address'.tr();
  static String get addressSaved => 'address_saved'.tr();
  static String get locationPermissionDenied =>
      'location_permission_denied'.tr();

  static String get savedAddressTitle => 'saved_address_title'.tr();
  // static String get addNewAddress => 'add_new_address'.tr();
  static String get noSavedAddresses => 'no_saved_addresses'.tr();
  static String get deleteAddressTitle => 'delete_address_title'.tr();
  static String get deleteAddressMessage => 'delete_address_message'.tr();
  // static String get cancel => 'cancel'.tr();
  static String get delete => 'delete'.tr();
  // static String get deliverTo => 'deliver_to'.tr();
  static String get noAddressesYet => 'no_addresses_yet'.tr();
  static String get addAddressToStart => 'add_address_to_start'.tr();

  // Track Order
  static const String trackOrder = "Track Order";
  static const String estimatedArrival = "Estimated arrival";
  static const String deliveryHero = "Delivery Hero";
  static const String showMap = "Show Map";
  static const String orderDelivered = "Order Delivered";
  static const String receivedOrder = "Order Received";
  static const String preparingOrder = "Preparing Order";
  static const String outForDelivery = "Out for Delivery";
  static const String statusDelivered = "Delivered";
  static const String orderDetails = "Order Details";
  static const String noTrackedOrder = "No order to track yet";
  static const String orderCancelled = "Order Cancelled";
  static const String waitingForDriver = "Waiting for a delivery hero";
  static const String orderNumberLabel = "Order";
  static const String calculatingArrival = "Calculating arrival time";
  static const String confirmDelivery = "Confirm Delivery";
  static const String orderDeliveredTitle = "Order Delivered";
  static const String orderDeliveredByCustomerBody =
      "The customer confirmed receiving the order";
}
