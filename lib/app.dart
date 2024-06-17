import 'package:enyad_store_3/bindings/general_bindings.dart';
import 'package:enyad_store_3/routes/app_routes.dart';
import 'package:enyad_store_3/utils/constants/colors.dart';
import 'package:enyad_store_3/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  // widget is the root application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: SAppTheme.lightTheme,
      darkTheme: SAppTheme.darkTheme,
      initialBinding: GeneralBindings(),

      getPages: AppRoutes.pages,

      ///--- show loading while authenticating ---
      home: const Scaffold(
        backgroundColor: SColors.purple,
        body: Center(
          child: RefreshProgressIndicator(
            color: Colors.white,
            backgroundColor: Colors.blue,
          ),
        ),
      ),
    );
  }
}
