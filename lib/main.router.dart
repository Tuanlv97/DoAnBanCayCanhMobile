import 'package:app_mobile/main/account/account.cubit.dart';
import 'package:app_mobile/main/account/account.page.dart';
import 'package:app_mobile/main/account_detail/account.deltail.cubit.dart';
import 'package:app_mobile/main/account_detail/account.deltail.page.dart';
import 'package:app_mobile/main/bill/bill_detail/bill.detail.cubit.dart';
import 'package:app_mobile/main/bill/bill_detail/bill.detail.page.dart';
import 'package:app_mobile/main/bill/bill_history/bill.history.cubit.dart';
import 'package:app_mobile/main/bill/bill_history/bill.history.page.dart';
import 'package:app_mobile/main/cart/cart.cubit.dart';
import 'package:app_mobile/main/cart/cart.page.dart';
import 'package:app_mobile/main/payment/payment.cubit.dart';
import 'package:app_mobile/main/payment/payment.page.dart';
import 'package:app_mobile/main/register/otp.screen.dart';
import 'package:app_mobile/main/search/search.cubit.dart';
import 'package:app_mobile/main/search/search.page.dart';
import 'package:app_mobile/repository/repository_bill.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:service_bill/service_bill.dart';
import 'package:service_plant/service_plant.dart';
import 'main.router.constant.dart';
import 'main/buynow/buy.now.cubit.dart';
import 'main/buynow/buy.now.page.dart';
import 'main/home/component/data.page.model.dart';
import 'main/home/suggest/suggest.page.dart';
import 'main/login/login.cubit.dart';
import 'main/login/login.page.dart';
import 'main/main.page.dart';
import 'main/mian.cubit.dart';
import 'main/plantdetail/plant.detail.cubit.dart';
import 'main/plantdetail/plant.detail.page.dart';
import 'main/register/register.cubit.dart';
import 'main/register/register.page.dart';
import 'main/splash/splash.page.dart';
import 'repository/authentication.repository.dart';
import 'repository/repository_plant.dart';

