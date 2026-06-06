import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'payment_card_brand.dart';

class PaymentCardPreview extends StatefulWidget {
  const PaymentCardPreview({
    super.key,
    required this.cardHolderController,
    required this.cardNumberController,
    required this.expiryController,
    required this.cvcController,
  });

  final TextEditingController cardHolderController;
  final TextEditingController cardNumberController;
  final TextEditingController expiryController;
  final TextEditingController cvcController;

  @override
  State<PaymentCardPreview> createState() => _PaymentCardPreviewState();
}

class _PaymentCardPreviewState extends State<PaymentCardPreview> {
  bool _showFullNumber = false;

  String _maskedNumber(String value) {
    final cleaned = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleaned.isEmpty) return '**** **** **** ****';
    final last = cleaned.length <= 4
        ? cleaned
        : cleaned.substring(cleaned.length - 4);
    return '**** **** **** $last';
  }

  String _formatCardNumber(String value) {
    final cleaned = value.replaceAll(RegExp(r'[^0-9]'), '');
    final maxLength = cleaned.length > 16 ? 16 : cleaned.length;
    final digits = cleaned.substring(0, maxLength);
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }

  String _formatExpiry(String value) {
    final cleaned = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleaned.length <= 2) return cleaned;
    return '${cleaned.substring(0, 2)}/${cleaned.substring(2, cleaned.length > 4 ? 4 : cleaned.length)}';
  }

  String _detectBrand(String value) {
    final cleaned = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleaned.isEmpty) return 'unknown';
    if (cleaned.startsWith('4')) return 'visa';
    if (cleaned.startsWith('5') || cleaned.startsWith('2')) return 'mastercard';
    return 'unknown';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: Listenable.merge([
                widget.cardHolderController,
                widget.cardNumberController,
                widget.expiryController,
                widget.cvcController,
              ]),
              builder: (context, _) {
                final name = widget.cardHolderController.text.isEmpty
                    ? 'CARD HOLDER'
                    : widget.cardHolderController.text.toUpperCase();
                final rawNumber = widget.cardNumberController.text;
                final number = rawNumber.isEmpty
                    ? '**** **** **** ****'
                    : (_showFullNumber
                          ? _formatCardNumber(rawNumber)
                          : _maskedNumber(rawNumber));
                final expiry = widget.expiryController.text.isEmpty
                    ? 'MM/YY'
                    : _formatExpiry(widget.expiryController.text);

                final brand = _detectBrand(rawNumber);

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [AppColors.primerColor, AppColors.pinkE8],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: AppColors.shadowBox,
                  ),
                  padding: const EdgeInsets.all(18),
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 48,
                            height: 34,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.95),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.08),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.credit_card,
                                size: 18,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              PaymentCardBrand(brand: brand),
                              const SizedBox(width: 8),
                              Icon(
                                Icons.wifi,
                                color: Colors.white.withValues(alpha: 0.9),
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _showFullNumber = !_showFullNumber;
                                  });
                                },
                                child: Icon(
                                  _showFullNumber
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.white.withValues(alpha: 0.9),
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        number,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          letterSpacing: 2.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'CARD HOLDER',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'EXPIRES',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                expiry,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
