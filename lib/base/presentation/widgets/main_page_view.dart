import 'dart:io';
import 'package:borlago/base/di/get_it.dart';
import 'package:borlago/base/presentation/screens/camera_screen.dart';
import 'package:borlago/feature_help/presentation/screens/help_screen.dart';
import 'package:borlago/feature_notifications/presentation/screens/notifications_screen.dart';
import 'package:borlago/feature_user/presentation/screens/settings_screen.dart';
import 'package:borlago/feature_wcr/presentation/screens/wcrs_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPageView extends StatefulWidget {
  const MainPageView({super.key});

  @override
  State<MainPageView> createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  int _currentScreen = 2;
  final PageController _pageController = PageController(initialPage: 2);
  late CameraController _cameraController;
  final CameraDescription _backCamera = getIt.get<CameraDescription>();

  Future<void> initCamera() async {
    _cameraController = CameraController(_backCamera, ResolutionPreset.max);
    _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (int index) {
          setState(() {
            _currentScreen = index;
          });
        },
        children: <Widget> [
          const HelpScreen(),
          const WCRsScreen(),
          CameraScreen(
            controller: _cameraController,
            initCamera: initCamera,
          ),
          const NotificationsScreen(),
          const SettingsScreen()
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: Platform.isIOS ? 90 : 60,
        child: BottomNavigationBar(
          currentIndex: _currentScreen,
          selectedItemColor: theme.colorScheme.primary,
          unselectedItemColor: Colors.white,
          backgroundColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (int index) {
            _pageController.jumpToPage(index);
          },
          items:  const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.question_circle_fill),
                label: 'help'
            ),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.trash_fill),
                label: 'wcrs'
            ),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.camera_fill),
                label: 'main'
            ),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.bell_fill),
                label: 'notifications'
            ),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.gear_solid),
                label: 'settings'
            ),
          ],
        ),
      ),
    );
  }
}