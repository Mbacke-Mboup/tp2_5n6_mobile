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

  /// `Login`
  String get connexion_title {
    return Intl.message(
      'Login',
      name: 'connexion_title',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get name_label {
    return Intl.message(
      'Username',
      name: 'name_label',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password_label {
    return Intl.message(
      'Password',
      name: 'password_label',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login_button {
    return Intl.message(
      'Login',
      name: 'login_button',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signup_button {
    return Intl.message(
      'Sign Up',
      name: 'signup_button',
      desc: '',
      args: [],
    );
  }

  /// `Invalid username or password.`
  String get invalid_credentials {
    return Intl.message(
      'Invalid username or password.',
      name: 'invalid_credentials',
      desc: '',
      args: [],
    );
  }

  /// `This account does not exist. Please create an account.`
  String get account_not_exist {
    return Intl.message(
      'This account does not exist. Please create an account.',
      name: 'account_not_exist',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signup_title {
    return Intl.message(
      'Sign Up',
      name: 'signup_title',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirm_password_label {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password_label',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match.`
  String get passwords_do_not_match {
    return Intl.message(
      'Passwords do not match.',
      name: 'passwords_do_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Username is too short`
  String get username_too_short {
    return Intl.message(
      'Username is too short',
      name: 'username_too_short',
      desc: '',
      args: [],
    );
  }

  /// `Password is too short`
  String get password_too_short {
    return Intl.message(
      'Password is too short',
      name: 'password_too_short',
      desc: '',
      args: [],
    );
  }

  /// `Username is already taken`
  String get username_already_taken {
    return Intl.message(
      'Username is already taken',
      name: 'username_already_taken',
      desc: '',
      args: [],
    );
  }

  /// `A network error occurred. Please try again later!`
  String get network_error {
    return Intl.message(
      'A network error occurred. Please try again later!',
      name: 'network_error',
      desc: '',
      args: [],
    );
  }

  /// `Create Task`
  String get creation_title {
    return Intl.message(
      'Create Task',
      name: 'creation_title',
      desc: '',
      args: [],
    );
  }

  /// `Task Name`
  String get task_name_label {
    return Intl.message(
      'Task Name',
      name: 'task_name_label',
      desc: '',
      args: [],
    );
  }

  /// `Choose a Date`
  String get select_date_button {
    return Intl.message(
      'Choose a Date',
      name: 'select_date_button',
      desc: '',
      args: [],
    );
  }

  /// `Deadline`
  String get deadline_label {
    return Intl.message(
      'Deadline',
      name: 'deadline_label',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create_task_button {
    return Intl.message(
      'Create',
      name: 'create_task_button',
      desc: '',
      args: [],
    );
  }

  /// `Task Details`
  String get consultation_title {
    return Intl.message(
      'Task Details',
      name: 'consultation_title',
      desc: '',
      args: [],
    );
  }

  /// `Task Name`
  String get task_name {
    return Intl.message(
      'Task Name',
      name: 'task_name',
      desc: '',
      args: [],
    );
  }

  /// `Deadline`
  String get deadline {
    return Intl.message(
      'Deadline',
      name: 'deadline',
      desc: '',
      args: [],
    );
  }

  /// `Time Spent`
  String get time_spent {
    return Intl.message(
      'Time Spent',
      name: 'time_spent',
      desc: '',
      args: [],
    );
  }

  /// `Progress Percentage`
  String get progress_percentage {
    return Intl.message(
      'Progress Percentage',
      name: 'progress_percentage',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save_button {
    return Intl.message(
      'Save',
      name: 'save_button',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete_button {
    return Intl.message(
      'Delete',
      name: 'delete_button',
      desc: '',
      args: [],
    );
  }

  /// `No image`
  String get no_image {
    return Intl.message(
      'No image',
      name: 'no_image',
      desc: '',
      args: [],
    );
  }

  /// `Choose an Image`
  String get choose_image_button {
    return Intl.message(
      'Choose an Image',
      name: 'choose_image_button',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Create Task`
  String get create_task {
    return Intl.message(
      'Create Task',
      name: 'create_task',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Hello`
  String get greeting {
    return Intl.message(
      'Hello',
      name: 'greeting',
      desc: '',
      args: [],
    );
  }

  /// `No tasks available.`
  String get task_list_empty {
    return Intl.message(
      'No tasks available.',
      name: 'task_list_empty',
      desc: '',
      args: [],
    );
  }

  /// `Loading tasks...`
  String get loading_tasks {
    return Intl.message(
      'Loading tasks...',
      name: 'loading_tasks',
      desc: '',
      args: [],
    );
  }

  /// `Task Details`
  String get task_details {
    return Intl.message(
      'Task Details',
      name: 'task_details',
      desc: '',
      args: [],
    );
  }

  /// `Percentage Done: `
  String get task_percentage {
    return Intl.message(
      'Percentage Done: ',
      name: 'task_percentage',
      desc: '',
      args: [],
    );
  }

  /// `Time Spent: `
  String get time_spent_task {
    return Intl.message(
      'Time Spent: ',
      name: 'time_spent_task',
      desc: '',
      args: [],
    );
  }

  /// `Deadline: `
  String get deadline_task {
    return Intl.message(
      'Deadline: ',
      name: 'deadline_task',
      desc: '',
      args: [],
    );
  }

  /// `Create a Task`
  String get floating_action_button_create {
    return Intl.message(
      'Create a Task',
      name: 'floating_action_button_create',
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
      Locale.fromSubtags(languageCode: 'fr'),
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
