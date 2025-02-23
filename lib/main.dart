import 'package:app_mobile/repository/repository_bill.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants/component/error/error.wrapper.dart';
import 'constants/component/loading/loading.wrapper.dart';
import 'constants/firemessage.dart';
import 'firebase_options.dart';
import 'main.router.dart';
import 'main/account/account.cubit.dart';
import 'main/authentication/authentication.bloc.dart';
import 'main/cart/cart.cubit.dart';
import 'main/favorite/favorite.cubit.dart';
import 'main/cubit/user.change.cubit.dart';
import 'repository/authentication.repository.dart';
import 'repository/repository_plant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FireMessage.registerToken();
  await FireMessage.registerFirebase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  final PlantRepository plantRepository;
  final BillRepository billRepository;
  MyApp({super.key})
      : authenticationRepository = AuthenticationRepository(),
        plantRepository = PlantRepository(),
        billRepository = BillRepository();

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).platformBrightness == Brightness.dark;
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authenticationRepository),
        RepositoryProvider.value(value: plantRepository),
        RepositoryProvider.value(value: billRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => AuthenticationBloc(
                    authenticationRepository: authenticationRepository,
                  )),
          BlocProvider(create: (_) => UserChangeCubit(authenticationRepository)),
          BlocProvider(
            lazy: false,
            create: (context) => FavoriteCubit(authenticationRepository, plantRepository),
          ),
          BlocProvider(create: (_) => UserChangeCubit(authenticationRepository)),
          BlocProvider(
            lazy: false,
            create: (context) => CartCubit(plantRepository: plantRepository, authenticationRepository:  authenticationRepository),
          ),
          BlocProvider(
            create: (context) => AccountCubit(authenticationRepository: authenticationRepository),
          ),
        ],
        child: ErrorWrapper(
          child: LoadingWrapper(
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(primarySwatch: Colors.blue, navigationBarTheme: const NavigationBarThemeData(backgroundColor: Colors.white)),
              routerConfig: router,
            ),
          ),
        ),
      ),
    );
  }
}
