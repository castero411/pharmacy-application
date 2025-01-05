import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import 'package:medicine_manager/UI/Pages/common/widgets/custom_form_field.dart';
import 'package:medicine_manager/UI/Pages/common/widgets/wide_button.dart';
import 'package:medicine_manager/firebase/update_username.dart';

class EditAccountPage extends ConsumerWidget {
  EditAccountPage({super.key});

  final _formKey = GlobalKey<FormState>();

  //parameters that will be needed to update the username
  final TextEditingController _newUsernameController = TextEditingController();

  final userId = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double gapSize = 28; // for easier customization when adding flexibility

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Account Edit",
          style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).primaryColor,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 100.0, right: 100.0, bottom: 25.0),
        child: WideButton(
          title: 'Submit',
          onTap: () async {
            // Execute the edit account credentials process when the button is tapped
            if (_formKey.currentState?.validate() ?? false) {
              // Form is valid, perform edit account credentials
              final newUsername = _newUsernameController.text;
              editNewUsername(userId.toString(), newUsername);
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(23),
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

                Padding(
                  padding: const EdgeInsets.only(top: 25.0, bottom: 50.0),
                  child: Icon(
                    Icons.build_rounded,
                    color: Theme.of(context).primaryColor,
                    size: 130,
                  ),
                ),

                CustomFormField(
                    hint: "New Username",
                    obscure: false,
                    controller: _newUsernameController),

                Gap(gapSize - 10),

                Gap(gapSize * 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
