

import 'package:get_storage/get_storage.dart';

late GetStorage _getStorage;
GetStorage get getStorage => _getStorage;

Future<void> initializeGetStorage() async {
  await GetStorage.init();

  _getStorage = GetStorage();
}
