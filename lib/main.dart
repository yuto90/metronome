import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'home/bpm/bpm_model.dart';
import 'home/footer/footer_model.dart';
import 'home/home.dart';
import 'home/home_model.dart';
import 'home/rhythm/rhythm_model.dart';
import 'tap/tap_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  //向き指定
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, //縦固定
  ]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeModel>(
          create: (context) => HomeModel(context),
        ),
        ChangeNotifierProvider<RhythmModel>(
          create: (context) => RhythmModel(context),
        ),
        ChangeNotifierProvider<BpmModel>(
          create: (context) => BpmModel(),
        ),
        ChangeNotifierProvider<TapModel>(
          create: (context) => TapModel(context),
        ),
        ChangeNotifierProvider<FooterModel>(
          create: (context) => FooterModel(),
        ),
      ],
      child: MaterialApp(
        title: 'JustBeat',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // アプリの多言語対応の設定 ---------------------
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('ja', ''), //日本語
          const Locale('en', ''), //英語
        ],
        // -----------------------------------------
        home: Home(),
      ),
    ),
  );
}
