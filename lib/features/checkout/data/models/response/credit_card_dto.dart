class CreditCardDto {
  final String? error;
  final String? message;
  final String? url;
  final String? successUrl;

  CreditCardDto({
    this.error,
    this.message,
    this.url,
    this.successUrl,
  });

  factory CreditCardDto.fromJson(Map<String, dynamic> json) =>
      CreditCardDto(
        error: json['error'],
        message: json['message'],
        url: json['session']?['url'],
        successUrl: json['session']?['success_url'],
      );

  Map<String, dynamic> toJson() => {
        'error': error,
        'message': message,
        if (url != null || successUrl != null)
          'session': {
            if (url != null) 'url': url,
            if (successUrl != null) 'success_url': successUrl,
          },
      };
}
