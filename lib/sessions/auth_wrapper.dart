import 'package:flutter/material.dart';
import 'package:arrive_app/sessions/session_manager.dart';
import 'package:arrive_app/view_screens/Bottemnavigation_screen.dart';
import 'package:arrive_app/Authenticator_screens/Loginbottemsheet.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _isLoading = true;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    final bool valid = await SessionManager.isSessionValid();
    setState(() {
      _isLoggedIn = valid;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_isLoggedIn) {
      return const MainBottomNavigation();
    } else {
      // Session expired or not logged in — show login screen
      return Scaffold(
        body: Builder(
          builder: (context) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                isDismissible: false,
                enableDrag: false,
                builder: (_) => const LoginBottomSheet(),
              );
            });
            return const SizedBox.shrink();
          },
        ),
      );
    }
  }
}