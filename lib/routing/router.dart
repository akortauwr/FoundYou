import 'package:flutter/material.dart';
import 'package:found_you_app/data/repositories/auth/auth_repository.dart';
import 'package:found_you_app/ui/auth/login/view_models/login_view_model.dart';
import 'package:found_you_app/ui/auth/login/widgets/login_view.dart';
import 'package:found_you_app/ui/auth/register/view_models/register_form_view_model.dart';
import 'package:found_you_app/ui/auth/register/widgets/register_form_view.dart';
import 'package:found_you_app/ui/auth/register/widgets/register_view.dart';
import 'package:found_you_app/ui/auth/reset_password/view_models/reset_password_view_model.dart';
import 'package:found_you_app/ui/auth/reset_password/widgets/reset_password_view.dart';
import 'package:found_you_app/ui/home/view_models/home_view_model.dart';
import 'package:found_you_app/ui/home/views/home_view.dart';
import 'package:found_you_app/ui/home_shell/view_models/home_shell_view_model.dart';
import 'package:found_you_app/ui/home_shell/views/home_shell_view.dart';
import 'package:found_you_app/ui/profile/view_models/profile_view_model.dart';
import 'package:found_you_app/ui/profile/views/profile_view.dart';
import 'package:found_you_app/ui/swiping/view_models/friend_swipe_view_model.dart';
import 'package:found_you_app/ui/swiping/views/friend_swipe_view.dart';
import 'package:found_you_app/ui/test/test1/views/test1_view.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'paths.dart';

GoRouter router(AuthRepository authRepository) => GoRouter(
  initialLocation: Paths.home,
  debugLogDiagnostics: true,
  redirect: _redirect,
  refreshListenable: authRepository,
  routes: [
    // 1) ShellRoute – to będzie Twój wspólny Scaffold z bottom nav
    ShellRoute(
      builder: (context, state, child) {
        return ChangeNotifierProvider(
          create: (_) => HomeShellViewModel(),
          child: HomeShellView(
            currentLocation: state.matchedLocation,
            child: child,
          ),
        );
      },
      routes: [
        // 2) Pod ścieżkami shell-a umieszczasz tylko te ekrany,
        //    które mają wspólny bottom bar:
        GoRoute(
          path: Paths.home,
          name: 'home',
          pageBuilder: (ctx, st) => NoTransitionPage(
            child: ChangeNotifierProvider(
              create: (_) => HomeViewModel(),
              child: HomeView(viewModel: HomeViewModel(),),
            ),
          ),
        ),
        GoRoute(
          path: Paths.swipe,
          name: 'swipe',
          pageBuilder: (ctx, st) => NoTransitionPage(
            child: ChangeNotifierProvider(
              create: (_) => UserSwipeViewModel(
                repository: ctx.read(),
              )..loadUsers(),
              child: UserSwipeView(),
            ),
          ),
        ),
        GoRoute(
          path: Paths.profile,
          name: 'profile',
          pageBuilder: (ctx, st) => NoTransitionPage(
            child: ChangeNotifierProvider(
              create: (_) => ProfileViewModel(
                profileRepository: ctx.read(),
              )..loadProfile(),
              child: ProfileView(),
            ),
          ),
        ),
      ],
    ),

    // 3) Reszta tras (logowanie, rejestracja, reset hasła, test) poza shellem:
    GoRoute(
      path: Paths.login,
      name: 'login',
      builder: (context, state) => ChangeNotifierProvider(
        create: (ctx) => LoginViewModel(authRepository: ctx.read()),
        child: const LoginView(),
      ),
    ),
    GoRoute(
      path: Paths.resetPassword,
      name: 'reset',
      builder: (context, state) => ResetPasswordView(
        viewModel: ResetPasswordViewModel(authRepository: context.read()),
      ),
    ),
    GoRoute(
      path: Paths.register,
      name: 'register',
      builder: (context, state) => const RegisterView(),
    ),
    GoRoute(
      path: Paths.registerForm,
      name: 'registerForm',
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        return ChangeNotifierProvider(
          create: (_) => RegisterFormViewModel(authRepository: context.read())
            ..updateField('email', args['email'])
            ..updateField('password', args['password'])
            ..loadForm(),
          child: const RegisterFormPageView(),
        );
      },
    ),
    GoRoute(
      path: Paths.test,
      name: 'test',
      builder: (context, state) => const Test1View(),
    ),
  ],
);


Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  final loggedIn = await context.read<AuthRepository>().isLogged;
  final isLoggingPage = state.matchedLocation == Paths.login;
  final isResetPasswordPage = state.matchedLocation == Paths.resetPassword;
  final isRegisterPage = state.matchedLocation == Paths.register;
  final isRegisterFormPage = state.matchedLocation == Paths.registerForm;

  if (!loggedIn && !isResetPasswordPage && !isRegisterPage && !isRegisterFormPage) {
    return Paths.login;
  }

  if (isLoggingPage) {
    return Paths.home;
  }
  return null;
}
