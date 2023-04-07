import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_dev_app_broseph/screen/manager_screen.dart';
import 'package:test_dev_app_broseph/services/article_repository.dart';

import 'bloc/article_bloc.dart';
import 'config/Utils/utils.dart';
import 'models/article_model.dart';

Future<void> main() async {
  CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.light,
  ));

  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(ArticleAdapter());
  await Hive.openBox('articleData');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Theme.of(context).colorScheme.secondary,
      theme: ThemeData(
          scaffoldBackgroundColor: black_86,
          appBarTheme: AppBarTheme(color: black_86)),
      home: BlocProvider<ArticleBloc>(
        create: (context) => ArticleBloc(
          articleRepository: ArticleRepository(),
        ),
        child: const Scaffold(
          body: ManagerScreen(),
        ),
      ),
    );
  }
}
