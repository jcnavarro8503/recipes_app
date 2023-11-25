import 'package:get_it/get_it.dart';
import 'package:recipes_app/core/index.dart';
import 'package:recipes_app/features/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  //! External
  // final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingletonAsync<SharedPreferences>(() => SharedPreferences.getInstance());

  //! Core
  getIt.registerLazySingleton(() => ApiHandler());
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  //! Features
  /// Home BLOC
  getIt.registerLazySingleton(() => HomeBloc());

  /// My Recipes BLOC
  getIt.registerLazySingleton(
    () => MyRecipesBloc(
      getRecipes: getIt(),
      getMoreRecipes: getIt(),
    ),
  );

  /// My Recipes BLOC Use cases
  getIt.registerLazySingleton(() => GetRecipesUC(getIt()));
  getIt.registerLazySingleton(() => GetMoreRecipesUC(getIt()));

  /// My Recipes Repository
  getIt.registerLazySingleton<RecipesRepository>(
    () => RecipesRepositoryImpl(
      local: getIt(),
      remote: getIt(),
      networkInfo: getIt(),
    ),
  );

  /// My Recipes Data Sources
  await getIt.isReady<SharedPreferences>();
  getIt.registerLazySingleton<RecipesLocalDataSource>(
    () => RecipesLocalDataSourceImpl(
      sharedPreferences: getIt(),
    ),
  );
  getIt.registerLazySingleton<RecipesRemoteDataSource>(
    () => RecipesRemoteDataSourceImpl(
      apiHandler: getIt(),
    ),
  );

  getIt.registerLazySingleton(() => ThemeBloc());
  getIt.registerLazySingleton(() => LocalizationBloc());
}
