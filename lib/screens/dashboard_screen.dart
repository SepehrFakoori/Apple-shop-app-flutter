import 'dart:ui';
import 'package:ecommerce_flutter_application/bloc/basket/basket_bloc.dart';
import 'package:ecommerce_flutter_application/bloc/basket/basket_event.dart';
import 'package:ecommerce_flutter_application/bloc/category/category_bloc.dart';
import 'package:ecommerce_flutter_application/bloc/home/home_bloc.dart';
import 'package:ecommerce_flutter_application/bloc/home/home_event.dart';
import 'package:ecommerce_flutter_application/constants/colors.dart';
import 'package:ecommerce_flutter_application/di/di.dart';
import 'package:ecommerce_flutter_application/screens/card_screen.dart';
import 'package:ecommerce_flutter_application/screens/category_screen.dart';
import 'package:ecommerce_flutter_application/screens/home_screen.dart';
import 'package:ecommerce_flutter_application/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedBottomNavigationIndex = 3;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: IndexedStack(
          index: _selectedBottomNavigationIndex,
          children: getScreens(),
        ),
        // body: BlocProvider(
        //   create: ((context) => AuthBloc()),
        //   child: LoginScreen(),
        // ),
        bottomNavigationBar: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 40,
              sigmaY: 40,
            ),
            child: BottomNavigationBar(
              onTap: (int index) {
                setState(() {
                  _selectedBottomNavigationIndex = index;
                });
              },
              currentIndex: _selectedBottomNavigationIndex,
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedLabelStyle: const TextStyle(
                fontFamily: "Shabnam",
                fontWeight: FontWeight.w700,
                color: AppColors.blue,
              ),
              unselectedLabelStyle: const TextStyle(
                fontFamily: "Shabnam",
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                    icon: Image.asset("assets/images/icon_profile.png"),
                    activeIcon: Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.blue,
                                blurRadius: 20,
                                spreadRadius: -7,
                                offset: Offset(0.0, 13)),
                          ],
                        ),
                        child: Image.asset(
                          "assets/images/icon_profile_active.png",
                        ),
                      ),
                    ),
                    label: "حساب کاربری"),
                BottomNavigationBarItem(
                    icon: Image.asset("assets/images/icon_basket.png"),
                    activeIcon: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.blue,
                              blurRadius: 20,
                              spreadRadius: -7,
                              offset: Offset(0.0, 13)),
                        ],
                      ),
                      child:
                      Image.asset("assets/images/icon_basket_active.png"),
                    ),
                    label: "سبد خرید"),
                BottomNavigationBarItem(
                    icon: Image.asset("assets/images/icon_category.png"),
                    activeIcon: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.blue,
                              blurRadius: 20,
                              spreadRadius: -7,
                              offset: Offset(0.0, 13)),
                        ],
                      ),
                      child:
                      Image.asset("assets/images/icon_category_active.png"),
                    ),
                    label: "دسته بندی"),
                BottomNavigationBarItem(
                    icon: Image.asset("assets/images/icon_home.png"),
                    activeIcon: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.blue,
                              blurRadius: 20,
                              spreadRadius: -7,
                              offset: Offset(0.0, 13)),
                        ],
                      ),
                      child: Image.asset("assets/images/icon_home_active.png"),
                    ),
                    label: "خانه"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getScreens() {
    return <Widget>[
      const ProfileScreen(),
      BlocProvider(
        create: (context) {
          var bloc = locator.get<BasketBloc>();
          bloc.add(BasketFetchFromHiveEvent());
          return bloc;
        },
        child: const CardScreen(),
      ),
      BlocProvider(
        create: (context) => CategoryBloc(),
        child: const CategoryScreen(),
      ),
      Directionality(
        textDirection: TextDirection.rtl,
        child: BlocProvider(
          create: (context) {
            var bloc = HomeBloc();
            bloc.add(HomeGetInitializeData());
            return bloc;
          },
          child: const HomeScreen(),
        ),
      ),
    ];
  }
}
