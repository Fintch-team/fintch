import 'package:fintch/gen_export.dart';

class BarcodeRepository {
  final BarcodeService barcodeService;
  final LocalAuthService localAuthService;

  BarcodeRepository(
      {required this.barcodeService, required this.localAuthService});

  Future<ListBarcodeEntity> getAllBarcode({String id = ''}) async {
    ListBarcodeModel barcodeModel = await barcodeService.getBarcodeAll();

    return DataMapper.listBarcodeMapper(barcodeModel);
  }

  Future<bool> postBarcode({required BarcodePostEntity postEntity}) async {
    bool res = await barcodeService.postBarcode(
      name: postEntity.name,
      confirm: postEntity.confirm,
      amount: postEntity.amount,
      idUser: localAuthService.userId.toString(),
    );

    return res;
  }

  Future<bool> editBarcode({required BarcodePutEntity putEntity}) async {
    bool res = await barcodeService.putBarcode(
      idBarcode: putEntity.idBarcode,
      name: putEntity.name,
      confirm: putEntity.confirm,
      amount: putEntity.amount,
      idUser: localAuthService.userId.toString(),
    );

    return res;
  }

  Future<bool> deleteBarcode({required String idBarcode}) async {
    bool res = await barcodeService.deleteBarcode(idBarcode: idBarcode);

    return res;
  }
}
