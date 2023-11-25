import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recipes_app/core/index.dart';
import 'package:recipes_app/features/index.dart';

@GenerateNiceMocks([
  MockSpec<SharedPreferences>(),
  MockSpec<ApiHandler>(),
  MockSpec<NetworkInfo>(),
  MockSpec<NetworkInfoImpl>(),
  MockSpec<RecipesRepository>(),
  MockSpec<RecipesRemoteDataSource>(),
  MockSpec<RecipesLocalDataSource>(),
  MockSpec<GetRecipesUC>(),
  MockSpec<GetMoreRecipesUC>(),
])
void main() {}
