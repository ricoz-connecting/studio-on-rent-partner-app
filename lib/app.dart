import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/colors_scheme.g.dart';
import 'package:studio_partner_app/src/features/auth/data/datasource/remote_data_source.dart';
import 'package:studio_partner_app/src/features/auth/data/repository/auth_repository_impl.dart';
import 'package:studio_partner_app/src/features/auth/domain/usecase/get_otp.dart';
import 'package:studio_partner_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:studio_partner_app/src/features/register/data/datasource/remote_data_source.dart';
import 'package:studio_partner_app/src/features/register/data/repository/register_repository_impl.dart';
import 'package:studio_partner_app/src/features/register/domain/usecase/resgister_usecase.dart';
import 'package:studio_partner_app/src/features/register/presentation/bloc/register_bloc.dart';
import 'package:studio_partner_app/src/features/settings/provider/theme_provider.dart';
import 'package:studio_partner_app/src/features/stores/data/datasource/remote_data_source.dart';
import 'package:studio_partner_app/src/features/stores/data/repository/add_studio_repository_impl.dart';
import 'package:studio_partner_app/src/features/stores/domain/usecase/get_category_data.dart';
import 'package:studio_partner_app/src/features/stores/domain/usecase/get_user_location.dart';
import 'package:studio_partner_app/src/features/stores/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:studio_partner_app/src/features/stores/presentation/bloc/location_bloc/location_bloc.dart';
import 'package:studio_partner_app/src/features/stores/presentation/bloc/map_bloc/map_bloc.dart';
import 'package:studio_partner_app/src/utils/router.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeState = ref.watch(themeProvider);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => LocationBloc(
                getUserLocation: GetUserLocation(
                    addStudioRepository: AddStudioRepositoryImpl(
                        remoteDataSource: StoreRemoteDataSourceImpl())))),
        BlocProvider(
            create: (context) => AuthBloc(
                isVerified: IsVerified(
                    authRepository:
                        AuthRepositoryImpl(dataSource: AuthDataSourceImpl())),
                getOtp: GetOtp(
                    authRepository:
                        AuthRepositoryImpl(dataSource: AuthDataSourceImpl())))),
        BlocProvider(
            create: (context) => RegisterBloc(
                registerUsecase: RegisterUsecase(
                    registerRepository: RegisterRepositoryImpl(
                        remoteDataSource: RemoteDataSourceImpl())))),
        BlocProvider(create: (context) => MapBloc()),
        BlocProvider(
            create: (context) => CategoryBloc(
                getCategoryData: GetCategoryData(
                    addStudioRepository: AddStudioRepositoryImpl(
                        remoteDataSource: StoreRemoteDataSourceImpl()))))
      ],
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
