import 'package:flutter/cupertino.dart';
import 'package:photobloc/dialogs/generic_dialog.dart';

Future<bool> showDeleteAccountDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Delete account',
    content: 'Are you sure you want to delete your account?',
    optionsBuilder: () => {'Cancel': false, 'Delete account': true},
  ).then((value) => value ?? false);
}
