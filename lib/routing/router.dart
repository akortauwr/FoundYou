import 'package:flutter/material.dart';
import 'package:found_you_app/data/repositories/auth/auth_repository.dart';
import 'package:found_you_app/domain/models/suggested_friend/suggested_friend_model.dart';
import 'package:found_you_app/ui/auth/login/view_models/login_view_model.dart';
import 'package:found_you_app/ui/auth/login/widgets/login_view.dart';
import 'package:found_you_app/ui/auth/register/view_models/register_form_view_model.dart';
import 'package:found_you_app/ui/auth/register/view_models/register_view_model.dart';
import 'package:found_you_app/ui/auth/register/widgets/register_form_view.dart';
import 'package:found_you_app/ui/auth/register/widgets/register_view.dart';
import 'package:found_you_app/ui/auth/reset_password/view_models/reset_password_view_model.dart';
import 'package:found_you_app/ui/auth/reset_password/widgets/reset_password_view.dart';
import 'package:found_you_app/ui/chats/view_models/chats_view_model.dart';
import 'package:found_you_app/ui/chats/views/chats_view.dart';
import 'package:found_you_app/ui/conversation/view_models/conversation_view_model.dart';
import 'package:found_you_app/ui/conversation/views/conversation_view.dart';
import 'package:found_you_app/ui/edit_data/view_models/edit_data_view_model.dart';
import 'package:found_you_app/ui/edit_data/views/edit_data_view.dart';
import 'package:found_you_app/ui/home/view_models/home_view_model.dart';
import 'package:found_you_app/ui/home/views/home_view.dart';
import 'package:found_you_app/ui/home_shell/view_models/home_shell_view_model.dart';
import 'package:found_you_app/ui/home_shell/views/home_shell_view.dart';
import 'package:found_you_app/ui/near_you/view_models/near_you_view_model.dart';
import 'package:found_you_app/ui/new_matches/view_models/new_matches_view_model.dart';
import 'package:found_you_app/ui/profile/view_models/profile_view_model.dart';
import 'package:found_you_app/ui/profile/views/profile_view.dart';
import 'package:found_you_app/ui/profile/views/rules.dart';
import 'package:found_you_app/ui/profile/views/terms.dart';
import 'package:found_you_app/ui/recent_likes/view_models/recent_likes_view_model.dart';
import 'package:found_you_app/ui/swiping/view_models/friend_swipe_view_model.dart';
import 'package:found_you_app/ui/swiping/views/friend_swipe_view.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'paths.dart';

