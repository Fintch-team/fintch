import 'package:fintch/gen_export.dart';

class TopUpRepository {
  final TopUpService topUpService;

  TopUpRepository({
    required this.topUpService,
  });

  Future<TopUpEntity> getTopUpDetail({required String id}) async {
    TopUpModel topUpModel = await topUpService.getTopUpId(id: id);

    return DataMapper.topUpMapper(topUpModel);
  }

  Future<ListTopUpEntity> getTopUp() async {
    ListTopUpModel topUpModel = await topUpService.getTopUpAll();

    return DataMapper.listTopUpMapper(topUpModel);
  }

  Future<bool> deleteTopUp({required String idTopUp}) async {
    bool res = await topUpService.deleteTopUp(idTopUp: idTopUp);

    return res;
  }
}
