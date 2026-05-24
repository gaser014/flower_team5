enum AppIcons {
  addImage("assets/icons/add_image.svg"),
  calendar("assets/icons/calendar.svg"),
  cart("assets/icons/cart.svg"),
  category("assets/icons/category.svg"),
  checkCircle("assets/icons/check_circle.svg"),
  checkmark("assets/icons/checkmark.svg"),
  clock("assets/icons/clock.svg"),
  closeCircle("assets/icons/close-circle.svg"),
  closedEye("assets/icons/closed_eye.svg"),
  connectionError("assets/icons/connection_error.svg"),
  downArrow("assets/icons/down_arrow.svg"),
  arrowBack("assets/icons/arrow_back.svg"),
  editProfile("assets/icons/edit_profile.svg"),
  error("assets/icons/error.svg"),
  filter("assets/icons/filter.svg"),
  flower("assets/icons/Flower.svg"),
  home("assets/icons/home.svg"),
  location("assets/icons/location.svg"),
  lock("assets/icons/lock.svg"),
  logout("assets/icons/logout.svg"),
  noData("assets/icons/no_data.svg"),
  noImage("assets/icons/no_image.svg"),
  noProfile("assets/icons/no_profile.svg"),
  notification("assets/icons/notification.svg"),
  openEye("assets/icons/open_eye.svg"),
  phone("assets/icons/phone.svg"),
  profile("assets/icons/profile.svg"),
  search("assets/icons/search.svg"),
  transactionOrder("assets/icons/transaction_order.svg"),
  translateLang("assets/icons/translate_lang.svg"),
  warning("assets/icons/warning.svg"),
  delete("assets/icons/delete.svg"),
  noItemsInCart("assets/icons/no_items_in_cart.svg");

  final String path;
  const AppIcons(this.path);
}

enum AppImages {
  icLauncherAndroid("assets/images/ic_launcher_android.png"),
  icLauncherIos("assets/images/ic_launcher_ios.png"),
  icLauncherWeb("assets/images/ic_launcher_web.png"),
  locationMarker("assets/images/location_marker.png");

  final String path;
  const AppImages(this.path);
}

abstract class AppAssets {
  // Keeping this for backward compatibility if needed, but promoting Enums
  static const String iconsAddImage = "assets/icons/add_image.svg";
  static const String iconsCalendar = "assets/icons/calendar.svg";
  static const String iconsCart = "assets/icons/cart.svg";
  static const String iconsCategory = "assets/icons/category.svg";
  static const String iconsCheckCircle = "assets/icons/check_circle.svg";
  static const String iconsCheckmark = "assets/icons/checkmark.svg";
  static const String iconsClock = "assets/icons/clock.svg";
  static const String iconsCloseCircle = "assets/icons/close-circle.svg";
  static const String iconsClosedEye = "assets/icons/closed_eye.svg";
  static const String emptyCartIcon = "assets/icons/no_items_in_cart.svg";
  static const String iconsConnectionError =
      "assets/icons/connection_error.svg";
  static const String iconsDownArrow = "assets/icons/down_arrow.svg";
  static const String arrowBack = "assets/icons/arrow_back.svg";
  static const String iconsEditProfile = "assets/icons/edit_profile.svg";
  static const String iconsError = "assets/icons/error.svg";
  static const String errorImage = "assets/icons/error_image.svg";

  static const String iconsFilter = "assets/icons/filter.svg";
  static const String iconsFlower = "assets/icons/Flower.svg";
  static const String iconsHome = "assets/icons/home.svg";
  static const String iconsLocation = "assets/icons/location.svg";
  static const String iconsLock = "assets/icons/lock.svg";
  static const String iconsLogout = "assets/icons/logout.svg";
  static const String iconsNoData = "assets/icons/no_data.svg";
  static const String iconsNoImage = "assets/icons/no_image.svg";
  static const String iconsNoProfile = "assets/icons/no_profile.svg";
  static const String iconsNotification = "assets/icons/notification.svg";
  static const String iconsOpenEye = "assets/icons/open_eye.svg";
  static const String iconsPhone = "assets/icons/phone.svg";
  static const String iconsProfile = "assets/icons/profile.svg";
  static const String iconsSearch = "assets/icons/search.svg";
  static const String iconsTransactionOrder =
      "assets/icons/transaction_order.svg";
  static const String iconsTranslateLang = "assets/icons/translate_lang.svg";
  static const String iconsWarning = "assets/icons/warning.svg";
  static const String iconsDelete = "assets/icons/delete.svg";
  static const String imagesIcLauncherAndroid =
      "assets/images/ic_launcher_android.png";
  static const String imagesIcLauncherIos = "assets/images/ic_launcher_ios.png";
  static const String imagesIcLauncherWeb = "assets/images/ic_launcher_web.png";
  static const String locationMarker = "assets/images/location_marker.png";
  //!======= Splash=============
  static const String logoSplash = "assets/images/flower-bg.png";
  static const String logoTextSplash = "assets/images/flowery-text.png";
  static const String splashLogo = "assets/images/flower.png";
  //!=======
}
