
import 'package:command_delimeter/utils/storage.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() async{
  locator.registerSingletonAsync<Storage>(() async {
    final storage = Storage();
    await storage.init();
    return storage;
  });
}
