import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_flutteronline_97/features/auth/sign_up/logic/cubit.dart';
import 'package:note_flutteronline_97/features/auth/sign_up/logic/state.dart';

import '../../../../../core/widgets/app_txt_feild.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isObscure = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocProvider(
        create: (context) => SignUpCubit(),
        child: BlocConsumer<SignUpCubit, SignUpStates>(
          listener: (context, state) {
            if (state is SignUpSuccessState){
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Sign Up Successful"),
                  duration: Duration(seconds: 3),
                ),
              );
            }else if (state is SignUpErrorState){
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
                        horizontal: 45,
                        vertical: 134,
                      ),
                      child: Column(
                        children: [
                          const Center(
                            child: Text(
                              "Create New Account",
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

                              InkWell(
                                onTap: () {
                                  context.read<SignUpCubit>().signUp(userEmail: emailController.text, userPass: passController.text);
                                },
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  width: 312,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                  ),
                                  child:  Center(
                                    child: (state is SignUpLoadingState)? CircularProgressIndicator():Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
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