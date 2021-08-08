part of 'pay_bloc.dart';

@immutable
abstract class PayEvent {}

class OnSelectedCard extends PayEvent {
  final AppCreditCard card;

  OnSelectedCard(this.card);

}

class OnDeactivateCard extends PayEvent {}