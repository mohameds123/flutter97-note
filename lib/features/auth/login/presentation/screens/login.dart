import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_flutteronline_97/core/widgets/app_button.dart';
import 'package:note_flutteronline_97/features/auth/sign_up/presentation/screens/signup.dart';
import 'package:note_flutteronline_97/features/create_note/presentation/screen/create_note_screen.dart';
import 'package:note_flutteronline_97/features/home/presentation/screen/home_screen.dart';


import '../../../../../core/widgets/app_txt_feild.dart';
import '../../logic/cubit.dart';
import '../../logic/state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => HomeScreen()));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Login Successful"),
                  duration: Duration(seconds: 3),
                ),

              );
            } else if (state is LoginErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  duration: Duration(seconds: 3),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 134,
                      ),
                      child: Column(
                        children: [
                          const Center(
                            child: Text(
                              "Login to your account",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 44),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Email",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),

                              TextFormFiledWidget(
                                hintTxt: 'example@gmail.com',
                                keyType: TextInputType.emailAddress,
                                controller: emailController,
                              ),

                              const SizedBox(height: 44),

                              const Text(
                                "Password",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),

                               TextFormFiledWidget(
                                obscureText: _isObscure,
                                hintTxt: 'Enter Your Password',
                                keyType: TextInputType.visiblePassword,
                                controller: passController,
                                suffIcon: IconButton(
                                  icon: Icon(
                                    _isObscure
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                ),
                              ),

                              const SizedBox(height: 77),
                              AppButton(function: () {
                                context
                                    .read<LoginCubit>()
                                    .continueWithGoogle();
                              }, buttonTxt: "Continue with google"),
                              const SizedBox(height: 12),
                              AppButton(function: () {
                                context.read<LoginCubit>().login(
                                    userEmail: emailController.text,
                                    userPass: passController.text);
                              }, buttonTxt: "Login"),


                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("don`t have an account?",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),),
                                  TextButton(onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => SignUpScreen()));
                                  }, child: Text("Sign Up", style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),))
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}