import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const Map<String, AuthError> authErrorMapping = {
  'user-not-found': AuthErrorUserNotFound(),
  'weak-password': AuthErrorWeakPassword(),
  'invalid-email': AuthErrorInvalidEmail(),
  'no-current-user': AuthErrorNoCurrentUser(),
  'operation-not-allowed': AuthErrorOperationNotAllowed(),
  'requires-recent-login': AuthErrorRequiresRecentLogin(),
  'email-already-in-use': AuthErrorEmailAlreadyInUse(),
};

@immutable
abstract class AuthError {
  final String dialogTitle;
  final String dialogText;

  const AuthError({required this.dialogTitle, required this.dialogText});

  factory AuthError.from(FirebaseAuthException exception) =>
      authErrorMapping[exception.code.toLowerCase().trim()] ??
      const AuthErrorUnknown();
}

@immutable
class AuthErrorUnknown extends AuthError {
  const AuthErrorUnknown()
      : super(dialogTitle: 'Auth error', dialogText: 'Unknown error');
}

@immutable
class AuthErrorNoCurrentUser extends AuthError {
  const AuthErrorNoCurrentUser()
      : super(
            dialogTitle: 'No current user',
            dialogText: 'No current user with this information found');
}

@immutable
class AuthErrorRequiresRecentLogin extends AuthError {
  const AuthErrorRequiresRecentLogin()
      : super(
            dialogTitle: 'Requires recent login',
            dialogText:
                'You have to log out and log back in to perform this operation');
}

@immutable
class AuthErrorOperationNotAllowed extends AuthError {
  const AuthErrorOperationNotAllowed()
      : super(
            dialogTitle: 'Operation not allowed',
            dialogText: 'You cannot register using this method at this moment');
}

@immutable
class AuthErrorUserNotFound extends AuthError {
  const AuthErrorUserNotFound()
      : super(
            dialogTitle: 'User not found',
            dialogText: 'User not found on the server');
}

@immutable
class AuthErrorWeakPassword extends AuthError {
  const AuthErrorWeakPassword()
      : super(
            dialogTitle: 'Weak password',
            dialogText: 'Use a stronger password containing more characters');
}

@immutable
class AuthErrorInvalidEmail extends AuthError {
  const AuthErrorInvalidEmail()
      : super(
            dialogTitle: 'Invalid Email',
            dialogText: 'Double check email and try again');
}

@immutable
class AuthErrorEmailAlreadyInUse extends AuthError {
  const AuthErrorEmailAlreadyInUse()
      : super(
            dialogTitle: 'Email already in use',
            dialogText: 'Please choose another email to register with');
}
