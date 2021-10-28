import 'package:equatable/equatable.dart';

abstract class ProfilePayEvent extends Equatable {
  const ProfilePayEvent();

  @override
  List<Object?> get props => [];
}

class GetReceiveByNickname extends ProfilePayEvent {
  final String nickname;

  GetReceiveByNickname({required this.nickname});

  @override
  List<Object?> get props => [nickname];
}

class GetReceiveByBarcode extends ProfilePayEvent {
  final String barcode;

  GetReceiveByBarcode({required this.barcode});

  @override
  List<Object?> get props => [barcode];
}
