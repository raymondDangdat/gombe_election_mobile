import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gombe_election/widgets/textfields.dart';
import '../../../../../Widgets/components.dart';
import 'close_icon_widget.dart';
import 'custom_snack_back.dart';
import 'label_widget.dart';

Future<String> showPrivateKeyDialog(BuildContext importedContext,
    {bool barrierDismissible = false,
      String message = "Loading...",
      bool isCardPayment = true}) async {
  String? privateKey = await showDialog(
      barrierDismissible: barrierDismissible,
      context: importedContext,
      builder: (BuildContext context) => DepositAmountDialog(
        isCardPayment: isCardPayment,
      ));

  return privateKey ?? "";
}

class DepositAmountDialog extends StatefulWidget {
  final bool isCardPayment;
  const DepositAmountDialog({super.key, this.isCardPayment = true});

  @override
  State<DepositAmountDialog> createState() => _DepositAmountDialogState();
}

class _DepositAmountDialogState extends State<DepositAmountDialog> {
  final privateKeyController = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

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
              const CloseIconWidget(),
              SizedBox(
                height: 10.h,
              ),
              const LabelWidget(label: "Private Key"),
              Row(
                children: [
                  Expanded(
                      child: CustomField(
                        "Enter your private key",
                        privateKeyController,
                        onChange: (value) {

                        },
                      ))
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              MainButton("Next", () async {
                if(privateKeyController.text.length < 32){
                  customSnackBar(context, "Enter a valid private key");
                }else{
                  Navigator.pop(context, privateKeyController.text);
                }
              })
            ],
          ),
        ));
  }
}
