part of 'pay_bloc.dart';

@immutable
class PayState {
  final double paymentAmount;
  final String currency;
  final bool activeCard;
  final AppCreditCard? card;

  PayState({
    this.paymentAmount = 375.55,
    this.currency = 'USD', 
    this.activeCard = false, 
    this.card
  });

  PayState copyWith({
    double? paymentAmount,
    String? currency,
    bool? activeCard,
    AppCreditCard? card, 
  }) => PayState(
    paymentAmount : paymentAmount ?? this.paymentAmount,
    currency      : currency ?? this.currency,
    activeCard    : activeCard ?? this.activeCard,
    card          : card ?? this.card
  );
}