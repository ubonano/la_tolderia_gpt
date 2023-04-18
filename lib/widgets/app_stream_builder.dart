import 'package:flutter/material.dart';

import 'app_state_connection.dart';

class AppStreamBuilder<T> extends StatelessWidget {
  final Stream<T> stream;
  final Widget Function(T data) onData;
  final Widget? onError;
  final Widget? onLoading;

  const AppStreamBuilder({
    super.key,
    required this.stream,
    required this.onData,
    this.onError,
    this.onLoading,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasData) {
          return onData(snapshot.data!);
        } else if (snapshot.hasError) {
          return onError ??
              AppStateConnection.error(error: snapshot.error.toString());
        } else {
          return onLoading ?? AppStateConnection.loading();
        }
      },
    );
  }
}
