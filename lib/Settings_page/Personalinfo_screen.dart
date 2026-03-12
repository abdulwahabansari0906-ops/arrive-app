import 'dart:io';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:image_picker/image_picker.dart';
import '../services/profile_service.dart';
import '../sessions/session_manager.dart';

class SettingsPersonalInfo extends StatefulWidget {
  @override
  _SettingsPersonalInfoState createState() => _SettingsPersonalInfoState();
}

class _SettingsPersonalInfoState extends State<SettingsPersonalInfo> {
  String _countryCode = '+1';
  bool   _isEditing   = false;
  bool   _isLoading   = true;
  bool   _isUpdating  = false;
  File?  _pickedImage;
  String? _savedImagePath; // session se loaded path

  int _userId = 0;

  final ImagePicker _picker = ImagePicker();

  final TextEditingController _nameController  = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController(text: '+1 111 467 378 399');
  final TextEditingController _ageController   = TextEditingController(text: '27');

  // ─── Init ─────────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _loadSession();
  }

  Future<void> _loadSession() async {
    final Map<String, dynamic> session = await SessionManager.loadUserSession();

    if (session.isNotEmpty) {
      _userId               = session['user_id']    ?? 0;
      _nameController.text  = session['user_name']  ?? '';
      _emailController.text = session['email']      ?? '';

      // Load saved image path
      final String? imgPath = session['profile_image_path'];
      if (imgPath != null && imgPath.isNotEmpty && File(imgPath).existsSync()) {
        _savedImagePath = imgPath;
        _pickedImage    = File(imgPath);
      }
    }

    if (mounted) setState(() => _isLoading = false);
  }

  // ─── Dispose ──────────────────────────────────────────────────────────────

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  // ─── Toggle edit ──────────────────────────────────────────────────────────

  void _toggleEdit() => setState(() => _isEditing = !_isEditing);

  // ─── Update (API call) ────────────────────────────────────────────────────

  Future<void> _onUpdate() async {
    if (_nameController.text.trim().isEmpty) {
      _showSnack('Name cannot be empty.', isError: true);
      return;
    }

    final int? parsedAge = int.tryParse(_ageController.text.trim());
    if (parsedAge == null) {
      _showSnack('Please enter a valid age.', isError: true);
      return;
    }

    setState(() => _isUpdating = true);

    final UpdateProfileResponse result = await ProfileService.updateProfile(
      UpdateProfileRequest(
        userId: _userId,
        name:   _nameController.text.trim(),
        phone:  '$_countryCode ${_phoneController.text.trim()}',
        age:    parsedAge,
      ),
    );

    if (!mounted) return;

    if (result.isSuccess) {
      final session = await SessionManager.loadUserSession();

      // Save name, email AND profile image path together
      await SessionManager.saveUserSession({
        'user_id':            _userId,
        'user_name':          _nameController.text.trim(),
        'email':              session['email'] ?? _emailController.text.trim(),
        'profile_image_path': _pickedImage?.path ?? _savedImagePath ?? '',
      });

      setState(() {
        _isUpdating     = false;
        _isEditing      = false;
        _savedImagePath = _pickedImage?.path ?? _savedImagePath;
      });

      _showSnack(result.message.isNotEmpty
          ? result.message
          : 'Profile updated successfully!');
    } else {
      setState(() => _isUpdating = false);
      _showSnack(result.message.isNotEmpty
          ? result.message
          : 'Update failed. Please try again.', isError: true);
    }
  }

  // ─── Snack helper ─────────────────────────────────────────────────────────

  void _showSnack(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor:
        isError ? Colors.redAccent : const Color(0xff122029),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ─── Image picker ─────────────────────────────────────────────────────────

  void _showImagePickerSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40, height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Text(
                "Choose Photo",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff122029)),
              ),
              const SizedBox(height: 20),
              _PickerOption(
                icon: Icons.camera_alt_outlined,
                label: "Take a Photo",
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              const SizedBox(height: 12),
              _PickerOption(
                icon: Icons.photo_library_outlined,
                label: "Choose from Gallery",
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              const SizedBox(height: 12),
              if (_pickedImage != null)
                _PickerOption(
                  icon: Icons.delete_outline,
                  label: "Remove Photo",
                  iconColor: Colors.red,
                  labelColor: Colors.red,
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _pickedImage    = null;
                      _savedImagePath = null;
                    });
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? picked = await _picker.pickImage(
          source: source, imageQuality: 85, maxWidth: 600);
      if (picked != null) setState(() => _pickedImage = File(picked.path));
    } catch (e) {
      if (mounted) _showSnack('Could not pick image: $e', isError: true);
    }
  }

  // ─── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final size   = MediaQuery.of(context).size;
    final wScale = size.width  / 375;
    final hScale = size.height / 812;

    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: CircularProgressIndicator(color: Color(0xff122029))),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Personal Info",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: size.width * 0.03),
            child: IconButton(
              icon: Icon(
                _isEditing ? Icons.close : Icons.edit_outlined,
                color: Colors.black, size: 22,
              ),
              onPressed: _isUpdating ? null : _toggleEdit,
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: 20 * wScale, vertical: 10 * hScale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── Avatar ──────────────────────────────────────────────────────
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 100, height: 100,
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xff98FF98), Color(0xff88D8C0)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      padding: const EdgeInsets.all(2),
                      child: ClipOval(
                        child: _pickedImage != null
                            ? Image.file(_pickedImage!,
                            width: 90, height: 90, fit: BoxFit.cover)
                            : Image.asset(
                          'assets/images/ghi.png',
                          width: 90, height: 90, fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: const Color(0xffEEEEEE),
                            child: const Icon(Icons.person,
                                size: 44, color: Color(0xff122029)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (_isEditing)
                    Positioned(
                      bottom: 0, right: 0,
                      child: GestureDetector(
                        onTap: _showImagePickerSheet,
                        child: Container(
                          width: 30, height: 30,
                          decoration: BoxDecoration(
                            color: const Color(0xff122029),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(Icons.camera_alt,
                              color: Colors.white, size: 15),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            SizedBox(height: 28 * hScale),

            _InfoField(
              label: "Full Name",
              controller: _nameController,
              enabled: _isEditing && !_isUpdating,
              icon: Icons.person_outline,
              keyboardType: TextInputType.name,
            ),

            SizedBox(height: 20 * hScale),

            _InfoField(
              label: "Email",
              controller: _emailController,
              enabled: false,
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),

            SizedBox(height: 20 * hScale),

            _buildPhoneField(wScale, hScale),

            SizedBox(height: 20 * hScale),

            _InfoField(
              label: "Age",
              controller: _ageController,
              enabled: _isEditing && !_isUpdating,
              icon: Icons.cake_outlined,
              keyboardType: TextInputType.number,
            ),

            SizedBox(height: 36 * hScale),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _isEditing
                  ? _isUpdating
                  ? const Center(
                  child: CircularProgressIndicator(
                      color: Color(0xff122029)))
                  : _UpdateButton(onTap: _onUpdate)
                  : const SizedBox.shrink(),
            ),

            SizedBox(height: 20 * hScale),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneField(double wScale, double hScale) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Phone Number",
          style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xff888888),
              letterSpacing: 0.4),
        ),
        SizedBox(height: 8 * hScale),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xffF7F7F7),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isEditing ? const Color(0xff122029) : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              CountryCodePicker(
                onChanged: (c) => setState(() => _countryCode = c.dialCode!),
                initialSelection: 'US',
                favorite: const ['+1', 'US'],
                showFlag: true,
                enabled: _isEditing && !_isUpdating,
                padding: const EdgeInsets.symmetric(horizontal: 8),
              ),
              Container(width: 1, height: 24, color: Colors.grey.shade300),
              Expanded(
                child: TextField(
                  controller: _phoneController,
                  enabled: _isEditing && !_isUpdating,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff122029)),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    hintText: "Phone number",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Icon(Icons.phone_outlined,
                    size: 20, color: Colors.grey.shade400),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Picker Option ────────────────────────────────────────────────────────────

class _PickerOption extends StatelessWidget {
  final IconData icon;
  final String   label;
  final VoidCallback onTap;
  final Color iconColor;
  final Color labelColor;

  const _PickerOption({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor  = const Color(0xff122029),
    this.labelColor = const Color(0xff122029),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xffF7F7F7),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(width: 14),
            Text(label,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: labelColor)),
          ],
        ),
      ),
    );
  }
}

// ─── Info Field ───────────────────────────────────────────────────────────────

class _InfoField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool enabled;
  final IconData icon;
  final TextInputType keyboardType;

  const _InfoField({
    required this.label,
    required this.controller,
    required this.enabled,
    required this.icon,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xff888888),
                letterSpacing: 0.4)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xffF7F7F7),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: enabled ? const Color(0xff122029) : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: TextField(
            controller: controller,
            enabled: enabled,
            keyboardType: keyboardType,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xff122029)),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              suffixIcon: Icon(icon, size: 20, color: Colors.grey.shade400),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Update Button ────────────────────────────────────────────────────────────

class _UpdateButton extends StatelessWidget {
  final VoidCallback onTap;
  const _UpdateButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        padding: const EdgeInsets.all(1.5),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff98FF98), Color(0xff88D8C0)],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xff122029),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: Text(
              "Update Profile",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.5),
            ),
          ),
        ),
      ),
    );
  }
}