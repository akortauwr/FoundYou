import 'package:flutter/material.dart';
import 'package:found_you_app/data/repositories/auth/auth_repository.dart';
import 'package:found_you_app/domain/models/suggested_friend/suggested_friend_model.dart';
import 'package:found_you_app/domain/models/user_model/user_model.dart';
import 'package:found_you_app/ui/auth/edit_data/view_models/edit_data_view_model.dart';
import 'package:found_you_app/ui/auth/edit_data/views/edit_data_view.dart';
import 'package:found_you_app/ui/auth/login/view_models/login_view_model.dart';
import 'package:found_you_app/ui/auth/login/widgets/login_view.dart';
import 'package:found_you_app/ui/auth/register/view_models/register_form_view_model.dart';
import 'package:found_you_app/ui/auth/register/widgets/register_form_view.dart';
import 'package:found_you_app/ui/auth/register/widgets/register_view.dart';
import 'package:found_you_app/ui/auth/reset_password/view_models/reset_password_view_model.dart';
import 'package:found_you_app/ui/auth/reset_password/widgets/reset_password_view.dart';
import 'package:found_you_app/ui/chats/view_models/chats_view_model.dart';
import 'package:found_you_app/ui/chats/views/chats_view.dart';
import 'package:found_you_app/ui/conversation/view_models/conversation_view_model.dart';
import 'package:found_you_app/ui/conversation/views/conversation_view.dart';

import 'package:found_you_app/ui/home/view_models/home_view_model.dart';
import 'package:found_you_app/ui/home/views/home_view.dart';
import 'package:found_you_app/ui/home_shell/view_models/home_shell_view_model.dart';
import 'package:found_you_app/ui/home_shell/views/home_shell_view.dart';
import 'package:found_you_app/ui/near_you/view_models/near_you_view_model.dart';
import 'package:found_you_app/ui/new_matches/view_models/new_matches_view_model.dart';
import 'package:found_you_app/ui/profile/view_models/profile_view_model.dart';
import 'package:found_you_app/ui/profile/views/profile_view.dart';
import 'package:found_you_app/ui/recent_likes/view_models/recent_likes_view_model.dart';
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
          child: HomeShellView(currentLocation: state.matchedLocation, child: child),
        );
      },
      routes: [
        // 2) Pod ścieżkami shell-a umieszczasz tylko te ekrany,
        //    które mają wspólny bottom bar:
        GoRoute(
          path: Paths.home,
          name: 'home',
          pageBuilder: (ctx, st) {
            // Tu wstrzykujemy repozytorium dla SuggestedFriendsRepository
            // za pomocą .read<SuggestedFriendsRepository>() na kontekście.
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
                  child: UserSwipeView(),
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
                  child: ProfileView(),
                ),
              ),
          routes: [
            GoRoute(
              path: Paths.editData, // Ścieżka względna do profilu, np. /profile/edit-data
              name: 'editData',
              builder: (context, state) {
                // KROK 1: Odbierz obiekt UserModel z parametru 'extra'
                // Rzutujemy go na typ UserModel, ponieważ wiemy, co przekazaliśmy.
                final user = state.extra as UserModel;

                // KROK 2: Przekaż odebrany obiekt do ViewModelu
                return ChangeNotifierProvider(
                  create: (ctx) => EditDataViewModel(
                    authRepository: ctx.read(),
                    initialUser: user, // <-- Używamy przekazanego użytkownika zamiast null!
                  )..loadForm(), // Od razu ładujemy i inicjalizujemy formularz
                  child: const EditDataView(),
                );
              },
            ),
          ]
        ),
        GoRoute(
          path: Paths.chats, // czyli '/chats'
          name: 'chats', // Dodajemy nazwę dla spójności
          pageBuilder:
              (context, state) => NoTransitionPage(
                // Używamy pageBuilder, by nie było animacji między zakładkami
                child: ChangeNotifierProvider(
                  create: (_) => ChatsViewModel(messengerRepository: context.read()),
                  child: const ChatsView(),
                ),
              ),
          routes: [
            // Zagnieżdżamy trasę konwersacji jako "dziecko" listy czatów
            GoRoute(
              // --- ZMIANA 2: Ścieżka jest teraz WZGLĘDNA (bez '/' na początku) ---
              path: 'conversation/:chatId',
              name: 'conversation', // Dajemy jej nazwę, np. 'conversation'
              builder: (context, state) {
                // --- ZMIANA 3: Poprawiamy nazwę parametru na 'chatId' ---
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

    // 3) Reszta tras (logowanie, rejestracja, reset hasła, test) poza shellem:
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
            create: (ctx) => ResetPasswordViewModel(authRepository: ctx.read()),
            child: ResetPasswordView(),
          ),
    ),
    GoRoute(path: Paths.register, name: 'register', builder: (context, state) => const RegisterView(), routes: [
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
    ]),

    GoRoute(path: Paths.test, name: 'test', builder: (context, state) => const Test1View()),
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
