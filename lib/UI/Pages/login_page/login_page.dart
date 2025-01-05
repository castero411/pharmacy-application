import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import 'package:medicine_manager/UI/Pages/common/widgets/custom_form_field.dart';
import 'package:medicine_manager/UI/Pages/common/widgets/wide_button.dart';
import 'package:medicine_manager/UI/Theme/Text_style.dart';
import 'package:medicine_manager/UI/Theme/colors.dart';
import 'package:medicine_manager/functions/validation/email_form_validation.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to handle login

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double gapSize = 28; // for easier customization when adding flexibility

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(23),
        child: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo (you can replace this with an actual logo)
                  Text(
                    'MedGuard',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 50,
                        fontWeight: FontWeight.w900),
                  ),
                  Gap(gapSize * 2),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Welcome Back!',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Gap(gapSize),
                  CustomFormField(
                    // Username text form field
                    hint: 'Email',
                    obscure: false,
                    validator: usernameValidator,
                    controller: _usernameController,
                  ),
                  Gap(gapSize - 5),
                  CustomFormField(
                    // Password text form field
                    hint: 'Password',
                    obscure: true,
                    validator: passwordValidator,
                    controller: _passwordController,
                  ),

                  Gap(gapSize - 10),
                  InkWell(
                    child: Text(
                      "Don't Have an account ?",
                      style: mediumTextStyle.copyWith(
                          color: xMainColor, fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed("signup_page");
                    },
                  ),
                  Gap(gapSize - 10),

                  WideButton(
                    title: 'Log in',
                    onTap: () async {
                      // Execute the login process when the button is tapped
                      if (_formKey.currentState?.validate() ?? false) {
                        // Form is valid, perform login
                        final username = _usernameController.text;
                        final password = _passwordController.text;

                        try {
                          // Sign in with Firebase Authentication
                          await _auth.signInWithEmailAndPassword(
                            email:
                                username, // Firebase uses email as the username
                            password: password,
                          );

                          // Once logged in, save user data to SharedPreferences

                          // Navigate to the main page
                          Navigator.of(context)
                              .pushReplacementNamed('main_page');
                        } on FirebaseAuthException catch (e) {
                          // Handle Firebase errors (invalid email, wrong password, etc.)
                          String errorMessage = 'Login failed';
                          if (e.code == 'user-not-found') {
                            errorMessage = 'No user found for that email.';
                          } else if (e.code == 'wrong-password') {
                            errorMessage = 'Wrong password provided.';
                          }

                          // Show error message to the user
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(errorMessage)));
                        }
                      }
                    },
                  ),
                  Gap(gapSize * 2),
                  Divider(),
                  Gap(gapSize),
                  //TODO add log in with gmail and facebook
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     LoginWithButton(
                  //       onTap: () {
                  //         // Handle Google login
                  //       },
                  //       faIcon: FontAwesomeIcons.google,
                  //     ),
                  //     LoginWithButton(
                  //       onTap: () {
                  //         // Handle Facebook login
                  //       },
                  //       faIcon: FontAwesomeIcons.facebook,
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
