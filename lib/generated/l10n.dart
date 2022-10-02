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

  static Future<S> sload(Locale locale) {
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

  /// `ToDo App`
  String get todoApp {
    return Intl.message(
      'ToDo App',
      name: 'todoApp',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `العربيه`
  String get arabic {
    return Intl.message(
      'العربيه',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Add New Task`
  String get addTask {
    return Intl.message(
      'Add New Task',
      name: 'addTask',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Select Date`
  String get date {
    return Intl.message(
      'Select Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get load {
    return Intl.message(
      'Loading...',
      name: 'load',
      desc: '',
      args: [],
    );
  }

  /// `Task Added Successfully`
  String get successAdd {
    return Intl.message(
      'Task Added Successfully',
      name: 'successAdd',
      desc: '',
      args: [],
    );
  }

  /// `YES`
  String get yes {
    return Intl.message(
      'YES',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `SomeThing went wrong, try again late`
  String get errorAdd {
    return Intl.message(
      'SomeThing went wrong, try again late',
      name: 'errorAdd',
      desc: '',
      args: [],
    );
  }

  /// `Task Added Locally`
  String get timeOut {
    return Intl.message(
      'Task Added Locally',
      name: 'timeOut',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Description`
  String get validateDesc {
    return Intl.message(
      'Please Enter Description',
      name: 'validateDesc',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Title`
  String get validateTitle {
    return Intl.message(
      'Please Enter Title',
      name: 'validateTitle',
      desc: '',
      args: [],
    );
  }

  /// `'Error Loading Data, Please try again later'`
  String get errorLoad {
    return Intl.message(
      '\'Error Loading Data, Please try again later\'',
      name: 'errorLoad',
      desc: '',
      args: [],
    );
  }

  /// `Task Deleted Successfully`
  String get successDelete {
    return Intl.message(
      'Task Deleted Successfully',
      name: 'successDelete',
      desc: '',
      args: [],
    );
  }

  /// `Task Deleted Locally`
  String get deleteLocally {
    return Intl.message(
      'Task Deleted Locally',
      name: 'deleteLocally',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Edit Task`
  String get editTask {
    return Intl.message(
      'Edit Task',
      name: 'editTask',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes !`
  String get saveChanges {
    return Intl.message(
      'Save Changes !',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `To Do Lst`
  String get todolist {
    return Intl.message(
      'To Do Lst',
      name: 'todolist',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);

  @override
  Future<S> load(Locale locale) => S.sload(locale);

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
