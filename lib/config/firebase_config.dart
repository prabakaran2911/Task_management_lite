// lib/config/firebase_config.dart

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    // For Android and Web
    return const FirebaseOptions(
      apiKey:
          "AIzaSyBxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", // Replace with your Web API Key
      authDomain:
          "your-project.firebaseapp.com", // Replace with your Auth Domain
      projectId: "your-project-id", // Replace with your Project ID
      storageBucket:
          "your-project.appspot.com", // Replace with your Storage Bucket
      messagingSenderId: "123456789", // Replace with your Messaging Sender ID
      appId: "1:123456789:web:abcdef123456789", // Replace with your App ID
      measurementId:
          "G-XXXXXXXXXX", // Replace with your Measurement ID (optional)
    );
  }

  // If you need platform-specific configurations
  static FirebaseOptions get androidOptions {
    return const FirebaseOptions(
      apiKey: "AIzaSyBxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", // Android API Key
      appId: "1:123456789:android:abcdef123456789", // Android App ID
      messagingSenderId: "123456789",
      projectId: "your-project-id",
      storageBucket: "your-project.appspot.com",
    );
  }

  static FirebaseOptions get iosOptions {
    return const FirebaseOptions(
      apiKey: "AIzaSyBxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", // iOS API Key
      appId: "1:123456789:ios:abcdef123456789", // iOS App ID
      messagingSenderId: "123456789",
      projectId: "your-project-id",
      storageBucket: "your-project.appspot.com",
      iosClientId:
          "123456789-xxxxxxxx.apps.googleusercontent.com", // iOS Client ID
      iosBundleId: "com.yourdomain.appname", // iOS Bundle ID
    );
  }
}
