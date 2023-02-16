// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:photobloc/auth/auth_error.dart';

extension GetUser on AppState {
  User? get user {
    final cls = this;
    if (cls is AppStateLoggedIn) {
      return cls.user;
    } else {
      return null;
    }
  }
}

extension GetImages on AppState {
  Iterable<Reference>? get images {
    final cls = this;
    if (cls is AppStateLoggedIn) {
      return cls.images;
    } else {
      return null;
    }
  }
}

@immutable
abstract class AppState {
  final bool isLoading;
  final AuthError? authError;

  const AppState({required this.isLoading, required this.authError});
}

@immutable
class AppStateLoggedIn extends AppState {
  final User user;
  final Iterable<Reference> images;
  const AppStateLoggedIn(
      {required this.user,
      required this.images,
      required super.isLoading,
      super.authError});

  @override
  bool operator ==(covariant other) {
    if (identical(this, other)) return true;

    if (other is AppStateLoggedIn) {
      return isLoading == other.isLoading &&
          user.uid == other.user.uid &&
          images.length == other.images.length;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => user.hashCode ^ images.hashCode;

  @override
  String toString() => 'AppStateLoggedIn(user: $user, images: $images)';
}

@immutable
class AppStateLoggedOut extends AppState {
  const AppStateLoggedOut({required super.isLoading, super.authError});
}

@immutable
class AppStateIsInRegistrationView extends AppState {
  const AppStateIsInRegistrationView(
      {required super.isLoading, super.authError});
}
