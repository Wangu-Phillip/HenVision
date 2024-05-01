import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hen_vision/features/authentication/controllers/auth_page.dart';
import 'firebase_options.dart';

/// The main function of the application.
///
/// This function is responsible for initializing the Firebase app with the default options
/// for the current platform, and then running the main application widget, MyApp.
void main() async {

  // Ensures that widget binding has been initialized.
  // This is required before using any Flutter services.
  WidgetsFlutterBinding.ensureInitialized();


  // Initializes the Firebase app with the default options for the current platform.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

// Runs the main application widget.
  runApp(const MyApp());
}


/// The main application widget.
///
/// This widget is a stateless widget that builds the MaterialApp widget.
/// The MaterialApp widget is the root of your app and contains the navigation and theming.
class MyApp extends StatelessWidget {

  // Constructor for MyApp widget. It calls the superclass constructor with the key parameter.
  const MyApp({super.key});


  /// Builds the widget tree for the MyApp widget.
  ///
  /// Returns a MaterialApp widget with the specified theme and home page.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      // Disables the debug banner that appears in the top right corner in debug mode.
    debugShowCheckedModeBanner: false,

      // Sets the theme for the app.
      theme: ThemeData(
        // Sets the color scheme for the app using a seed color.
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

        // Specifies that the Material 3 design guidelines should be used.
        useMaterial3: true,
      ),

      // Sets the home page of the app.
      home: const AuthPage(),
    );
  }
}
