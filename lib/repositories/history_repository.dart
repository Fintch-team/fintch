import 'package:fintch/gen_export.dart';

class HistoryRepository {
  final HistoryService historyService;

  HistoryRepository({
    required this.historyService,
  });

  Future<HistoryEntity> getPayHistory({required String id}) async {
    ListHistoryModel historyModel = await historyService.getHistoryAll(
      idPay: id,
    );

    return DataMapper.historyMapper(historyModel);
  }

  Future<HistoryEntity> getReceiveHistory({required String id}) async {
    ListHistoryModel historyModel = await historyService.getHistoryAll(
      idReceive: id,
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
