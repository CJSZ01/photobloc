import 'package:flutter/cupertino.dart';
import 'package:photobloc/auth/auth_error.dart';
import 'package:photobloc/views/dialogs/generic_dialog.dart';

Future<void> showAuthError(
    {required BuildContext context, required AuthError authError}) {
  return showGenericDialog<void>(
    context: context,
    title: authError.dialogTitle,
    content: authError.dialogText,
    optionsBuilder: () => {
      'Ok': true,
    },
  );
}
