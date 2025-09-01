import 'dart:developer';

import 'package:ast_reader/core/utils/app_assets.dart';
import 'package:ast_reader/core/utils/style.dart';
import 'package:ast_reader/core/widgets/custom_button.dart';
import 'package:ast_reader/core/widgets/custom_text_form_field.dart';
import 'package:ast_reader/features/auth/presentation/views/widgets/auth_in_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController userNameController;
  late TextEditingController emailController;
  late TextEditingController passController;
  late TextEditingController confPassController;

  String name = '';
  String email = '';
  String pass = '';
  String confPass = '';
  bool showPass = true;

  @override
  void initState() {
    super.initState();
    listenControllers();
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    userNameController.dispose();
    confPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Form(
          // <- wrap with Form
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(Assets.imagesBlueLogo),
              const Gap(73),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sign Up', style: AppStyles.arialBold(context, 32)),

                  const Gap(34),
                  CustomTextFormField(
                    textEditingController: userNameController,

                    icon: SvgPicture.asset(Assets.imagesUserName),
                    hintText: 'userName',
                    // make sure CustomTextFormField forwards this to TextFormField.validator
                  ),

                  const Gap(34),
                  // EMAIL
                  CustomTextFormField(
                    textEditingController: emailController,
                    keyboardType: TextInputType.emailAddress,
                    icon: SvgPicture.asset(Assets.imagesEmail),
                    hintText: 'email',
                    // make sure CustomTextFormField forwards this to TextFormField.validator
                  ),

                  const Gap(34),

                  // PASSWORD
                  CustomTextFormField(
                    textEditingController: passController,
                    showPass: showPass, // should map to obscureText internally
                    icon: SvgPicture.asset(Assets.imagesPassword),
                    hintText: 'password',
                    onTap: () => setState(() => showPass = !showPass),
                  ),

                  const Gap(34),
                  CustomTextFormField(
                    textEditingController: confPassController,
                    showPass: showPass, // should map to obscureText internally
                    icon: SvgPicture.asset(Assets.imagesConfPass),
                    hintText: 'confirm password',
                    onTap: () => setState(() => showPass = !showPass),
                  ),

                  const Gap(34),
                  Center(
                    child: CustomButton(
                      onPressed: () {
                        // 🔑 Trigger all field validators
                        final ok = _formKey.currentState?.validate() ?? false;
                        if (!ok) return;

                        // proceed (all fields valid)
                        log(email);
                        log(pass);
                      },
                      text: Text(
                        'Sign up',
                        style: AppStyles.arialBold(context, 20)
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(50),
              Center(
                child: AuthInlineLink(
                  actionText: 'Sign In', // probably Sign up on a Sign in screen
                  question: 'you already have an account',
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void listenControllers() {
    userNameController = TextEditingController();
    emailController = TextEditingController();
    passController = TextEditingController();
    confPassController = TextEditingController();
    emailController.addListener(() {
      email = emailController.text;
      setState(() {});
    });
    passController.addListener(() {
      pass = passController.text;
      setState(() {});
    });
    confPassController.addListener(() {
      confPass = confPassController.text;
      setState(() {});
    });
    userNameController.addListener(() {
      name = userNameController.text;
      setState(() {});
    });
  }
}
