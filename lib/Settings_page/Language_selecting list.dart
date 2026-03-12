import 'package:flutter/material.dart';

class LanguageSelectionScreen extends StatefulWidget {
  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  final List<String> languages = [
    'Mandarin',
    'Spanish',
    'French',
    'Arabic',
    'Bengali',
    'Russian',
    'Japanese',
    'Korean',
    'Indonesian',
    'Italian',
    'Portuguese',
    'German',
    'Turkish',
    'Vietnamese',
  ];

  final List<String> suggested = [
    'English (US)',
    'English (UK)',
  ];

  String selectedLanguage = 'English (US)'; // Default selected language

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding:  EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.15),
          child: Center(child: Text('Language')),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container( // Wrap the body in a Container to set the background color
        color: Colors.white, // Set the background color to white
        child: SingleChildScrollView( // Ensures the body can scroll if content is too long
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Suggested section
                Text(
                  'Suggested',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                // List of suggested languages
                for (var lang in suggested)
                  ListTile(
                    title: Text(lang),
                    trailing: selectedLanguage == lang
                        ? Icon(Icons.check, color: Colors.blue)
                        : null,
                    onTap: () {
                      setState(() {
                        selectedLanguage = lang;
                      });
                    },
                  ),
                Divider(),
                // Language section
                Text(
                  'Language',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                // List of other languages
                for (var lang in languages)
                  ListTile(
                    title: Text(lang),
                    trailing: selectedLanguage == lang
                        ? Icon(Icons.check, color: Colors.blue)
                        : null,
                    onTap: () {
                      setState(() {
                        selectedLanguage = lang;
                      });
                    },
                  ),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
