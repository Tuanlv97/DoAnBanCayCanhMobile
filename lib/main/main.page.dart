// ignore_for_file: deprecated_member_use
import 'package:app_mobile/constants/button.not.click.multi.dart';
import 'package:app_mobile/repository/authentication.repository.dart';
import 'package:app_mobile/repository/repository_bill.dart';
import 'package:app_mobile/repository/repository_plant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'account/account.page.dart';
import 'bill/list.bill.cubit.dart';
import 'bill/list.bill.page.dart';
import 'favorite/favorite.cubit.dart';
import 'favorite/favorite.page.dart';
import 'home/home.cubit.dart';
import 'home/home.page.dart';
import 'home/plant_type/plant.type.cubit.dart';
import 'main.cubit.state.dart';
import 'mian.cubit.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<MainCubit, MainCubitState>(
          listener: (context, state) {},
          builder: (context, state) {
            return PageView(
              controller: context.read<MainCubit>().pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                MultiBlocProvider(providers: [
                  BlocProvider(
                     lazy: false,
                    create: (context) => HomeCubit(plantRepository: context.read<PlantRepository>()),
                  ),
                  BlocProvider(
                    lazy: false,
                    create: (context) => PlantTypeCubit(plantRepository: context.read<PlantRepository>()),
                  ),
                ], child: const HomePage()),
                const FavoritePage(),
                BlocProvider(
                   lazy: false,
                  create: (context) => ListBillCubit(context.read<BillRepository>(), context.read<AuthenticationRepository>()),
                  child: const ListBillPage(),
                ),
                const AccountPage(),
              ],
            );
          },
        ),
        bottomNavigationBar: BlocBuilder<MainCubit, MainCubitState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              height: 75,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ButtonNotClickMulti(
                      onTap: () {
                        context.read<MainCubit>().selectBottomBar(page: 0);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icon_home.svg',
                            color: state.pageNumber == 0 ? Colors.black : Color(0xFFB4B4B4),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Trang chủ",
                            style: TextStyle(
                              fontSize: 12,
                              color: state.pageNumber == 0 ? Colors.black : Color(0xFFB4B4B4),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ButtonNotClickMulti(
                      onTap: () {
                        context.read<MainCubit>().selectBottomBar(page: 1);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icon_heart.svg',
                            color: state.pageNumber == 1 ? Colors.black : Color(0xFFB4B4B4),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Yêu thích",
                            style: TextStyle(
                              fontSize: 12,
                              color: state.pageNumber == 1 ? Colors.black : Color(0xFFB4B4B4),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ButtonNotClickMulti(
                      onTap: () {
                        context.read<MainCubit>().selectBottomBar(page: 2);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.receipt_long,
                            size: 30,
                            color: state.pageNumber == 2 ? Colors.black : Color(0xFFB4B4B4),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Đơn hàng",
                            style: TextStyle(
                              fontSize: 12,
                              color: state.pageNumber == 2 ? Colors.black : Color(0xFFB4B4B4),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ButtonNotClickMulti(
                      onTap: () {
                        context.read<MainCubit>().selectBottomBar(page: 3);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icon_user.svg',
                            color: state.pageNumber == 3 ? Colors.black : Color(0xFFB4B4B4),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Tài khoản",
                            style: TextStyle(
                              fontSize: 12,
                              color: state.pageNumber == 3 ? Colors.black : Color(0xFFB4B4B4),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
