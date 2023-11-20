
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_management/screen/tabscreen.dart';
import 'package:task_management/service/app_router.dart';
import 'package:task_management/service/app_theme.dart';

import 'bloc/exportbloc.dart';
import 'model/task.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Get the directory for storing hydrated data
  final appDocumentDir = await getApplicationDocumentsDirectory();

  // Initialize storage for hydrated_bloc
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: appDocumentDir,
  );
  // ignore: deprecated_member_use

  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key, required this.appRouter});
  AppRouter appRouter;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => TaskBloc()
              ..add(AddTaskEvent(task: Task(title: "task1", id: "",description: '',date: '')))),
        BlocProvider(create: (context) => SwitchBloc())
      ],
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: state.switchvalue
                ? AppThemes.appThemeData[AppTheme.darkTheme]
                : AppThemes.appThemeData[AppTheme.lightTheme],
            home: const TabScreen(),
            onGenerateRoute: appRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
