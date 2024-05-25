import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future<T?> showBarModalBottomSheet1<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Color backgroundColor = Colors.transparent,
  double? elevation,
  ShapeBorder shape = const RoundedRectangleBorder(
      side: BorderSide(color: Colors.white38),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      )),
  double? closeProgressThreshold,
  Clip? clipBehavior,
  Color barrierColor = Colors.black54,
  bool bounce = true,
  bool isScrollControlled=true,
  bool expand = false,
  AnimationController? secondAnimation,
  Curve animationCurve = Curves.easeIn,
  bool useRootNavigator = true,
  bool isDismissible = true,
  bool enableDrag = true,
  Widget? topControl,
  Duration? duration,
}) async {
  assert(debugCheckHasMediaQuery(context));
  assert(debugCheckHasMaterialLocalizations(context));
  final result = await Navigator.of(context, rootNavigator: useRootNavigator)
      .push(ModalBottomSheetRoute<T>(
    builder: builder,
    bounce: bounce,
    closeProgressThreshold: closeProgressThreshold,
    containerBuilder: (_, __, child) => BarBottomSheet(
      child: child,
      control: topControl ??
          Container(
            height: 4,
            width: 56,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(2)),
          ),
      clipBehavior: clipBehavior,
      shape: shape,
      elevation: elevation,
    ),
    secondAnimationController: secondAnimation,
    expanded: expand,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    isDismissible: isDismissible,
    modalBarrierColor: barrierColor,
    enableDrag: enableDrag,
    animationCurve: animationCurve,
    duration: duration,
  ));
  return result;
}
