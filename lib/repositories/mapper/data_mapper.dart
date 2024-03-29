import 'package:fintch/gen_export.dart';

class DataMapper {
  static AuthEntity authMapper(TokenModel tokenModel) => AuthEntity(
        accessToken: tokenModel.data.accessToken,
        tokenType: tokenModel.data.tokenType,
        expiresIn: tokenModel.data.expiresIn,
        isSetPass: tokenModel.data.user.isSetPass,
        isSetPin: tokenModel.data.user.isSetPin,
      );

  static TransactionTopUpEntity transactionTopUpMapper(
          TransactionTopUpModel topUp) =>
      TransactionTopUpEntity(
        token: topUp.data.token,
        webUrl: topUp.data.webUrl,
        user: topUp.data.user,
      );

  static TransactionEntity transactionMapper(TransactionModel topUp) =>
      TransactionEntity(
        amount: topUp.data.amount,
        pay: topUp.data.pay,
        receive: topUp.data.receive,
      );

  static UserEntity userMapper(UserModel userModel) => UserEntity(
        id: userModel.data.id,
        name: userModel.data.name,
        nickname: userModel.data.nickname,
        wallet: userModel.data.wallet,
        school: userModel.data.school,
        moneyPlanning: userModel.data.moneyPlanning,
        receive: userModel.data.receive,
        pay: userModel.data.pay,
        img: userModel.data.img,
        barcode: userModel.data.barcode,
        moneyManage: userModel.data.moneyManage,
        level: userModel.data.level,
      );

  static ListMerchantEntity listMerchantMapper(ListUserModel userModel) =>
      ListMerchantEntity(
        data: userModel.data,
      );

  static BioUserEntity bioUser({required String user, required String pass}) =>
      BioUserEntity(
        pass: pass,
        user: user,
      );

  static UserEntity localUserMapper(UserData userModel) => UserEntity(
        id: userModel.id,
        name: userModel.name,
        nickname: userModel.nickname,
        wallet: userModel.wallet,
        school: userModel.school,
        moneyPlanning: userModel.moneyPlanning,
        receive: userModel.receive,
        pay: userModel.pay,
        img: userModel.img,
        barcode: userModel.barcode,
        moneyManage: userModel.moneyManage,
        level: userModel.level,
      );

  static HistoryEntity historyMapper(ListHistoryModel historyModel) =>
      HistoryEntity(
        pay: historyModel.data.pay,
        receive: historyModel.data.receive,
      );

  static WalletEntity walletMapper(WalletModel walletModel) => WalletEntity(
        id: walletModel.data.id,
        payAmount: walletModel.data.payAmount,
        walletAmount: walletModel.data.walletAmount,
        barrierAmount: walletModel.data.barrierAmount,
        barrierExpired: walletModel.data.barrierExpired,
      );

  static SchoolEntity schoolMapper(SchoolModel schoolModel) => SchoolEntity(
        id: schoolModel.data.id,
        name: schoolModel.data.name,
      );

  static MoneyManageEntity moneyManageMapper(MoneyManageModel moneyManage) =>
      MoneyManageEntity(
        id: moneyManage.data.id,
        name: moneyManage.data.name,
        amount: moneyManage.data.amount,
        isIncome: moneyManage.data.isIncome,
        item: moneyManage.data.item,
      );

  static MoneyManageIncomeEntity moneyManageIncomeMapper(
          MoneyManageIncomeModel moneyManage) =>
      MoneyManageIncomeEntity(
        income: moneyManage.data.income,
        outcome: moneyManage.data.outcome,
      );

  static MoneyManageTabelEntity moneyManageTabelMapper(
          MoneyManageTabelModel moneyManage) =>
      MoneyManageTabelEntity(
        income: moneyManage.data.income,
        outcome: moneyManage.data.outcome,
      );

  static MoneyManageItemEntity moneyManageItemMapper(
          MoneyManageItemModel moneyManageItem) =>
      MoneyManageItemEntity(
        id: moneyManageItem.data.id,
        name: moneyManageItem.data.name,
        amount: moneyManageItem.data.amount,
        percent: moneyManageItem.data.percent,
      );

  static MoneyPlanEntity moneyPlanMapper(MoneyPlanModel moneyPlan) =>
      MoneyPlanEntity(
        id: moneyPlan.data.id,
        deadline: moneyPlan.data.deadline,
        totalAmount: moneyPlan.data.totalAmount,
        note: moneyPlan.data.note,
        created: moneyPlan.data.created,
        amount: moneyPlan.data.amount,
        name: moneyPlan.data.name,
        percent: moneyPlan.data.percent,
      );

  static ListWalletEntity listWalletMapper(ListWalletModel walletModel) =>
      ListWalletEntity(
        data: walletModel.data,
      );

  static ListSchoolEntity listSchoolMapper(ListSchoolModel schoolModel) =>
      ListSchoolEntity(
        data: schoolModel.data,
      );

  static ListMoneyManageEntity listMoneyManageMapper(
          ListMoneyManageModel moneyManage) =>
      ListMoneyManageEntity(
        data: moneyManage.data,
      );

  static ListMoneyManageItemEntity listMoneyManageItemMapper(
          ListMoneyManageItemModel moneyManageItem) =>
      ListMoneyManageItemEntity(
        data: moneyManageItem.data,
      );

  static ListMoneyPlanEntity listMoneyPlanMapper(
          ListMoneyPlanModel moneyPlan) =>
      ListMoneyPlanEntity(
        data: moneyPlan.data,
      );

  static ListBarcodeEntity listBarcodeMapper(ListBarcodeModel moneyPlan) =>
      ListBarcodeEntity(
        data: moneyPlan.data,
      );

  static BarcodeEntity barcodeMapper(BarcodeModel barcode) => BarcodeEntity(
        id: barcode.data.id.toString(),
        name: barcode.data.name,
        amount: barcode.data.amount.toString(),
        confirm: barcode.data.confirm.toString(),
        createdAt: barcode.data.createdAt,
      );

  static TopUpEntity topUpMapper(TopUpModel topUp) => TopUpEntity(
        id: topUp.data.id,
        name: topUp.data.name,
        number: topUp.data.number,
        paymentStatus: topUp.data.paymentStatus,
        redirectUrl: topUp.data.redirectUrl,
        totalPrice: topUp.data.totalPrice,
        user: topUp.data.user,
      );

  static ListTopUpEntity listTopUpMapper(ListTopUpModel moneyPlan) =>
      ListTopUpEntity(
        data: moneyPlan.data,
      );
}
