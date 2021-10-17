import 'package:fintch/gen_export.dart';

class BarcodePostEntity extends BaseEntity {
  final String name;
  final String confirm;
  final String amount;

  BarcodePostEntity({
    required this.name,
    required this.amount,
    required this.confirm,
  });
}

class BarcodePutEntity extends BaseEntity {
  final String idBarcode;
  final String name;
  final String confirm;
  final String amount;

  BarcodePutEntity(
      {required this.name,
      required this.confirm,
      required this.idBarcode,
      required this.amount});
}

class ListBarcodeEntity extends BaseEntity {
  final List<BarcodeData> data;

  ListBarcodeEntity({
    required this.data,
  });
}
