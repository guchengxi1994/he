import 'package:flutter/material.dart';

extension AsyncSnapshotExtension<T> on AsyncSnapshot<T> {
  Widget when({
    required Widget Function(T value) data,
    required Widget Function(Object error, StackTrace stackTrace) error,
    required Widget Function() loading,
  }) {
    if (connectionState == ConnectionState.waiting ||
        connectionState == ConnectionState.active && !hasData) {
      return loading();
    } else if (hasError) {
      return error(
        this.error ?? 'Unknown error',
        stackTrace ?? StackTrace.current,
      );
    } else if (hasData) {
      return data(this.data as T); // 用 as 明确类型
    } else {
      return loading(); // fallback
    }
  }
}
