import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/colors_scheme.g.dart';
import 'package:studio_partner_app/src/features/auth/data/datasource/remote_data_source.dart';
import 'package:studio_partner_app/src/features/auth/data/repository/auth_repository_impl.dart';
import 'package:studio_partner_app/src/features/auth/domain/usecase/get_otp.dart';
import 'package:studio_partner_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:studio_partner_app/src/features/earnings/data/datasource/earning_data_source.dart';
import 'package:studio_partner_app/src/features/earnings/data/repository/earning_repository_impl.dart';
import 'package:studio_partner_app/src/features/earnings/domain/usecase/earnings_usecase.dart';
import 'package:studio_partner_app/src/features/earnings/domain/usecase/payment_usecase.dart';
import 'package:studio_partner_app/src/features/earnings/domain/usecase/review_usecase.dart';
import 'package:studio_partner_app/src/features/earnings/presentation/bloc/earning_bloc/earning_bloc.dart';
import 'package:studio_partner_app/src/features/earnings/presentation/bloc/review_bloc/review_bloc.dart';
import 'package:studio_partner_app/src/features/earnings/presentation/bloc/withdraw_bloc/withdraw_bloc.dart';
import 'package:studio_partner_app/src/features/help/data/datasource/help_data_source.dart';
import 'package:studio_partner_app/src/features/help/data/repository/help_repository_impl.dart';
import 'package:studio_partner_app/src/features/help/domain/usecase/get_help.dart';
import 'package:studio_partner_app/src/features/help/domain/usecase/get_issues.dart';
import 'package:studio_partner_app/src/features/help/domain/usecase/send_issues.dart';
import 'package:studio_partner_app/src/features/help/presentation/bloc/help_bloc/help_bloc.dart';
import 'package:studio_partner_app/src/features/help/presentation/bloc/issues_bloc/issues_bloc.dart';
import 'package:studio_partner_app/src/features/home/data/datasource/home_remote_data_source.dart';
import 'package:studio_partner_app/src/features/home/data/repository/booking_repository_impl.dart';
import 'package:studio_partner_app/src/features/home/domain/usecase/get_chat.dart';
import 'package:studio_partner_app/src/features/home/domain/usecase/get_schedules.dart';
import 'package:studio_partner_app/src/features/home/domain/usecase/get_stores.dart';
import 'package:studio_partner_app/src/features/home/domain/usecase/update_schedule.dart';
import 'package:studio_partner_app/src/features/home/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:studio_partner_app/src/features/home/presentation/bloc/schedule_bloc/schedules_bloc.dart';
import 'package:studio_partner_app/src/features/home/presentation/bloc/store_bloc/store_bloc.dart';
import 'package:studio_partner_app/src/features/profile/data/datasource/update_data_source.dart';
import 'package:studio_partner_app/src/features/profile/data/repository/update_repository_impl.dart';
import 'package:studio_partner_app/src/features/profile/domain/usecase/add_bank.dart';
import 'package:studio_partner_app/src/features/profile/domain/usecase/get_bank_details.dart';
import 'package:studio_partner_app/src/features/profile/domain/usecase/update_usecase.dart';
import 'package:studio_partner_app/src/features/profile/prsesntation/bloc/bank_details/bank_details_bloc.dart';
import 'package:studio_partner_app/src/features/profile/prsesntation/bloc/update_bloc/update_bloc.dart';
import 'package:studio_partner_app/src/features/register/data/datasource/remote_data_source.dart';
import 'package:studio_partner_app/src/features/register/data/repository/register_repository_impl.dart';
import 'package:studio_partner_app/src/features/register/domain/usecase/resgister_usecase.dart';
import 'package:studio_partner_app/src/features/register/presentation/bloc/register_bloc.dart';
import 'package:studio_partner_app/src/features/settings/provider/theme_provider.dart';
import 'package:studio_partner_app/src/features/stores/data/datasource/remote_data_source.dart';
import 'package:studio_partner_app/src/features/stores/data/repository/add_studio_repository_impl.dart';
import 'package:studio_partner_app/src/features/stores/domain/usecase/get_category_data.dart';
import 'package:studio_partner_app/src/features/stores/domain/usecase/get_studio_details.dart';
import 'package:studio_partner_app/src/features/stores/domain/usecase/get_user_location.dart';
import 'package:studio_partner_app/src/features/stores/domain/usecase/post_studio_request.dart';
import 'package:studio_partner_app/src/features/stores/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:studio_partner_app/src/features/stores/presentation/bloc/location_bloc/location_bloc.dart';
import 'package:studio_partner_app/src/features/stores/presentation/bloc/map_bloc/map_bloc.dart';
import 'package:studio_partner_app/src/features/stores/presentation/bloc/request_bloc/request_bloc.dart';
import 'package:studio_partner_app/src/features/stores/presentation/bloc/studio_bloc/studio_bloc.dart';
import 'package:studio_partner_app/src/utils/router.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeState = ref.watch(themeProvider);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => HelpBloc(
                getHelp: GetHelp(
                    helpRepository: HelpRepositoryImpl(
                        helpDataSource: HelpDataSourceImpl())))),
        BlocProvider(
            create: (context) => IssuesBloc(
                getIssues: GetIssues(
                    helpRepository: HelpRepositoryImpl(
                        helpDataSource: HelpDataSourceImpl())),
                sendIssues: SendIssues(
                    helpRepository: HelpRepositoryImpl(
                        helpDataSource: HelpDataSourceImpl())))),
        BlocProvider(
            create: (context) => HelpBloc(
                getHelp: GetHelp(
                    helpRepository: HelpRepositoryImpl(
                        helpDataSource: HelpDataSourceImpl())))),
        BlocProvider(
            create: (context) => WithdrawBloc(
                paymentUsecase: PaymentUsecase(
                    earningRepository: EarningRepositoryImpl(
                        earningDataSource: EarningDataSourceImpl())))),
        BlocProvider(
            create: (context) => BankDetailsBloc(
                addBank: AddBank(
                    updateRepository: UpdateRepositoryImpl(
                        updateDataSource: UpdateDataSourceImpl())),
                getBankDetails: GetBankDetails(
                    updateRepository: UpdateRepositoryImpl(
                        updateDataSource: UpdateDataSourceImpl())))),
        BlocProvider(
            create: (context) => UpdateBloc(
                updateUsecase: UpdateUsecase(
                    updateRepository: UpdateRepositoryImpl(
                        updateDataSource: UpdateDataSourceImpl())))),
        BlocProvider(
            create: (context) => ReviewBloc(
                reviewUsecase: ReviewUsecase(
                    earningRepository: EarningRepositoryImpl(
                        earningDataSource: EarningDataSourceImpl())))),
        BlocProvider(
            create: (context) => EarningBloc(
                earningsUsecase: EarningsUsecase(
                    earningRepository: EarningRepositoryImpl(
                        earningDataSource: EarningDataSourceImpl())))),
        BlocProvider(
            create: (context) => StoreBloc(
                getStores: GetStores(
                    bookingsRepository: BookingsRepositoryImpl(
                        homeRemoteDataSource: HomeRemoteDataSourceImpl())))),
        BlocProvider(
            create: (context) => ChatBloc(
                getChat: GetChat(
                    bookingsRepository: BookingsRepositoryImpl(
                        homeRemoteDataSource: HomeRemoteDataSourceImpl())))),
        BlocProvider(
            create: (context) => StudioBloc(
                getStudioDetails: GetStudioDetails(
                    addStudioRepository: AddStudioRepositoryImpl(
                        remoteDataSource: StoreRemoteDataSourceImpl())))),
        BlocProvider(
            create: (context) => SchedulesBloc(
                updateSchedule: UpdateSchedule(
                    bookingsRepository: BookingsRepositoryImpl(
                        homeRemoteDataSource: HomeRemoteDataSourceImpl())),
                getSchedules: GetSchedules(
                    bookingsRepository: BookingsRepositoryImpl(
                        homeRemoteDataSource: HomeRemoteDataSourceImpl())))),
        BlocProvider(
            create: (context) => RequestBloc(
                postStudioRequest: PostStudioRequest(
                    addStudioRepository: AddStudioRepositoryImpl(
                        remoteDataSource: StoreRemoteDataSourceImpl())))),
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
