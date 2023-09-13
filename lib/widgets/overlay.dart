import 'package:flutter/material.dart';
import 'package:zoficash/styles/styles.dart';

class LoadingOverlay extends StatelessWidget {
  LoadingOverlay({Key? key, required this.child})
      : isLoadingNotifier = ValueNotifier(false),
        super(key: key);

  final ValueNotifier<bool> isLoadingNotifier;
  final Widget child;

  static LoadingOverlay of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<LoadingOverlay>()!;
  }

  void show() {
    isLoadingNotifier.value = true;
  }

  void hide() {
    isLoadingNotifier.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isLoadingNotifier,
      child: child,
      builder: (context, isLoading, child) {
        return Stack(
          children: [
            child!,
            if (isLoading)
              const Opacity(
                opacity: 0.8,
                child: ModalBarrier(
                  color: Colors.black,
                  dismissible: false,
                ),
              ),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(
                  color: AppColors.blue,
                  strokeWidth: 2,
                ),
              ),
          ],
        );
      },
    );
  }
}
