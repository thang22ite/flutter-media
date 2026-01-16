import 'dart:async';
import 'dart:developer';

import 'package:app_ui/app_ui.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_social_media/app/di/di.dart';
import 'package:powersync_repository/powersync_repository.dart';
import 'package:shared/shared.dart';

typedef AppBuilder =
    FutureOr<Widget> Function(
      PowerSyncRepository,
      // FirebaseMessaging,
      // SharedPreferences,
      // FirebaseRemoteConfigRepository,
    );

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError ${bloc.runtimeType}', error: error, stackTrace: stackTrace);
    super.onError(bloc, error, stackTrace);
  }
}

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();

//   logI('Handling a background message: ${message.toMap()}');
// }

Future<void> bootstrap(
  AppBuilder builder, {
  required AppFlavor appFlavor,
  required FirebaseOptions options,
}) async {
  FlutterError.onError = (details) {
    logE(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      setupDi(appFlavor: appFlavor);
      await Firebase.initializeApp();

      // HydratedBloc.storage = await HydratedStorage.build(
      //   storageDirectory: kIsWeb
      //       ? HydratedStorageDirectory.web
      //       : HydratedStorageDirectory((await getTemporaryDirectory()).path),
      // );

      final powerSyncRepository = PowerSyncRepository(env: appFlavor.getEnv);
      await powerSyncRepository.initialize();

      // final firebaseMessaging = FirebaseMessaging.instance;
      // FirebaseMessaging.onBackgroundMessage(
      //   _firebaseMessagingBackgroundHandler,
      // );

      // final sharedPreferences = await SharedPreferences.getInstance();

      // final firebaseRemoteConfig = FirebaseRemoteConfig.instance;
      // final firebaseRemoteConfigRepository = FirebaseRemoteConfigRepository(
      //   firebaseRemoteConfig: firebaseRemoteConfig,
      // );

      SystemUiOverlayTheme.setPortraitOrientation();

      runApp(
        await builder(
          powerSyncRepository,
          // firebaseMessaging,
          // sharedPreferences,
          // firebaseRemoteConfigRepository,
        ),
      );
    },
    (error, stack) {
      logE(error.toString(), stackTrace: stack);
    },
  );
}
