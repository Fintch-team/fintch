import 'package:equatable/equatable.dart';

abstract class MerchantEvent extends Equatable {
  const MerchantEvent();
  @override
  List<Object?> get props => [];
}

class GetMerchants extends MerchantEvent {}
