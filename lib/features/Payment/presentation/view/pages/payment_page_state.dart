part of 'Payment_page.dart';

class _PaymentPageState extends State<PaymentPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvcController = TextEditingController();

  bool _isCreditCard = true;
  bool _isLoading = false;
  String _userEmail = '';
  String? _savedPaymentMethod;
  String? _savedCardLast4;

  @override
  void initState() {
    super.initState();
    _loadSavedPaymentData();
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _expiryController.dispose();
    _cvcController.dispose();
    super.dispose();
  }

  Future<void> _loadSavedPaymentData() async {
    final savedData = await PaymentPageStorage.loadSavedCardData();
    if (savedData == null) return;

    if (!mounted) return;

    setState(() {
      _userEmail = savedData.email;
      _savedPaymentMethod = savedData.method;
      _isCreditCard = savedData.method == 'creditCard';

      if (_isCreditCard) {
        _cardNumberController.text = savedData.cardNumber ?? '';
        _cardHolderController.text = savedData.cardHolder ?? '';
        _expiryController.text = savedData.expiry ?? '';
        _cvcController.text = savedData.cvc ?? '';
        _savedCardLast4 = (savedData.cardNumber ?? '').length >= 4
            ? (savedData.cardNumber ?? '').substring(
                (savedData.cardNumber ?? '').length - 4,
              )
            : null;
      }
    });
  }

  bool _validateCardForm() {
    final form = _formKey.currentState;
    if (form == null) return false;
    return form.validate();
  }

  bool _isCardFormFilled() {
    final cardNumber = _cardNumberController.text.trim().replaceAll(' ', '');
    final expiry = _expiryController.text.trim();
    final cvc = _cvcController.text.trim();

    return _cardHolderController.text.trim().isNotEmpty &&
        cardNumber.length == 16 &&
        expiry.length == 5 &&
        expiry.contains('/') &&
        cvc.length == 3;
  }

  Future<void> _savePayment() async {
    if (_userEmail.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(AppStrings.loginToSavePayment)));
      return;
    }

    if (_isCreditCard && !_validateCardForm()) {
      return;
    }

    final paymentData = <String, dynamic>{
      'method': _isCreditCard ? 'creditCard' : 'cash',
    };

    if (_isCreditCard) {
      paymentData.addAll({
        'cardNumber': _cardNumberController.text.trim(),
        'cardHolder': _cardHolderController.text.trim(),
        'expiry': _expiryController.text.trim(),
        'cvc': _cvcController.text.trim(),
      });
    }

    setState(() => _isLoading = true);
    final saved = await PaymentPageStorage.savePaymentData(
      _userEmail,
      paymentData,
    );
    setState(() => _isLoading = false);

    if (!mounted) return;

    if (saved) {
      setState(() {
        _savedPaymentMethod = paymentData['method'] as String;
        _savedCardLast4 = _isCreditCard
            ? _cardNumberController.text
                  .trim()
                  .replaceAll(' ', '')
                  .substring(_cardNumberController.text.trim().length - 4)
            : null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.cardSavedSuccessfully)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.somethingWentWrong)),
      );
    }
  }
}
