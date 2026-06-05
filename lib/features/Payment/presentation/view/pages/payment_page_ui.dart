part of 'Payment_page.dart';

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.black,
      elevation: 0,
      title: Text(AppStrings.paymentMethod),
    ),
    backgroundColor: AppColors.whiteFD,
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _userEmail.isNotEmpty
                ? '${AppStrings.paymentLoggedInAs} $_userEmail'
                : AppStrings.paymentLoginHint,
            style: const TextStyle(fontSize: 14, color: AppColors.black85),
          ),
          const SizedBox(height: 20),
          _buildPaymentMethodCard(),
          const SizedBox(height: 20),
          if (_isCreditCard)
            CreditCardFormSection(
              formKey: _formKey,
              cardHolderController: _cardHolderController,
              cardNumberController: _cardNumberController,
              expiryController: _expiryController,
              cvcController: _cvcController,
              onFieldsChanged: () => setState(() {}),
            ),
          const SizedBox(height: 20),
          SavedPaymentDetailsSection(
            savedPaymentMethod: _savedPaymentMethod,
            savedCardLast4: _savedCardLast4,
          ),
          const SizedBox(height: 24),
          if (_isCreditCard)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (_isLoading || !_isCardFormFilled())
                    ? null
                    : _savePayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primerColor,
                  disabledBackgroundColor: AppColors.gray7D,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.white,
                        ),
                      )
                    : Text(
                        AppStrings.saveCard,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.white,
                        ),
                      ),
              ),
            ),
        ],
      ),
    ),
  );
}

Widget _buildPaymentMethodCard() {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    color: AppColors.white,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.paymentMethod,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          RadioListTile<bool>(
            value: false,
            groupValue: _isCreditCard,
            title: Text(AppStrings.cash),
            subtitle: Text(AppStrings.cashOnDelivery),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _isCreditCard = false;
                });
              }
            },
          ),
          RadioListTile<bool>(
            value: true,
            groupValue: _isCreditCard,
            title: Text(AppStrings.creditCard),
            subtitle: Text(AppStrings.enterCardDataSecurely),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _isCreditCard = true;
                });
              }
            },
          ),
        ],
      ),
    ),
  );
}
