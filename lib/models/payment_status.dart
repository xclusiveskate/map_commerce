
class PaymentResponse {
  final bool status;
  final String ref;
  PaymentResponse({
    required this.status,
    required this.ref,
  });
  factory PaymentResponse.initial() {
    return PaymentResponse(
      ref: '',
      status: false,
    );
  }
}