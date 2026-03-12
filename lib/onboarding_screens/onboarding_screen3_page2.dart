import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class OnboardingPage2 extends StatelessWidget {
  final ImagePicker _picker = ImagePicker(); // Image picker instance

  // Function to handle the photo selection
  Future<void> _selectPhoto(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          height: 200, // Height for the bottom sheet
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () async {
                  Navigator.pop(context); // Close the bottom sheet
                  await _pickImage(ImageSource.camera); // Open camera
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context); // Close the bottom sheet
                  await _pickImage(ImageSource.gallery); // Open gallery
                },
              ),
              Divider(),
            ],
          ),
        );
      },
    );
  }

  // Function to pick image from either camera or gallery
  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedImage = await _picker.pickImage(source: source);
    if (pickedImage != null) {
      // Handle the picked image (display it, save it, etc.)
      print("Image picked: ${pickedImage.path}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// 🟦 WHAT DID YOU HAVE DIFFICULTIES WITH TODAY (TEXT FIELD)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'What did you have difficulties with today but managed to overcome?',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF6B7A88),
                        ),
                      ),
                    ),
                    Container(
                      width: 48,
                      height: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xff122029),
                      ),
                      child: Image.asset(
                        "assets/images/Arrow Refresh 02.png",
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Type here...',
                    filled: true,
                    fillColor: const Color(0xFFF4F7F8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          /// 🟦 TODAY'S PHOTO (PHOTO UPLOAD)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Today’s photo',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF6B7A88),
                      ),
                    ),
                    Spacer(),
                    Image.asset("assets/images/ic_round-plus.png")
                  ],
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    _selectPhoto(context); // Show bottom sheet for photo options
                  },
                  child: Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE9EEF2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Icon(
                            Icons.add_a_photo,
                            size: 50,
                            color: Color(0xFF6B7A88),
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Select up to 4 photos',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF6B7A88),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
