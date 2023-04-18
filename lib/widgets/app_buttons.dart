import 'package:flutter/material.dart';

import '../utils/app_navigate.dart';
import 'app_confirmation_dialog.dart';

class AppButtons {
  static Widget registerButton({required VoidCallback onPressed}) {
    return elevatedButton(onPressed: onPressed, title: 'Registrarse');
  }

  static Widget saveButton({required VoidCallback onPressed}) {
    return elevatedButton(onPressed: onPressed, title: 'Guardar');
  }

  static ElevatedButton elevatedButton({
    required VoidCallback onPressed,
    required String title,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(title),
    );
  }

  static Widget addFloatAction(VoidCallback onPressed) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: const Icon(Icons.add),
    );
  }

  static Widget iconActions(
    BuildContext context, {
    VoidCallback? onEdit,
    VoidCallback? onDelete,
    String titleDeleteButton = 'Eliminar',
    String contentDeleteButton = '¿Está seguro de que desea eliminar?',
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        onEdit != null ? iconEdit(onEdit) : Container(),
        onDelete != null
            ? iconDelete(
                context,
                onConfirm: onDelete,
                title: titleDeleteButton,
                content: contentDeleteButton,
              )
            : Container()
      ],
    );
  }

  static IconButton iconEdit(VoidCallback onPressed) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: onPressed,
    );
  }

  static IconButton iconDelete(
    BuildContext context, {
    required VoidCallback onConfirm,
    String title = 'Eliminar',
    String content = '¿Está seguro de que desea eliminar?',
  }) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (context) {
            return AppConfirmationDialog(
              title: title,
              content: content,
              onConfirm: () {
                AppNavigate.back(context);
                onConfirm();
              },
              onCancel: () => AppNavigate.back(context),
            );
          },
        );
      },
    );
  }
}
