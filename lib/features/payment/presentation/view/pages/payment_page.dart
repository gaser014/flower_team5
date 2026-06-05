import 'dart:convert';

import 'package:flowers_app/config/database/cache_helper.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/payment/presentation/services/payment_storage.dart';
import 'package:flutter/material.dart';
import 'package:flowers_app/features/payment/presentation/view/pages/payment_page_ui.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  static const bool _debugHardcoded = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvcController = TextEditingController();

  bool _isCreditCard = true;
  bool _isLoading = false;
  bool _isFormValid = false;
  String _userEmail = '';
  String? _savedPaymentMethod;
  String? _savedCardLast4;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await _loadSavedPaymentData();

    if (!_debugHardcoded) return;

    const debugEmail = 'test@example.com';
    final deleted = await PaymentStorage.isDeleted(debugEmail);
    if (deleted) return;

    if (_savedPaymentMethod == null) {
      if (mounted) {
        setState(() {
          _userEmail = debugEmail;
          _isCreditCard = true;
          _cardHolderController.text = 'Test User';
          _cardNumberController.text = '4242 4242 4242 4242';
          _expiryController.text = '12/34';
          _cvcController.text = '123';
          _savedPaymentMethod = 'creditCard';
          _savedCardLast4 = '4242';
        });
      }
    }
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
    final userJson = await AppSharedPreferences.getString(key: AppStrings.user);
    if (userJson == null || userJson.isEmpty) return;

    final userMap = jsonDecode(userJson) as Map<String, dynamic>?;
    final email = userMap?['email'] as String?;
    if (email == null || email.isEmpty) return;

    if (mounted) setState(() => _userEmail = email);

    final savedMap = await PaymentStorage.loadSaved(email);
    if (savedMap == null) return;

    final method = savedMap['method'] as String?;
    if (method == null) return;

    if (mounted) {
      setState(() {
        _savedPaymentMethod = method;
        _isCreditCard = method == 'creditCard';
      });
    }

    if (method == 'creditCard') {
      final cardNumber = savedMap['cardNumber'] as String? ?? '';
      final cardHolder = savedMap['cardHolder'] as String? ?? '';
      final expiry = savedMap['expiry'] as String? ?? '';
      final cvc = savedMap['cvc'] as String? ?? '';
      if (mounted) {
        setState(() {
          _cardNumberController.text = cardNumber;
          _cardHolderController.text = cardHolder;
          _expiryController.text = expiry;
          _cvcController.text = cvc;
          _savedCardLast4 = cardNumber.length >= 4
              ? cardNumber.substring(cardNumber.length - 4)
              : null;
        });
      }
    }
  }

  bool _validateCardForm() {
    final form = _formKey.currentState;
    if (form == null) return false;
    return form.validate();
  }

  void _updateForm() {
    if (!mounted) return;
    final isValid = _formKey.currentState?.validate() ?? false;
    setState(() {
      _isFormValid = isValid;
    });
  }

  Future<void> _savePayment() async {
    if (_userEmail.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.paymentLoginToSave)),
      );
      return;
    }

    if (_isCreditCard && !_validateCardForm()) return;

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
    final saved = await PaymentStorage.save(_userEmail, paymentData);
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

  Future<void> _deleteSavedPayment() async {
    if (_userEmail.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.paymentLoginToSave)),
      );
      return;
    }

    setState(() => _isLoading = true);
    final removed = await PaymentStorage.delete(_userEmail);
    setState(() => _isLoading = false);

    if (!mounted) return;

    if (removed) {
      setState(() {
        _savedPaymentMethod = null;
        _savedCardLast4 = null;
        _cardNumberController.clear();
        _cardHolderController.clear();
        _expiryController.clear();
        _cvcController.clear();
        _isFormValid = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.cardDeletedSuccessfully)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.somethingWentWrong)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PaymentPageUI(
      userEmail: _userEmail,
      isCreditCard: _isCreditCard,
      isLoading: _isLoading,
      isFormValid: _isFormValid,
      savedPaymentMethod: _savedPaymentMethod,
      savedCardLast4: _savedCardLast4,
      formKey: _formKey,
      cardHolderController: _cardHolderController,
      cardNumberController: _cardNumberController,
      expiryController: _expiryController,
      cvcController: _cvcController,
      onSelectCredit: () => setState(() => _isCreditCard = true),
      onSelectCash: () => setState(() => _isCreditCard = false),
      onSave: _savePayment,
      onDelete: _deleteSavedPayment,
      onFormChanged: _updateForm,
    );
  }
}
