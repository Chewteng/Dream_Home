import 'package:dream_home/exit_confirmation_dialog.dart';
import 'package:flutter/material.dart';

class DialogHelper {

  static exit(context) => showDialog(context: context, builder: (context) => ExitConfirmationDialog());
}