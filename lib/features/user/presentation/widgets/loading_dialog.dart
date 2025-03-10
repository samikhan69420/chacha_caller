import 'package:flutter/material.dart' as mat;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withOpacity(.3),
      child: Center(
        child: const AlertDialog(
          leading: Center(
            child: SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(),
            ),
          ),
          title: Text('Loading'),
        ).animate().slideY(begin: 1, curve: mat.Easing.standardDecelerate),
      ),
    );
  }
}
