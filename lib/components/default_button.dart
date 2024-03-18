import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../theme.dart';
import 'our_colors.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final String? subtext;
  final VoidCallback? onPress;
  final Color? primaryColor;
  final Color textColor;
  final bool enabled;

  const DefaultButton(
      {Key? key,
        required this.text,
        this.subtext,
        this.onPress,
        this.textColor = Colors.black,
        this.primaryColor = OurColors.focusColor,
        this.enabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
//    debugPrint("DefaultButton");
//   String? _subtext = (subtext == null)? null : '\n$subtext';
    return Container(
      decoration: BoxDecoration(
          color:
          (!enabled || onPress == null) ? OurColors.focusColor : primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(20.dp))),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? onPress : null,
          child: SizedBox(
            height: 6.5.h,
            width: double.infinity,
            child: Center(
              child: enabled
                  ? RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: TextStyle(
                        color: textColor,
                      ),
                      children: [
                        TextSpan(
                            text: text,
                            style: theme()
                                .textTheme.bodySmall!
                                .copyWith(color: textColor)),
                        TextSpan(
                            text: (subtext == null) ? null : '\n$subtext',
                            style: theme()
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: textColor)),
                      ]))
                  : const CircularProgressIndicator(
                color: Colors.white60,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
