import 'package:flutter/material.dart';

/// A scope widget that intercepts the system back button/gesture.
///
/// When [onWillPop] returns `false`, the pop is prevented.
/// Uses [PopScope] internally as a replacement for the deprecated
/// [WillPopScope]-based implementation.
class MiniplayerWillPopScope extends StatelessWidget {
  const MiniplayerWillPopScope({
    super.key,
    required this.child,
    required this.onWillPop,
  });

  final Widget child;
  final Future<bool> Function() onWillPop;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) return;
        final bool shouldPop = await onWillPop();
        if (shouldPop && context.mounted) {
          Navigator.of(context).pop(result);
        }
      },
      child: child,
    );
  }
}
