import 'dart:io';
import 'package:borlago/base/di/get_it.dart';
import 'package:borlago/base/presentation/screens/camera_screen.dart';
import 'package:borlago/base/utils/toast.dart';
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
            toast(message: "Camera access denied");
            break;
          default:
            toast(message: "Something went wrong");
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
          items:  <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(_currentScreen == 0 ?
                  CupertinoIcons.question_circle_fill :
                  CupertinoIcons.question_circle
                ),
                label: 'help'
            ),
            BottomNavigationBarItem(
                icon: Icon(_currentScreen == 1 ?
                  CupertinoIcons.trash_fill :
                  CupertinoIcons.trash
                ),
                label: 'wcrs'
            ),
            BottomNavigationBarItem(
                icon: Icon(_currentScreen == 2 ?
                  CupertinoIcons.camera_fill :
                  CupertinoIcons.camera
                ),
                label: 'main'
            ),
            BottomNavigationBarItem(
                icon: Icon(_currentScreen == 3 ?
                  CupertinoIcons.bell_fill :
                  CupertinoIcons.bell
                ),
                label: 'notifications'
            ),
            BottomNavigationBarItem(
                icon: Icon(_currentScreen == 4 ?
                  CupertinoIcons.gear_solid :
                  CupertinoIcons.gear
                ),
                label: 'settings'
            ),
          ],
        ),
      ),
    );
  }
}