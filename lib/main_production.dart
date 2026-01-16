import 'package:api_repository/api_repository.dart';
import 'package:env/env.dart';
import 'package:flutter_social_media/app/app.dart';
import 'package:flutter_social_media/app/view/app.dart';
import 'package:flutter_social_media/bootstrap.dart';
import 'package:flutter_social_media/firebase_options_prod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared/shared.dart';
import 'package:supabase_authentication_client/supabase_authentication_client.dart';
import 'package:token_storage/token_storage.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  bootstrap(
    (powerSyncRepository) {
      final iOSClientId = getIt<AppFlavor>().getEnv(Env.iOSClientId);
      final webClientId = getIt<AppFlavor>().getEnv(Env.webClientId);
      final tokenStorage = InMemoryTokenStorage();
      final googleSignIn = GoogleSignIn(
        clientId: iOSClientId,
        serverClientId: webClientId,
      );
      final supabaseAuthenticationClient = SupabaseAuthenticationClient(
        powerSyncRepository: powerSyncRepository, 
        tokenStorage: tokenStorage, 
        googleSignIn: googleSignIn
      );
      final userRepository = UserRepository(
        databaseClient: databaseClient, 
        authenticationClient: supabaseAuthenticationClient
      );
      return App(userRepository: userRepository);
    },
    appFlavor: AppFlavor.production(),
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
