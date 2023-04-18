import 'package:flutter/material.dart';

import 'app_buttons.dart';

class AppListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final void Function()? onEdit;
  final void Function()? onDelete;

  const AppListTile({
    super.key,
    required this.title,
    this.onEdit,
    this.onDelete,
    this.subtitle = '',
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: subtitle == '' ? Text(subtitle) : null,
      trailing: AppButtons.iconActions(
        context,
        onEdit: onEdit,
        onDelete: onDelete,
      ),
    );
  }
}
