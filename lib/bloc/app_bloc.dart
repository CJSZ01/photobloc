import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photobloc/auth/auth_error.dart';
import 'package:photobloc/bloc/app_event.dart';
import 'package:photobloc/bloc/app_state.dart';
import 'package:photobloc/utils/delete_image.dart';
import 'package:photobloc/utils/upload_image.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  Future<Iterable<Reference>> _getImages(String userId) {
    FirebaseStorage.instance.ref(userId).list();
    return FirebaseStorage.instance
        .ref(userId)
        .list()
        .then((listResult) => listResult.items);
  }

  AppBloc()
      : super(
          const AppStateLoggedOut(
            isLoading: false,
          ),
        ) {
    on<AppEventInitialize>(
      (event, emit) async {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          emit(
            const AppStateLoggedOut(isLoading: false),
          );
        } else {
          final images = await _getImages(user.uid);
          emit(
            AppStateLoggedIn(user: user, images: images, isLoading: false),
          );
        }
      },
    );

    on<AppEventGoToLogin>(
      (event, emit) {
        emit(
          const AppStateLoggedOut(isLoading: false),
        );
      },
    );

    on<AppEventLogIn>(
      (event, emit) async {
        emit(
          const AppStateLoggedOut(isLoading: true),
        );
        try {
          final email = event.email;
          final password = event.password;
          final userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);
          final user = userCredential.user!;
          final images = await _getImages(user.uid);
          emit(AppStateLoggedIn(user: user, images: images, isLoading: false));
        } on FirebaseAuthException catch (e) {
          emit(
            AppStateLoggedOut(
              isLoading: false,
              authError: AuthError.from(e),
            ),
          );
        }
      },
    );

    on<AppEventGoToRegistration>(
      (event, emit) {
        emit(
          const AppStateIsInRegistrationView(
            isLoading: false,
          ),
        );
      },
    );

    on<AppEventRegister>(
      (event, emit) async {
        emit(
          const AppStateIsInRegistrationView(isLoading: true),
        );
        final email = event.email;
        final password = event.password;
        try {
          final credentials = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password);

          emit(
            AppStateLoggedIn(
              user: credentials.user!,
              images: const [],
              isLoading: false,
            ),
          );
        } on FirebaseAuthException catch (e) {
          emit(
            AppStateIsInRegistrationView(
              isLoading: false,
              authError: AuthError.from(e),
            ),
          );
        }
      },
    );

    on<AppEventLogOut>(
      (event, emit) async {
        emit(
          const AppStateLoggedOut(isLoading: true),
        );
        await FirebaseAuth.instance.signOut();
        emit(
          const AppStateLoggedOut(isLoading: false),
        );
      },
    );

    on<AppEventDeleteAccount>(
      (event, emit) async {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          emit(
            const AppStateLoggedOut(isLoading: false),
          );
          return;
        }
        emit(
          AppStateLoggedIn(
            user: user,
            images: state.images ?? [],
            isLoading: true,
          ),
        );
        try {
          final folder = await FirebaseStorage.instance.ref(user.uid).listAll();
          for (final item in folder.items) {
            await item.delete().catchError((_) {});
          }
          await FirebaseStorage.instance
              .ref(user.uid)
              .delete()
              .catchError((_) {});
          await user.delete();
          await FirebaseAuth.instance.signOut();
          emit(
            const AppStateLoggedOut(isLoading: false),
          );
        } on FirebaseAuthException catch (e) {
          emit(
            AppStateLoggedIn(
              user: user,
              images: state.images ?? [],
              isLoading: false,
              authError: AuthError.from(e),
            ),
          );
        } on FirebaseException {
          emit(const AppStateLoggedOut(
            isLoading: false,
          ));
        }
      },
    );

    on<AppEventUploadImage>((event, emit) async {
      final user = state.user;

      if (user == null) {
        emit(
          const AppStateLoggedOut(isLoading: false),
        );
        return;
      }
      emit(AppStateLoggedIn(
        user: user,
        images: state.images ?? [],
        isLoading: true,
      ));
      final file = File(event.filePathToUpload);
      final snackbarMessage = await uploadImage(file: file, userId: user.uid)
          ? 'Image uploaded successfully'
          : 'Failed to upload image';
      final images = await _getImages(user.uid);
      emit(
        AppStateLoggedIn(
            user: user,
            images: images,
            isLoading: false,
            snackbarMessage: snackbarMessage),
      );
    });

    on<AppEventDeleteImage>((event, emit) async {
      final user = state.user;

      if (user == null) {
        emit(
          const AppStateLoggedOut(isLoading: false),
        );
        return;
      }
      log(
        ' Before loading \n${state.images}',
      );
      emit(AppStateLoggedIn(
        user: user,
        images: const [],
        isLoading: true,
      ));
      log(
        ' After loading \n${state.images}',
      );

      final snackbarMessage =
          await deleteImage(image: event.image, userId: user.uid)
              ? 'Image deleted successfully'
              : 'Failed to delete image';
      log(
        ' Image deleted \n${state.images}',
      );
      final images = await _getImages(user.uid);
      log(
        ' Fetched images \n${state.images}',
      );
      emit(
        AppStateLoggedIn(
            user: user,
            images: images,
            isLoading: false,
            snackbarMessage: snackbarMessage),
      );
    });
  }
}
