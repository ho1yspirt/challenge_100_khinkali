// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Finik Map`
  String get appName {
    return Intl.message(
      'Finik Map',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get actionLogin {
    return Intl.message(
      'Log in',
      name: 'actionLogin',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get actionSignup {
    return Intl.message(
      'Sign up',
      name: 'actionSignup',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get actionLogout {
    return Intl.message(
      'Log out',
      name: 'actionLogout',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get homeTitle {
    return Intl.message(
      'Home',
      name: 'homeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get actionHome {
    return Intl.message(
      'Home',
      name: 'actionHome',
      desc: '',
      args: [],
    );
  }

  /// `Leaderboard`
  String get leaderboardTitle {
    return Intl.message(
      'Leaderboard',
      name: 'leaderboardTitle',
      desc: '',
      args: [],
    );
  }

  /// `Devices`
  String get devicesTitle {
    return Intl.message(
      'Devices',
      name: 'devicesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Leaderboard`
  String get actionLeaderboard {
    return Intl.message(
      'Leaderboard',
      name: 'actionLeaderboard',
      desc: '',
      args: [],
    );
  }

  /// `Devices`
  String get actionDevices {
    return Intl.message(
      'Devices',
      name: 'actionDevices',
      desc: '',
      args: [],
    );
  }

  /// `Points: {counter}`
  String pointsCounter(Object counter) {
    return Intl.message(
      'Points: $counter',
      name: 'pointsCounter',
      desc: '',
      args: [counter],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ky'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
