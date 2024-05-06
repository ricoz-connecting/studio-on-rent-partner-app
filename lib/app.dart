import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/colors_scheme.g.dart';
import 'package:studio_partner_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:studio_partner_app/src/features/settings/provider/theme_provider.dart';
import 'package:studio_partner_app/src/utils/router.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeState = ref.watch(themeProvider);
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => AuthBloc())],
      child: MaterialApp.router(
        theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
        darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
        themeMode: themeModeState,
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
