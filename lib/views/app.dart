import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photobloc/bloc/app_bloc.dart';
import 'package:photobloc/bloc/app_event.dart';
import 'package:photobloc/bloc/app_state.dart';
import 'package:photobloc/views/dialogs/show_auth_error.dart';
import 'package:photobloc/views/gallery/photo_gallery_view.dart';
import 'package:photobloc/views/loading/loading_screen.dart';
import 'package:photobloc/views/login/login_view.dart';
import 'package:photobloc/views/register/register_view.dart';

class PhotoblocApp extends StatelessWidget {
  const PhotoblocApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      create: (_) => AppBloc()
        ..add(
          const AppEventInitialize(),
        ),
      child: MaterialApp(
        title: 'Photobloc',
        theme:
            ThemeData(primarySwatch: Colors.red, brightness: Brightness.dark),
        home: BlocConsumer<AppBloc, AppState>(
          builder: (context, state) {
            if (state is AppStateLoggedOut) {
              return const LoginView();
            } else if (state is AppStateLoggedIn) {
              return const PhotoGalleryView();
            } else if (state is AppStateIsInRegistrationView) {
              return const RegisterView();
            } else {
              return Container(
                  color: Colors.white, child: const Icon(Icons.question_mark));
            }
          },
          listener: (context, state) {
            if (state.isLoading) {
              LoadingScreen.instance()
                  .show(context: context, text: 'Loading...');
            } else {
              LoadingScreen.instance().hide();
            }
            if (state.snackbarMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 3),
                  content: Text(state.snackbarMessage!),
                ),
              );
            }
            final authError = state.authError;
            if (authError != null) {
              showAuthError(context: context, authError: authError);
            }
          },
        ),
      ),
    );
  }
}
