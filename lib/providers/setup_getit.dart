import 'package:betlog/providers/sport_provider.dart';
import 'package:betlog/providers/sportbook_provider.dart';
import 'package:betlog/providers/team_provider.dart';
import 'package:betlog/services/firestore_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerLazySingleton<FirestoreService>(() => FirestoreService());
  getIt.registerLazySingleton<SportProvider>(() => SportProvider());
  getIt.registerLazySingleton<SportsbookProvider>(() => SportsbookProvider());
  getIt.registerLazySingleton<TeamProvider>(() => TeamProvider());
}
