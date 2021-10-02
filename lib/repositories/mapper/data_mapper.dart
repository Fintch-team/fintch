import 'package:fintch/gen_export.dart';

class DataMapper {
  static AuthEntity authMapper(TokenModel tokenModel) => AuthEntity(
        accessToken: tokenModel.data!.accessToken,
        tokenType: tokenModel.data!.tokenType,
        expiresIn: tokenModel.data!.expiresIn,
        isFirst: tokenModel.data!.user.isFirst,
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
