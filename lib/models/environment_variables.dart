import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentVariables {
  static String get fileName {
    return '.env';
  }

  static String get firebaseMessengerSenderId {
    return dotenv.env['MESSAGE_SENDER_ID'] ?? 'Firebase Messenger ID not found';
  }

  static String get firebaseProjectId {
    return dotenv.env['PROJECT_ID'] ?? 'Firebase Project ID not found';
  }

  static String get firebaseAuthDomain {
    return dotenv.env['AUTH_DOMAIN'] ?? 'Firebase Auth Domain not found';
  }

  static String get firebaseStorageBucket {
    return dotenv.env['STORAGE_BUCKET'] ?? 'Firebase Storage Bucket not found';
  }

  static String get firebaseApiKeyWeb {
    return dotenv.env['API_KEY_WEB'] ?? 'Firebase Web API Key not found';
  }

  static String get firebaseAppIdWeb {
    return dotenv.env['APP_ID_WEB'] ?? 'Firebase Web APP ID not found';
  }

  static String get firebaseApiKeyAndroid {
    return dotenv.env['API_KEY_ANDROID'] ??
        'Firebase Android API Key not found';
  }

  static String get firebaseAppIdAndroid {
    return dotenv.env['APP_ID_ANDROID'] ?? 'Firebase Android APP ID not found';
  }

  static String get firebaseApiKeyIos {
    return dotenv.env['API_KEY_IOS'] ?? 'Firebase IOS API Key not found';
  }

  static String get firebaseAppIdIos {
    return dotenv.env['APP_ID_IOS'] ?? 'Firebase IOS APP ID not found';
  }

  static String get firebaseClientIdIos {
    return dotenv.env['CLIENT_ID_IOS'] ?? 'Firebase IOS CLIENT ID not found';
  }

  static String get firebaseBundleIdIos {
    return dotenv.env['BUNDLE_ID_IOS'] ?? 'Firebase IOS BUNDLE ID not found';
  }
}
