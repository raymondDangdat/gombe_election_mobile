import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gombe_election/providers/election_provider.dart';
import 'package:gombe_election/screens/bottom_nav_screens/candidates_screen/candidate_screen.dart';
import 'package:gombe_election/screens/bottom_nav_screens/voters_screen/voters_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/bottom_nav_provider.dart';
import '../../resources/constants/color_constants.dart';
import '../../resources/constants/font_constants.dart';
import '../../resources/styles_manager.dart';
import 'home/home_screen.dart';
import 'lga_screen/lga_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  late BottomNavProvider bottomNavProvider;
  late ElectionProvider electionProvider;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    LGAScreen(),
    VotersScreen(),
    CandidatesScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      electionProvider.resetFilters();
      bottomNavProvider.updateSelectedIndex(index);
      if (index == 2) {
        electionProvider.getAllVoters(context: context);
      } else if (index == 3) {
        electionProvider.getAllCandidates();
      }
    });
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        bottomNavProvider.updateSelectedIndex(0);
      });
    });
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bottomNavProvider = context.watch<BottomNavProvider>();
    electionProvider = context.watch<ElectionProvider>();
    return Scaffold(
      body:
          Consumer<BottomNavProvider>(builder: (ctx, bottomNavProvider, child) {
        return Center(
          child: _widgetOptions[bottomNavProvider.selectedIndex],
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        selectedFontSize: 12,
        enableFeedback: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        unselectedLabelStyle: getCustomTextStyle(
            fontSize: 12,
            textColor: const Color.fromRGBO(0, 6, 16, 0.5),
            fontWeight: regularFont),
        selectedLabelStyle: getCustomTextStyle(
            fontSize: 12,
            textColor: primaryTextColor,
            fontWeight: semiBoldFont),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(""),
            activeIcon: SvgPicture.asset(""),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(""),
            activeIcon: SvgPicture.asset(""),
            label: 'LGA',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(""),
            activeIcon: SvgPicture.asset(""),
            label: 'Voters',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(""),
            activeIcon: SvgPicture.asset(""),
            label: 'Candidates',
          ),
        ],
        currentIndex: bottomNavProvider.selectedIndex,
        selectedItemColor: primaryTextColor,
        unselectedItemColor: const Color.fromRGBO(0, 6, 16, 0.5),
        onTap: _onItemTapped,
      ),
    );
  }
}
