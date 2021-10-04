import 'package:fintch/gen_export.dart';

class DataMapper {
  static AuthEntity authMapper(TokenModel tokenModel) => AuthEntity(
        accessToken: tokenModel.data!.accessToken,
        tokenType: tokenModel.data!.tokenType,
        expiresIn: tokenModel.data!.expiresIn,
        isSetPass: tokenModel.data!.user.isSetPass,
        isSetPin: tokenModel.data!.user.isSetPin,
      );

  static UserEntity userMapper(UserModel userModel) => UserEntity(
        id: userModel.data.id,
        name: userModel.data.name,
        nickname: userModel.data.nickname,
        wallet: userModel.data.wallet!,
        school: userModel.data.school!,
        moneyPlanning: userModel.data.moneyPlanning,
        receive: userModel.data.receive,
        pay: userModel.data.pay,
        img: userModel.data.img,
      );

  static UserEntity localUserMapper(DataUser userModel) => UserEntity(
        id: userModel.id,
        name: userModel.name,
        nickname: userModel.nickname,
        wallet: userModel.wallet!,
        school: userModel.school!,
        moneyPlanning: userModel.moneyPlanning,
        receive: userModel.receive,
        pay: userModel.pay,
        img: userModel.img,
      );

  static HistoryEntity historyMapper(ListHistoryModel historyModel) =>
      HistoryEntity(
        data: historyModel.data,
      );

  static WalletEntity walletMapper(WalletModel walletModel) => WalletEntity(
        id: walletModel.data.id,
        payAmount: walletModel.data.payAmount,
        walletAmount: walletModel.data.walletAmount,
        barrierAmount: walletModel.data.barrierAmount,
        barrierExpired: walletModel.data.barrierExpired,
      );

  static SchoolEntity schoolMapper(SchoolModel walletModel) => SchoolEntity(
        id: walletModel.data.id,
        name: walletModel.data.name,
      );
}
