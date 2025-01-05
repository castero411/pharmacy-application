// ignore_for_file: unused_element, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:medicine_manager/UI/Pages/common/widgets/custom_form_field.dart';
import 'package:medicine_manager/UI/Pages/common/widgets/wide_button.dart';
import 'package:medicine_manager/UI/Theme/Text_style.dart';
import 'package:medicine_manager/UI/Theme/colors.dart';
import 'package:medicine_manager/firebase/create_user_document.dart';
import 'package:medicine_manager/functions/validation/email_form_validation.dart';

class SignupPage extends ConsumerWidget {
  SignupPage({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  Future<void> _signUp(WidgetRef ref, BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      // Form is valid, perform the sign-up
      final username = usernameController.text;
      final email = emailController.text;
      final password = passwordController.text;

      try {
        // Sign up with Firebase Authentication
        final UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // After successful sign-up, save additional details (like username)
        final user = userCredential.user;
        if (user != null) {
          createEmptyUserDocument(username: username, email: email);

          // Navigate to the main page after successful registration
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, 'main_page');
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'Sign-up failed';
        if (e.code == 'email-already-in-use') {
          errorMessage =
              'The email is already in use. Please choose another one.';
        } else if (e.code == 'weak-password') {
          errorMessage =
              'The password is too weak. Please choose a stronger password.';
        }

        // Display error message
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errorMessage)));
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double gapSize = 28; // for easier customization when adding flexibility

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(23),
        child: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formKey,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'MedGuard',
                    style: TextStyle(
                        color: xMainColor,
                        fontSize: 50,
                        fontWeight: FontWeight.w900),
                  ),
                  Gap(gapSize * 2),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Create a new account',
                      textAlign: TextAlign.left,
                      style: bigTextStyle,
                    ),
                  ),
                  Gap(gapSize),
                  CustomFormField(
                    // username text form field
                    hint: 'Username',
                    obscure: false,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a username' : null,
                    controller: usernameController,
                  ),
                  Gap(gapSize - 5),
                  CustomFormField(
                    // email text form field
                    hint: 'Email',
                    obscure: false,
                    validator: emailValidator,
                    controller: emailController,
                  ),
                  Gap(gapSize),
                  CustomFormField(
                    // password text form field
                    hint: 'Password',
                    obscure: true,
                    validator: passwordValidator,
                    controller: passwordController,
                  ),
                  Gap(gapSize),
                  WideButton(
                    title: 'Sign up',
                    onTap: () => _signUp(ref, context),
                  ),
                  Gap(gapSize * 2),
                  Divider(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
