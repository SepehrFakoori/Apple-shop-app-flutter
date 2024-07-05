import 'package:ecommerce_flutter_application/constants/colors.dart';
import 'package:ecommerce_flutter_application/screens/login_screen.dart';
import 'package:ecommerce_flutter_application/util/auth_manager.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreenColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 44,
                right: 44,
                bottom: 32,
              ),
              child: Container(
                height: 46.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    Image.asset("assets/images/icon_apple_blue.png"),
                    const Expanded(
                      child: Text(
                        "حساب کاربری",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Shabnam",
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: AppColors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                AuthManager.logout();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
              child: const Text("Exit"),
            ),
            const Text(
              "سپهر فکوری",
              style: TextStyle(
                fontFamily: "Shabnam",
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const Text(
              "09309876543",
              style: TextStyle(
                  fontFamily: "Shabnam",
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColors.grey),
            ),
            const SizedBox(height: 30.0),
            const Directionality(
              textDirection: TextDirection.rtl,
              child: Wrap(
                runSpacing: 20.0,
                spacing: 20.0,
                children: [
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                ],
              ),
            ),
            const Spacer(),
            const Text(
              "اپل شاپ",
              style: TextStyle(
                fontFamily: "Shabnam",
                fontWeight: FontWeight.w500,
                fontSize: 10.0,
                color: AppColors.grey,
              ),
            ),
            const Text(
              "v-1.0.00",
              style: TextStyle(
                fontFamily: "Shabnam",
                fontWeight: FontWeight.w500,
                fontSize: 10.0,
                color: AppColors.grey,
              ),
            ),
            const Text(
              "Instagram.com/sepehr-dev",
              style: TextStyle(
                fontFamily: "Shabnam",
                fontWeight: FontWeight.w500,
                fontSize: 10.0,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
