import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import '../../../../../../Widgets/components.dart';

Future<void> showFilterByDateRangeDialog(BuildContext context,
    {bool barrierDismissible = false}) async {
  showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (BuildContext context) => const FilterByDateRangeDialog());
}

class FilterByDateRangeDialog extends StatefulWidget {
  const FilterByDateRangeDialog({
    super.key,
  });

  @override
  State<FilterByDateRangeDialog> createState() =>
      _FilterByDateRangeDialogState();
}

class _FilterByDateRangeDialogState extends State<FilterByDateRangeDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        backgroundColor: Colors.transparent,
        child: CustomContainerButton(
          onTap: () {},
          title: "",
          borderRadius: 12,
          height: 500,
          verticalPadding: 0,
          horizontalPadding: 20,
          useHeight: true,
          widget: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
