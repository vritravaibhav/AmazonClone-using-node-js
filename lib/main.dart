import 'package:amazonclone/constants/global_variable.dart';
import 'package:amazonclone/features/auth/screens/auth_screen.dart';
import 'package:amazonclone/features/auth/services/auth_services.dart';
import 'package:amazonclone/home/screens/home_screens.dart';
import 'package:amazonclone/provider/user_provider.dart';
import 'package:amazonclone/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final AuthService authService = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Amazon Clone',
        theme: ThemeData(
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          colorScheme:
              ColorScheme.light(primary: GlobalVariables.secondaryColor),
          appBarTheme: const AppBarTheme(
              elevation: 0, iconTheme: IconThemeData(color: Colors.black)),
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: ((settings) => generateRoute(settings)),
        home: Provider.of<UserProvider>(context).user.token.isNotEmpty
            ? const HomeScreen()
            : const AuthScreen() 
        //
        );
  }
}
