import 'package:flutter_animate/flutter_animate.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:toastification/toastification.dart';

void showToast(String title) {
  toastification.show(
    backgroundColor: Colors.black,
    borderSide: BorderSide(color: Colors.neutral[900], width: 3),
    icon: const Icon(
      RadixIcons.infoCircled,
      color: Colors.white,
    ),
    alignment: Alignment.bottomCenter,
    type: ToastificationType.info,
    style: ToastificationStyle.flat,
    title: Text(title),
    autoCloseDuration: 5000.ms,
    applyBlurEffect: false,
    showProgressBar: false,
  );
}

void showWarningToast(String title) {
  toastification.show(
    alignment: Alignment.bottomCenter,
    type: ToastificationType.warning,
    style: ToastificationStyle.simple,
    title: Text(title),
    autoCloseDuration: 5000.ms,
    applyBlurEffect: false,
    showProgressBar: true,
  );
}
