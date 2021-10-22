import 'package:fintch/gen_export.dart';

class TopUpEntity extends BaseEntity {
  final int id;
  final String name;
  final String number;
  final String paymentStatus;
  final String redirectUrl;
  final String totalPrice;
  final UserMini user;

  TopUpEntity({
    required this.id,
    required this.name,
    required this.number,
    required this.paymentStatus,
    required this.redirectUrl,
    required this.totalPrice,
    required this.user,
  });
}

class ListTopUpEntity extends BaseEntity {
  final List<TopUpData> data;

  ListTopUpEntity({
    required this.data,
  });
}
