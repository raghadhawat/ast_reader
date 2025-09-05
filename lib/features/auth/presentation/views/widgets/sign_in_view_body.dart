import 'package:ast_reader/constants.dart';
import 'package:ast_reader/core/utils/app_assets.dart';
import 'package:ast_reader/core/utils/functions/navigate_function.dart';
import 'package:ast_reader/core/utils/functions/snack_bar.dart';
import 'package:ast_reader/core/utils/service_locator.dart';
import 'package:ast_reader/core/utils/style.dart';
import 'package:ast_reader/core/widgets/custom_button.dart';
import 'package:ast_reader/core/widgets/custom_text_form_field.dart';
import 'package:ast_reader/core/widgets/loading_button.dart';
import 'package:ast_reader/features/auth/data/repos/auth_repo_impl.dart';
import 'package:ast_reader/features/auth/presentation/manager/sign_in_cubit/sign_in_cubit.dart';
import 'package:ast_reader/features/auth/presentation/views/sign_up_view.dart';
import 'package:ast_reader/features/auth/presentation/views/widgets/auth_in_link.dart';
import 'package:ast_reader/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                    child: BlocProvider(
                      create: (context) =>
                          SignInCubit(getIt.get<AuthRepoImpl>()),
                      child: BlocConsumer<SignInCubit, SignInState>(
                        listener: (context, state) {
                          if (state is SignInsuccess) {
                            navigateAndFinish(context, HomeView());
                          }
                          if (state is SignInFailure) {
                            showAppError(context, state.errMessage);
                          }
                        },
                        builder: (context, state) {
                          return state is SignInLoading
                              ? ButtonLoading(
                                  width: 110, height: 50, color: kPrimaryColor)
                              : CustomButton(
                                  onPressed: () {
                                    // 🔑 Trigger all field validators
                                    final ok =
                                        _formKey.currentState?.validate() ??
                                            false;
                                    if (!ok) return;

                                    if (ok) {
                                      BlocProvider.of<SignInCubit>(context)
                                          .signInCubitFun(
                                        email: email,
                                        password: pass,
                                      );
                                    }
                                  },
                                  text: Text(
                                    'Sign In',
                                    style: AppStyles.arialBold(context, 20)
                                        .copyWith(color: Colors.white),
                                  ),
                                );
                        },
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
