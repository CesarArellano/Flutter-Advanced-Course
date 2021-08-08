class StripeCustomResponse {
  final bool ok;
  final String msg;

  StripeCustomResponse({
    required this.ok, 
    this.msg = ''
  });
}