import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gombe_election/providers/authentication_provider.dart';
import 'package:gombe_election/providers/election_provider.dart';
import 'package:gombe_election/resources/navigation_utils.dart';
import 'package:gombe_election/screens/bottom_nav_screens/bottom_nav_screen.dart';
import 'package:gombe_election/screens/voter_module/election_observer_screen.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/credentials.dart';
import '../../../Widgets/components.dart';
import '../../../resources/constants/color_constants.dart';
import '../../../resources/constants/dimension_constants.dart';
import '../../../resources/constants/string_constants.dart';
import '../../../widgets/constant_widgets.dart';
import '../../../widgets/custom_snack_back.dart';
import '../../../widgets/label_widget.dart';
import '../../../widgets/textfields.dart';
import '../../voter_module/voter_home_screen.dart';
import '../widgets/onboarding_header.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final walletAddressController = TextEditingController();

  @override
  void initState() {
    walletAddressController.text =
        kDebugMode ? "0x28ce9243c3c438C48C28a4f9Bc7916F1247e7145" : "";

    // walletAddressController.text =
    // kDebugMode ? "0xf9A9c5802E38c177415d17a68176201bE38B3F1B" : "";
    super.initState();
  }

  // 0x42187668F047c10691A3F76Ca458a8FD8A8823A1
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: SafeArea(
          bottom: false,
          child: Consumer2<AuthenticationProvider, ElectionProvider>(
              builder: (ctx, authProvider, electionProvider, child) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (authProvider.resMessage != '' ||
                  electionProvider.resMessage != "") {
                customSnackBar(context, authProvider.resMessage,
                    isError: authProvider.isError);
                customSnackBar(context, electionProvider.resMessage,
                    isError: electionProvider.isError);

                ///Clear the response message to avoid duplicate
                authProvider.clear();
                electionProvider.clear();
              }
            });
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const TopPadding(),
                SizedBox(
                  height: topPadding.h,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                            child: OnBoardingHeaderText(
                                title: "Login with your \nwallet Address")),
                        SizedBox(
                          height: 50.h,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        const LabelWidget(
                          label: "Wallet Address",
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomField(
                                "Enter your wallet address e.g 0x5CF1ac",
                                walletAddressController,
                                isCapitalizeSentence: false,
                                onChange: (value) {
                                  setState(() {});
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        SizedBox(
                          height: 19.h,
                        ),
                        authProvider.isLoading
                            ? const Center(child: CupertinoActivityIndicator())
                            : MainButton(
                                login,
                                () async {
                                  electionProvider.updateVoter(null);
                                  if (walletAddressController.text.length <
                                      32) {
                                    customSnackBar(
                                      context,
                                      "Please enter a valid address",
                                    );
                                  } else {
                                    try {
                                      final address = await electionProvider
                                          .getElectionAdmin();
                                      if (address ==
                                          EthereumAddress.fromHex(
                                              walletAddressController.text)) {
                                        electionProvider
                                            .updateCurrentUserAddress(address);
                                        navToWithScreenName(
                                            context: context,
                                            screen: const BottomNavScreen());
                                      } else {
                                        final voter =
                                            await electionProvider.voterLogin(
                                                EthereumAddress.fromHex(
                                                    walletAddressController
                                                        .text),
                                                context: context);
                                        if (voter != null) {
                                          electionProvider.updateVoter(voter);
                                          navToWithScreenName(
                                              context: context,
                                              screen: const VoterHomeScreen());
                                        } else {
                                          debugPrint("Invalid voter");
                                        }
                                      }
                                    } catch (e) {
                                      customSnackBar(
                                          context, "Error: ${e.toString()}");
                                    }
                                  }
                                },
                              ),
                        SizedBox(
                          height: 20.h,
                        ),

                        MainButton(
                          "Login As Observer",
                              () async {

                            navToWithScreenName(context: context, screen: const ElectionObserverScreen());
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          })),
    );
  }
}