final router = GoRouter(
  observers: [MyNavigatorObserver()],
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => BlocProvider(create: (BuildContext context) => MainCubit(), child: const SplashPage()),
    ),
    GoRoute(
      path: MainRouterPath.routerMain,
      builder: (context, state) => BlocProvider(create: (BuildContext context) => MainCubit(), child: const MainPage()),
    ),
    GoRoute(
      path: MainRouterPath.routerLogin,
      builder: (context, state) => BlocProvider(
        create: (context) => LoginCubit(authenticationRepository: context.read<AuthenticationRepository>()),
        child: const LoginPage(),
      ),
    ),
    GoRoute(
      path: MainRouterPath.routerRegister,
      builder: (context, state) => BlocProvider(
        create: (context) => RegisterCubit(authenticationRepository: context.read<AuthenticationRepository>()),
        child: const RegisterPage(),
      ),
    ),
    GoRoute(
      path: MainRouterPath.routerOTP,
      builder: (context, state) {
        return OtpScreen(dataRegister: state.extra as  DataRegister,);
      },
    ),
    GoRoute(
      path: MainRouterPath.routerPlantPage,
      builder: (context, state) {
        DataPageModel dataPageModel = DataPageModel(pageName: '', listData: []);
        dataPageModel = state.extra as DataPageModel;
        return SuggestPage(
          listPlant: dataPageModel.listData,
          pageName: dataPageModel.pageName,
        );
      },
    ),
    GoRoute(
      path: MainRouterPath.routerPlantDetailPage,
      builder: (context, state) {
        PlantModel plantModel = PlantModel();
        plantModel = state.extra as PlantModel;
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              lazy: false,
              create: (BuildContext context) => PlantDetailCubit(
                plantRepository: context.read<PlantRepository>(),
                plantModel: plantModel,
              ),
            ),
          ],
          child: PlantDetailPage(
            plantModel: plantModel,
          ),
        );
      },
    ),
    GoRoute(
      path: MainRouterPath.routerSearch,
      builder: (context, state) {
        PlantTypeModel? plantTypeModel;
        if (state.extra != null && state.extra is PlantTypeModel) {
          plantTypeModel = state.extra as PlantTypeModel;
        }
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              lazy: false,
              create: (BuildContext context) => SearchCubit(
                plantRepository: context.read<PlantRepository>(),
                plantTypeModel: plantTypeModel,
              ),
            ),
          ],
          child: const SearchPage(),
        );
      },
    ),
    GoRoute(
      path: MainRouterPath.routerBillDetail,
      builder: (context, state) {
        BillModel? billModel;
        if (state.extra != null && state.extra is BillModel) {
          billModel = state.extra as BillModel;
        }
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              lazy: false,
              create: (BuildContext context) =>
                  BillDetailCubit(billRepository: context.read<BillRepository>(), billModel: billModel ?? BillModel(listDetail: [])),
            ),
          ],
          child: const BillDetailPage(),
        );
      },
    ),
    GoRoute(
      path: MainRouterPath.routerBillHistory,
      builder: (context, state) {
        BillModel? billModel;
        if (state.extra != null && state.extra is BillModel) {
          billModel = state.extra as BillModel;
        }
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              lazy: false,
              create: (BuildContext context) =>
                  BillHistoryCubit(billRepository: context.read<BillRepository>(), billModel: billModel ?? BillModel(listDetail: [])),
            ),
          ],
          child: const BillHistoryPage(),
        );
      },
    ),
    GoRoute(
      path: MainRouterPath.routerCartPage,
      builder: (context, state) {
        context.read<CartCubit>().resetValueSeclect();
        return const CartPage();
      },
    ),
    GoRoute(
      path: MainRouterPath.routerPayment,
      builder: (context, state) {
        DataSendBill dataSendBill = DataSendBill(billModel: BillModel(listDetail: []), listCart: []);
        if (state.extra != null && state.extra is DataSendBill) {
          dataSendBill = state.extra as DataSendBill;
        }
        return BlocProvider(
          lazy: false,
          create: (context) => PaymentCubit(billRepository: context.read<BillRepository>(), dataSendBill: dataSendBill),
          child: const PaymentPage(),
        );
      },
    ),
    GoRoute(
      path: MainRouterPath.routerAccountDetail,
      builder: (context, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              lazy: false,
              create: (BuildContext context) => AccountDetailCubit(authenticationRepository: context.read<AuthenticationRepository>()),
            ),
          ],
          child: const AccountDetailPage(),
        );
      },
    ),
    GoRoute(
      path: MainRouterPath.routerBuyNow,
      builder: (context, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              lazy: false,
              create: (BuildContext context) => BuyNowCubit(
                  authenticationRepository: context.read<AuthenticationRepository>(),
                  plantRepository: context.read<PlantRepository>(),
                  cartItem: (state.extra != null && state.extra is CartItem) ? state.extra as CartItem : CartItem()),
            ),
          ],
          child: const BuyNowPage(),
        );
      },
    ),
  ],
);

class MyNavigatorObserver extends NavigatorObserver {
  static var listRoute = <String>[];
  static final BehaviorSubject<String> currentRouter = BehaviorSubject<String>();

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    listRoute.add(route.settings.name ?? '');
    if (listRoute.isNotEmpty) {
      currentRouter.add(listRoute.last);
    }
    print('didPush route ${listRoute.join(',')}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    listRoute.remove(route.settings.name ?? '');
    if (listRoute.isNotEmpty) {
      currentRouter.add(listRoute.last);
    }
    print('didPop route ${listRoute.join(',')}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    listRoute.remove(route.settings.name ?? '');
    if (listRoute.isNotEmpty) {
      currentRouter.add(listRoute.last);
    }
    print('didRemove route ${listRoute.join(',')}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    listRoute.remove(oldRoute?.settings.name ?? '');
    listRoute.add(newRoute?.settings.name ?? '');
    if (listRoute.isNotEmpty) {
      currentRouter.add(listRoute.last);
    }
    print('didReplace route ${listRoute.join(',')}');
  }
}

extension RouterMain on BuildContext {
  void popUntilPath(String routePath) {
    final router = GoRouter.of(this);
    while (router.location != routePath) {
      if (!router.canPop()) {
        return;
      }

      debugPrint('Popping ${router.location}');
      router.pop();
    }
  }
}
