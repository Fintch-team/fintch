import 'package:fintch/gen_export.dart';

class HistoryRepository {
  final HistoryService historyService;
  final LocalAuthService localAuthService;

  HistoryRepository(
      {required this.historyService, required this.localAuthService});

  Future<HistoryEntity> getPayHistory({String id = ''}) async {
    ListHistoryModel historyModel = await historyService.getHistoryAll(
      idPay: id.isNotEmpty ? id : localAuthService.currentUser!.id.toString(),
    );

    return DataMapper.historyMapper(historyModel);
  }

  Future<HistoryEntity> getReceiveHistory({String id = ''}) async {
    ListHistoryModel historyModel = await historyService.getHistoryAll(
      idReceive: id.isNotEmpty ? id : localAuthService.currentUser!.id.toString(),
    );

    return DataMapper.historyMapper(historyModel);
  }

  Future<bool> postHistory({required HistoryPostEntity postEntity}) async {
    bool res = await historyService.postHistory(
        idPay: postEntity.idPay,
        idReceive: postEntity.idReceive,
        amount: postEntity.amount);

    return res;
  }

  Future<bool> editHistory({required HistoryPutEntity putEntity}) async {
    bool res = await historyService.putHistory(
        idHistory: putEntity.idHistory,
        idPay: putEntity.idPay,
        idReceive: putEntity.idReceive,
        amount: putEntity.amount);

    return res;
  }

  Future<bool> deleteHistory({required String idHistory}) async {
    bool res = await historyService.deleteHistory(idHistory: idHistory);

    return res;
  }
}
