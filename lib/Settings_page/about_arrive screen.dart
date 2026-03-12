import 'package:flutter/material.dart';

class AboutArriveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Align(
          alignment: Alignment.center, // This aligns the title to the center
          child: Padding(
            padding:  EdgeInsets.only(right:MediaQuery.of(context).size.width * 0.15),
            child: Text(
              'About Arrive',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App logo and version
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/aboutArrive.png',
                      width: 130,
                      height: 130,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Arrive v1.1.1',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.black,
              thickness: 1.5,
            ),
            // Menu items
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: Text('Job Vacancy', style: TextStyle(fontSize: 20)),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                    onTap: () {
                      // Navigate to the job vacancy page
                    },
                  ),
                  ListTile(
                    title: Text('Developer', style: TextStyle(fontSize: 20)),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                    onTap: () {
                      // Navigate to the developer page
                    },
                  ),
                  ListTile(
                    title: Text('Partner', style: TextStyle(fontSize: 20)),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                    onTap: () {
                      // Navigate to the partner page
                    },
                  ),
                  ListTile(
                    title: Text('Accessibility', style: TextStyle(fontSize: 20)),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                    onTap: () {
                      // Navigate to the accessibility page
                    },
                  ),
                  ListTile(
                    title: Text('Terms of Use', style: TextStyle(fontSize: 20)),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                    onTap: () {
                      // Navigate to the terms of use page
                    },
                  ),
                  ListTile(
                    title: Text('Feedback', style: TextStyle(fontSize: 20)),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                    onTap: () {
                      // Navigate to the feedback page
                    },
                  ),
                  ListTile(
                    title: Text('Rate us', style: TextStyle(fontSize: 20)),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                    onTap: () {
                      // Navigate to the rate us page
                    },
                  ),
                  ListTile(
                    title: Text('Visit Our Website', style: TextStyle(fontSize: 20)),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                    onTap: () {
                      // Open the website
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
