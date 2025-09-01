import 'dart:developer';
import 'package:ast_reader/core/utils/app_assets.dart';
import 'package:ast_reader/core/utils/functions/navigate_function.dart';
import 'package:ast_reader/core/utils/style.dart';
import 'package:ast_reader/core/widgets/custom_button.dart';
import 'package:ast_reader/core/widgets/custom_text_form_field.dart';
import 'package:ast_reader/features/auth/presentation/views/sign_up_view.dart';
import 'package:ast_reader/features/auth/presentation/views/widgets/auth_in_link.dart';
import 'package:ast_reader/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SignInViewBody extends StatefulWidget {
  const SignInViewBody({super.key});

  @override
  State<SignInViewBody> createState() => _SignInViewBodyState();
}

class _SignInViewBodyState extends State<SignInViewBody> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController emailController;
  late TextEditingController passController;

  String email = '';
  String pass = '';
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
                  Text('Sign In', style: AppStyles.arialBold(context, 32)),
                  const Gap(34),
                  Text(
                    'welcome again please enter your email and password',
                    style: AppStyles.styleRegular17(context),
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

                  Center(
                    child: CustomButton(
                      onPressed: () {
                        // 🔑 Trigger all field validators
                        final ok = _formKey.currentState?.validate() ?? false;
                        if (!ok) return;

                        // proceed (all fields valid)3
                        log(email);
                        log(pass);
                        navigateAndFinish(context, HomeView());
                      },
                      text: Text(
                        'Sign In',
                        style: AppStyles.arialBold(context, 20)
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(71),
              Center(
                child: AuthInlineLink(
                  actionText: 'Sign Up', // probably Sign up on a Sign in screen
                  question: 'Don’t have an account?',
                  onTap: () {
                    navigateTo(context, SignUpView());
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
    emailController = TextEditingController();
    passController = TextEditingController();
    emailController.addListener(() {
      email = emailController.text;
      setState(() {});
    });
    passController.addListener(() {
      pass = passController.text;
      setState(() {});
    });
  }
}
