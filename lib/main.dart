import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:task_mngmt/config/theme/theme_provider.dart';
import 'package:task_mngmt/provider/auth_provider.dart';
import 'package:task_mngmt/provider/task_provider.dart';
import 'package:task_mngmt/screen/authentication/log.dart';
import 'package:task_mngmt/screen/home_screen.dart';
import 'config/firebase_config.dart';

Future<FirebaseApp> initializeFirebase() async {
  try {
    // Get the existing app if it exists
    if (Firebase.apps.isNotEmpty) {
      return Firebase.app();
    }

    // Initialize new app if none exists
    return await Firebase.initializeApp(
      options: DefaultFirebaseConfig.platformOptions,
    );
  } on FirebaseException catch (e) {
    if (e.code == 'duplicate-app') {
      // If we get a duplicate app error, return the existing app
      return Firebase.app();
    } else {
      // Rethrow if it's a different Firebase error
      rethrow;
    }
  } catch (e) {
    debugPrint('Unexpected error during Firebase initialization: $e');
    rethrow;
  }
}

class InitWidget extends StatelessWidget {
  final Widget child;

  const InitWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeFirebase(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Text('Error initializing Firebase: ${snapshot.error}'),
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return child;
        }

        return const MaterialApp(
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const InitWidget(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProxyProvider<AuthProvider, TaskProvider>(
          create: (context) => TaskProvider(
            userId: context.read<AuthProvider>().currentUser?.uid ?? '',
          ),
          update: (context, auth, previous) => TaskProvider(
            userId: auth.currentUser?.uid ?? '',
          ),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'Task Manager',
            theme: themeProvider.lightTheme,
            darkTheme: themeProvider.darkTheme,
            themeMode: themeProvider.themeMode,
            home: Consumer<AuthProvider>(
              builder: (context, authProvider, _) {
                return authProvider.currentUser != null
                    ? const HomeScreen()
                    : const LoginScreen();
              },
            ),
          );
        },
      ),
    );
  }
}
