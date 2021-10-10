import 'package:fintch/gen_export.dart';

class WalletRepository {
  final WalletService walletService;
  final LocalAuthService localAuthService;

  WalletRepository({
    required this.walletService,
    required this.localAuthService,
  });

  Future<WalletEntity> getWalletDetail({String id = ""}) async {
    WalletModel walletModel = await walletService.getWalletId(
        id: id.isNotEmpty ? id : localAuthService.userId.toString());

    return DataMapper.walletMapper(walletModel);
  }

  Future<ListWalletEntity> getWallet() async {
    ListWalletModel walletModel = await walletService.getWalletAll();

    return DataMapper.listWalletMapper(walletModel);
  }

  Future<bool> postWallet({required WalletPostEntity postEntity}) async {
    bool res = await walletService.postWallet(
        walletAmount: postEntity.walletAmount,
        barrierAmount: postEntity.barrierAmount,
        payAmount: postEntity.payAmount,
        barrierExpired: postEntity.barrierExpired);

    return res;
  }

  Future<bool> editWallet({required WalletPutEntity putEntity}) async {
    bool res = await walletService.putWallet(
      idWallet: putEntity.idWallet,
      walletAmount: putEntity.walletAmount,
      barrierAmount: putEntity.barrierAmount,
      payAmount: putEntity.payAmount,
      barrierExpired: putEntity.barrierExpired,
    );

    return res;
  }

  Future<bool> deleteWallet({required String idWallet}) async {
    bool res = await walletService.deleteWallet(idWallet: idWallet);

    return res;
  }
}
