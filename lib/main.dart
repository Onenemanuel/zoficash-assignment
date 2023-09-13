import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zoficash/blocs/blocs.dart';
import 'package:zoficash/constants/constants.dart';
import 'package:zoficash/router.dart';
import 'package:zoficash/styles/styles.dart';
import 'package:zoficash/widgets/widgets.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize hydrated bloc for persist data
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  // Add google fonts licence from assets
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  // Change navigation bar color on android
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.black.withOpacity(0.35),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  // Observe bloc changes for debugging
  // Bloc.observer = GlobalBlocObserver();

  /// Run app with MultiBlocProvider to load all blocs in the widget tree
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
            authBloc: context.read<AuthBloc>(),
          ),
        ),
        BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(
            authBloc: context.read<AuthBloc>(),
          ),
        ),
        BlocProvider<VerificationBloc>(
          create: (context) => VerificationBloc(
            authBloc: context.read<AuthBloc>(),
          ),
        ),
        BlocProvider<SecurityQuestionBloc>(
          create: (context) => SecurityQuestionBloc(
            authBloc: context.read<AuthBloc>(),
          ),
        ),
      ],
      // This is the default widget
      child: const Application(),
    ),
  );
}

class Application extends StatelessWidget {
  const Application({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Get AuthBloc instance
    var authBloc = context.read<AuthBloc>();
    // Generate initial route in AppRouter
    AppRouter.initialLocation = _generateInitialRoute(authBloc);

    // Setup theme, router configuration
    // and other requirements for Material App
    return MaterialApp.router(
      title: AppStrings.appName,
      themeMode: ThemeMode.light,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      theme: AppTheme(context: context).lightTheme,
    );
  }

  /// Generate initial route for goRouter
  String _generateInitialRoute(AuthBloc authBloc) {
    // Get auth status and auth user from auth bloc
    var authStatus = authBloc.state.authStatus;
    var authUser = authBloc.state.authUser;

    // Check if user is authenticated
    if (authStatus.authenticated) {
      // Check if the account is verified
      if (!authUser.isAccountVerified) {
        return VerificationScreen.route;
      }

      // Check if security question is setup
      if (!authUser.isSecurityQuestionSetup) {
        return LoginScreen.route;
      }

      return HomeScreen.route;
    } else {
      return LoginScreen.route;
    }
  }
}
