import 'dart:io';
import 'package:arrive_app/Settings_page/Language_selecting%20list.dart';
import 'package:arrive_app/Settings_page/Personalinfo_screen.dart';
import 'package:arrive_app/Settings_page/Privacypolicy_screen.dart';
import 'package:arrive_app/Settings_page/about_arrive%20screen.dart';
import 'package:arrive_app/Settings_page/help_center%20screen.dart';
import 'package:arrive_app/Authenticator_screens/Loginbottemsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../sessions/session_manager.dart';

class Settings1 extends StatefulWidget {
  @override
  _Settings1State createState() => _Settings1State();
}

class _Settings1State extends State<Settings1> {
  bool    postpartumMode  = true;
  String  userName        = "";
  String  userEmail       = "";
  String? profileImagePath; // cached image path from session

  @override
  void initState() {
    super.initState();
    _loadUserSession();
  }

  // ─── Load session ──────────────────────────────────────────────────────────

  Future<void> _loadUserSession() async {
    final userSession = await SessionManager.loadUserSession();
    if (!mounted) return;
    setState(() {
      final fullName  = userSession['user_name'] ?? "User";
      userName        = fullName.toString().split(' ').first;
      userEmail       = userSession['email'] ?? "";

      final String? imgPath = userSession['profile_image_path'];
      profileImagePath = (imgPath != null &&
          imgPath.isNotEmpty &&
          File(imgPath).existsSync())
          ? imgPath
          : null;
    });
  }

  // ─── Navigate to Personal Info and reload on return ───────────────────────

  Future<void> _goToPersonalInfo() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsPersonalInfo()),
    );
    // When user comes back, reload session so name & photo update immediately
    await _loadUserSession();
  }

  // ─── Logout dialog ────────────────────────────────────────────────────────

  void _showLogoutDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 70, height: 70,
                  decoration: BoxDecoration(
                    color: const Color(0xFF122029).withOpacity(0.08),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.logout_rounded,
                    size: 34,
                    color: Color(0xFF122029),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Logout",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Color(0xFF122029)),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Are you sure you want to\nlogout from your account?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14, color: Colors.black54, height: 1.5),
                ),
                const SizedBox(height: 28),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(ctx),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          side: const BorderSide(
                              color: Color(0xFF2EC598), width: 1.5),
                        ),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                              color: Color(0xFF2EC598),
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(ctx);
                          // Clear full session including profile image path
                          await SessionManager.clearSession();
                          if (!mounted) return;
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PopScope(
                                canPop: false,
                                onPopInvoked: (didPop) {
                                  if (!didPop) SystemNavigator.pop();
                                },
                                child: Scaffold(
                                  backgroundColor: Colors.white,
                                  body: Builder(
                                    builder: (context) {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          isDismissible: false,
                                          enableDrag: false,
                                          builder: (_) => const LoginBottomSheet(
                                              isFromLogout: true),
                                        );
                                      });
                                      return const SizedBox.shrink();
                                    },
                                  ),
                                ),
                              ),
                            ),
                                (Route<dynamic> route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF122029),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Logout",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ─── Avatar widget ────────────────────────────────────────────────────────

  Widget _buildAvatar() {
    if (profileImagePath != null) {
      return CircleAvatar(
        radius: 30,
        backgroundImage: FileImage(File(profileImagePath!)),
      );
    }
    return Container(
      height: 60, width: 60,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/ghi.jpg"),
          fit: BoxFit.cover,
        ),
        shape: BoxShape.circle,
      ),
    );
  }

  // ─── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.015),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.03),
              child: const Center(
                child: Text(
                  "Settings",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),

            // ── User info tile ─────────────────────────────────────────────
            GestureDetector(
              onTap: _goToPersonalInfo,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                title: Text(userName,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(userEmail),
                leading: _buildAvatar(),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.01),

            // ── General section ────────────────────────────────────────────
            Row(children: const [
              Text("General", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(width: 8),
              Expanded(child: Divider()),
            ]),

            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              leading: Image.asset("assets/images/privacy settings.png",
                  width: 24, height: 24),
              title: const Text("Privacy Settings"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              leading: Image.asset("assets/images/shareing.png",
                  width: 24, height: 24),
              title: const Text("Inspirational Sharing"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              leading: Image.asset("assets/images/postpartum.png",
                  width: 24, height: 24),
              title: const Text("Postpartum Mode"),
              trailing: Switch(
                value: postpartumMode,
                onChanged: (v) => setState(() => postpartumMode = v),
                activeTrackColor: const Color(0xFF23C55E),
                activeThumbColor: Colors.white,
                inactiveThumbColor: Colors.grey,
                inactiveTrackColor: Colors.grey[300],
              ),
              onTap: () {},
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              leading: Image.asset("assets/images/language.png",
                  width: 24, height: 24),
              title: const Text("Language"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text("English (US)"),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => LanguageSelectionScreen()));
              },
            ),

            // ── About section ──────────────────────────────────────────────
            Row(children: const [
              Text("About", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(width: 8),
              Expanded(child: Divider()),
            ]),

            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              leading: Image.asset("assets/images/HelpCenter.png",
                  width: 24, height: 24),
              title: const Text("Help Center"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => HelpCenterScreen()));
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              leading: Image.asset("assets/images/privacyPolicyIcon.png",
                  width: 24, height: 24),
              title: const Text("Privacy Policy"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => PrivacyPolicy()));
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              leading: Image.asset("assets/images/About Praiz.png",
                  width: 24, height: 24),
              title: const Text("About Arrive"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => AboutArriveScreen()));
              },
            ),

            const SizedBox(height: 20),

            // ── Logout button ──────────────────────────────────────────────
            Center(
              child: ElevatedButton(
                onPressed: _showLogoutDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF36454F),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minimumSize:
                  Size(MediaQuery.of(context).size.width * 0.9, 50),
                ),
                child: const Text(
                  "Logout",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}