GoRouter router(AuthRepository authRepository) => GoRouter(
  initialLocation: Paths.home,
  debugLogDiagnostics: true,
  redirect: _redirect,
  refreshListenable: authRepository,
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return ChangeNotifierProvider(
          create: (_) => HomeShellViewModel(),
          child: HomeShellView(currentLocation: state.matchedLocation, child: child),
        );
      },
      routes: [
        GoRoute(
          path: Paths.home,
          name: 'home',
          pageBuilder: (ctx, st) {
            return NoTransitionPage(
              child: MultiProvider(
                providers: [
                  ChangeNotifierProvider<NewMatchesViewModel>(
                    create: (_) => NewMatchesViewModel(repository: ctx.read(), messengerRepository: ctx.read()),
                  ),
                  ChangeNotifierProvider<RecentLikesViewModel>(
                    create: (_) => RecentLikesViewModel(repository: ctx.read()),
                  ),
                  ChangeNotifierProvider<NearYouViewModel>(create: (_) => NearYouViewModel(repository: ctx.read())),
                  ChangeNotifierProxyProvider3<
                    NewMatchesViewModel,
                    RecentLikesViewModel,
                    NearYouViewModel,
                    HomeViewModel
                  >(
                    create:
                        (context) => HomeViewModel(
                          newMatchesVM: context.read<NewMatchesViewModel>(),
                          recentLikesVM: context.read<RecentLikesViewModel>(),
                          nearYouVM: context.read<NearYouViewModel>(),
                        ),
                    update:
                        (context, newVM, recentVM, nearVM, homeVM) =>
                            HomeViewModel(newMatchesVM: newVM, recentLikesVM: recentVM, nearYouVM: nearVM),
                  ),
                ],
                child: const HomeView(),
              ),
            );
          },
        ),
        GoRoute(
          path: Paths.swipe,
          name: 'swipe',
          pageBuilder:
              (ctx, st) => NoTransitionPage(
                child: ChangeNotifierProvider(
                  create: (_) => UserSwipeViewModel(repository: ctx.read())..loadUsers(),
                  child: const UserSwipeView(),
                ),
              ),
        ),
        GoRoute(
          path: Paths.profile,
          name: 'profile',
          pageBuilder:
              (ctx, st) => NoTransitionPage(
                child: ChangeNotifierProvider(
                  create:
                      (_) => ProfileViewModel(profileRepository: ctx.read(), authRepository: ctx.read())..loadProfile(),
                  child: const ProfileView(),
                ),
              ),
          routes: [
            GoRoute(
              path: Paths.rules,
              name: 'rules',
              builder: (context, state) {
                return const RulesView();
              },
            ),
            GoRoute(
              path: Paths.termsOfUse,
              name: 'termsOfUse',
              builder: (context, state) {
                return const TermsOfUseView();
              },
            ),
            GoRoute(
              path: Paths.editData,
              name: 'editData',
              builder: (context, state) {

                return ChangeNotifierProvider(
                  create: (ctx) =>
                  EditDataViewModel(authRepository: ctx.read(), profileRepository: ctx.read())
                    ..loadInitialData(),
                  child: const EditDataView(),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: Paths.chats,
          name: 'chats',
          pageBuilder:
              (context, state) => NoTransitionPage(
                child: ChangeNotifierProvider(
                  create: (_) => ChatsViewModel(messengerRepository: context.read()),
                  child: const ChatsView(),
                ),
              ),
          routes: [
            GoRoute(
              path: 'conversation/:chatId',
              name: 'conversation',
              builder: (context, state) {
                final chatId = int.parse(state.pathParameters['chatId']!);
                final chatPartner = state.extra as SuggestedFriendModel;
                return ChangeNotifierProvider(
                  create:
                      (_) => ConversationViewModel(
                        chatId: chatId,
                        messengerRepository: context.read(),
                        chatPartner: chatPartner,
                      ),
                  child: const ConversationView(),
                );
              },
            ),
          ],
        ),
      ],
    ),

    GoRoute(
      path: Paths.login,
      name: 'login',
      builder:
          (context, state) => ChangeNotifierProvider(
            create: (ctx) => LoginViewModel(authRepository: ctx.read()),
            child: const LoginView(),
          ),
    ),
    GoRoute(
      path: Paths.resetPassword,
      name: 'resetPassword',
      builder:
          (context, state) => ChangeNotifierProvider(
            create: (ctx) => ResetPasswordViewModel(repository: ctx.read()),
            child: const ResetPasswordView(),
          ),
    ),
    GoRoute(
      path: Paths.register,
      name: 'register',
      builder:
          (context, state) =>
          ChangeNotifierProvider(
            create: (ctx) => RegisterViewModel(),
            child: const RegisterView(),
          ),
      routes: [
        GoRoute(
          path: Paths.registerForm,
          name: 'registerForm',
          builder: (context, state) {
            final args = state.extra as Map<String, dynamic>;
            return ChangeNotifierProvider(
              create:
                  (_) =>
                      RegisterFormViewModel(authRepository: context.read())
                        ..updateField('email', args['email'])
                        ..updateField('password', args['password'])
                        ..loadForm(),
              child: const RegisterFormPageView(),
            );
          },
        ),
      ],
    ),
  ],
);

Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  final loggedIn = await context.read<AuthRepository>().isLogged;
  final isLoggingPage = state.matchedLocation == Paths.login;
  final isResetPasswordPage = state.matchedLocation == Paths.resetPassword;
  final isRegisterPage = state.matchedLocation == Paths.register;
  final isRegisterFormPage = state.matchedLocation == '/register/register-form';

  if (!loggedIn && !isResetPasswordPage && !isRegisterPage && !isRegisterFormPage) {
    return Paths.login;
  }

  if (isLoggingPage) {
    return Paths.home;
  }
  return null;
}
