import 'package:ast_reader/constants.dart';
import 'package:ast_reader/core/utils/app_assets.dart';
import 'package:ast_reader/core/utils/functions/navigate_function.dart';
import 'package:ast_reader/features/auth/presentation/views/sign_in_view.dart';
import 'package:ast_reader/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
    navigateToAuth();
  }

  @override
  void dispose() {
    super.dispose();

    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(Assets.imagesWhiteLogo),
        const SizedBox(
          height: 8,
        ),
        // SlidingSlogan(slidingAnimation: slidingAnimation),
      ],
    );
  }

  void navigateToAuth() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (kToken == null || kToken!.isEmpty) {
          navigateAndFinish(context, SignInView());
        } else {
          navigateAndFinish(context, HomeView());
        }

        //  GoRouter.of(context).pushReplacement(AppRouter.kSignIN);
        // Hive.box(kOnboarding).get('bool') == null || false
        //     ? GoRouter.of(context).pushReplacement(AppRouter.kOnboarduingView)
        //     : Hive.box(kTokenBox).get(kTokenRef) == null
        //         ? GoRouter.of(context).pushReplacement(AppRouter.kSignIN)
        //         : GoRouter.of(context).pushReplacement(AppRouter.kHomeView);

        // Get.to(() => const HomeView(),
        //     transition: Transition.fade, duration: kTransitionDuration);
      },
    );
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    slidingAnimation = Tween<Offset>(
      begin: const Offset(0, 4),
      end: Offset.zero,
    ).animate(animationController);
    animationController.forward();
  }
}
