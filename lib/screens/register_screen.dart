import 'package:ecommerce_flutter_application/bloc/authentication/auth_bloc.dart';
import 'package:ecommerce_flutter_application/bloc/authentication/auth_event.dart';
import 'package:ecommerce_flutter_application/bloc/authentication/auth_state.dart';
import 'package:ecommerce_flutter_application/constants/colors.dart';
import 'package:ecommerce_flutter_application/screens/dashboard_screen.dart';
import 'package:ecommerce_flutter_application/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _usernameTextController = TextEditingController(text: "");
  final _passwordTextController = TextEditingController(text: "");
  final _passwordConfirmTextController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: _ViewContainer(
          usernameTextController: _usernameTextController,
          passwordTextController: _passwordTextController,
          passwordConfirmTextController: _passwordConfirmTextController),
    );
  }
}

class _ViewContainer extends StatelessWidget {
  const _ViewContainer({
    super.key,
    required TextEditingController usernameTextController,
    required TextEditingController passwordTextController,
    required TextEditingController passwordConfirmTextController,
  })  : _usernameTextController = usernameTextController,
        _passwordTextController = passwordTextController,
        _passwordConfirmTextController = passwordConfirmTextController;

  final TextEditingController _usernameTextController;
  final TextEditingController _passwordTextController;
  final TextEditingController _passwordConfirmTextController;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            // we use "SingleChildScrollView" to solve keyboard shows up overflow error!
            child: Column(
              children: [
                const SizedBox(height: 60),
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset("assets/images/register.jpg"),
                ),
                const Text(
                  "ثبت نام",
                  style: TextStyle(
                    fontFamily: "Dana",
                    fontWeight: FontWeight.w500,
                    fontSize: 34,
                    color: AppColors.blue,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "نام کاربری",
                            style: TextStyle(
                              fontFamily: "Dana",
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            color: Colors.grey.shade300,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextField(
                              controller: _usernameTextController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24.0, right: 24.0, bottom: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "رمز عبور",
                            style: TextStyle(
                              fontFamily: "Dana",
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            color: Colors.grey.shade300,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextField(
                              controller: _passwordTextController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24.0, right: 24.0, bottom: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "تکرار رمز عبور",
                            style: TextStyle(
                              fontFamily: "Dana",
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            color: Colors.grey.shade300,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextField(
                              controller: _passwordConfirmTextController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: ((context, state) {
                        if (state is AuthResponseState) {
                          state.response.fold((l) {
                            _usernameTextController.text = "";
                            _passwordTextController.text = "";
                            _passwordConfirmTextController.text = "";
                            var snackBar = SnackBar(
                              content: Text(
                                l,
                                style: const TextStyle(
                                    fontFamily: "Dana", fontSize: 14),
                              ),
                              backgroundColor: AppColors.blue,
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(seconds: 1),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }, (r) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const DashboardScreen(),
                              ),
                            );
                          });
                        }
                      }),
                      builder: ((context, state) {
                        if (state is AuthInitiateState) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.blue,
                              foregroundColor: Colors.white,
                              textStyle: const TextStyle(
                                fontFamily: "Dana",
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                              minimumSize: const Size(200, 48),
                              shape: const BeveledRectangleBorder(),
                            ),
                            onPressed: () {
                              BlocProvider.of<AuthBloc>(context).add(
                                AuthRegisterRequestEvent(
                                  _usernameTextController.text,
                                  _passwordTextController.text,
                                  _passwordConfirmTextController.text,
                                ),
                              );
                            },
                            child: const Text("ثبت نام"),
                          );
                        }
                        if (state is AuthLoadingState) {
                          return const CircularProgressIndicator();
                        }
                        if (state is AuthResponseState) {
                          Widget widget = const Text("");
                          state.response.fold((l) {
                            widget = ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.blue,
                                foregroundColor: Colors.white,
                                textStyle: const TextStyle(
                                  fontFamily: "Dana",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                                minimumSize: const Size(200, 48),
                                shape: const BeveledRectangleBorder(),
                              ),
                              onPressed: () {
                                BlocProvider.of<AuthBloc>(context).add(
                                  AuthRegisterRequestEvent(
                                    _usernameTextController.text,
                                    _passwordTextController.text,
                                    _passwordConfirmTextController.text,
                                  ),
                                );
                              },
                              child: const Text(
                                "ثبت نام",
                                style: TextStyle(
                                  fontFamily: "Dana",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                            );
                          }, (r) {
                            widget = Text(r);
                          });
                          return widget;
                        }
                        return const Text("Unkown Error!");
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "حساب کاربری دارید؟",
                      style: TextStyle(
                        fontFamily: "Dana",
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginScreen();
                            },
                          ),
                        );
                      },
                      child: const Text(
                        "ورود",
                        style: TextStyle(
                          fontFamily: "Dana",
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
