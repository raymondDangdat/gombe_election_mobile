import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../Widgets/components.dart';
import '../../../../../resources/constants/string_constants.dart';

Future<void> showViewCodeDialog(
  BuildContext context, {
  bool barrierDismissible = false,
}) async {
  showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (BuildContext context) => const ViewDialog());
}

class ViewDialog extends StatefulWidget {
  const ViewDialog({
    super.key,
  });

  @override
  State<ViewDialog> createState() => _ViewDialogState();
}

class _ViewDialogState extends State<ViewDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        backgroundColor: Colors.transparent,
        child: CustomContainerButton(
          onTap: () {},
          title: "",
          borderRadius: 12,
          height: 270,
          verticalPadding: 20,
          horizontalPadding: 20,
          useHeight: true,
          widget: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30.h,
              ),
              SizedBox(
                height: 20.h,
              ),
              OutlineBtn(close, () {
                Navigator.pop(context);
              }),
            ],
          ),
        ));
  }
}
