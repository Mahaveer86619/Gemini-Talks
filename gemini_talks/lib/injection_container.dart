import 'package:gemini_talks/features/gen/repository/gen_repository.dart';
import 'package:gemini_talks/features/gen/repository/history_repository.dart';
import 'package:gemini_talks/features/gen/repository/template_repository.dart';
import 'package:gemini_talks/features/gen/viewmodel/bloc/gen_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> registerServices() async {

    // Register SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  // Register FlutterSecureStorage
  const secureStorage = FlutterSecureStorage();
  sl.registerSingleton<FlutterSecureStorage>(secureStorage);

  // Repositories
  sl.registerLazySingleton<GenRepository>(() => GenRepository());
  sl.registerLazySingleton<HistoryRepository>(() => HistoryRepository());
  sl.registerLazySingleton<TemplateRepository>(() => TemplateRepository());

  // Bloc
  sl.registerFactory(() => GenBloc(
    genRepository: sl<GenRepository>(),
    historyRepository: sl<HistoryRepository>(),
    templateRepository: sl<TemplateRepository>(),
  ));

}
