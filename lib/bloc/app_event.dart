import 'package:flutter/material.dart';

@immutable
abstract class AppEvent {
  const AppEvent();
}

@immutable
class AppEventInitialize implements AppEvent {
  const AppEventInitialize();
}

@immutable
class AppEventGoToLogin implements AppEvent {
  const AppEventGoToLogin();
}

@immutable
class AppEventLogIn implements AppEvent {
  final String email;
  final String password;
  const AppEventLogIn({required this.email, required this.password});
}

@immutable
class AppEventGoToRegistration implements AppEvent {
  const AppEventGoToRegistration();
}

@immutable
class AppEventRegister implements AppEvent {
  final String email;
  final String password;
  const AppEventRegister({required this.email, required this.password});
}

@immutable
class AppEventLogOut implements AppEvent {
  const AppEventLogOut();
}

@immutable
class AppEventDeleteAccount implements AppEvent {
  const AppEventDeleteAccount();
}

@immutable
class AppEventUploadImage implements AppEvent {
  final String filePathToUpload;

  const AppEventUploadImage({
    required this.filePathToUpload,
  });
}

@immutable
class AppEventDeleteImage implements AppEvent {
  final String filePathToDelete;

  const AppEventDeleteImage(this.filePathToDelete);
}
