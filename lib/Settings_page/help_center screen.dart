import 'package:flutter/material.dart';

class HelpCenterScreen extends StatefulWidget {
  @override
  _HelpCenterScreenState createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  int _selectedIndex = 0; // For top-level tabs (FAQ, Contact us)
  int _subSelectedIndex = 0; // For sub-tabs (General, Service, Betting)
  final TextEditingController _searchController = TextEditingController();

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
      _subSelectedIndex = 0; // Reset sub-tab when top-level tab is changed
    });
  }

  void _onSubTabSelected(int index) {
    setState(() {
      _subSelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.17),
          child: Text('Help Center'),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black), // Back arrow
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: Container(
        color: Colors.white, // Full screen white background
        child: Column(
          children: [
            // Top-level Tab Bar for FAQ and Contact us
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // Centered tabs
                children: [
                  _buildTopTabButton('FAQ', 0),
                  _buildTopTabButton('Contact us', 1),
                ],
              ),
            ),

            // Divider line to separate top tabs from the content

            // Show the sub-tabs (General, Service, Betting) if FAQ is selected
            if (_selectedIndex == 0)
              Padding(
                padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.15),
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Centered sub-tabs
                    children: [
                      _buildSubTabButton('General', 0),
                      _buildSubTabButton('Service', 1),
                      _buildSubTabButton('Betting', 2),
                    ],
                  ),
                ),
              ),
            // Divider line to separate sub-tabs

            // Show the search bar only for FAQ
            if (_selectedIndex == 0)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFeff3f6), // Background color
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none, // Remove the border
                      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    ),
                  ),
                ),
              ),

            // FAQ content section with containers matching image style
            Expanded(
              child: _selectedIndex == 0 ? _buildFAQContent() : _buildContactUsContent(),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build each top-level tab button (FAQ, Contact us)
  Widget _buildTopTabButton(String title, int index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5, // 50% width of the screen
      alignment: Alignment.center, // Center text within the container
      child: Column(
        children: [
          TextButton(
            onPressed: () => _onTabSelected(index),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                color: _selectedIndex == index ? Colors.black : Colors.grey, // Selected is black, unselected is grey
              ),
            ),
          ),
          // Underline for the selected tab
          if (_selectedIndex == index)
            Container(
              margin: EdgeInsets.only(top: 4),
              height: 2,
              width: 200, // Fixed width for the underline
              color: Colors.black,
            ),
        ],
      ),
    );
  }

  // Function to build each sub-tab button (General, Service, Betting)
  Widget _buildSubTabButton(String title, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:4),
      child: GestureDetector(
        onTap: () => _onSubTabSelected(index),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15), // Reduced padding
          decoration: BoxDecoration(
            color: _subSelectedIndex == index ? Colors.black : Colors.transparent,
            borderRadius: BorderRadius.circular(20), // Rounded corners
            border: Border.all(
              color: _subSelectedIndex == index ? Colors.black : Colors.black, // Border color for selected and unselected
              width: 1, // Reduced border width
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14, // Smaller font size
              fontWeight: FontWeight.bold,
              color: _subSelectedIndex == index ? Colors.white : Colors.black, // White text for selected
            ),
          ),
        ),
      ),
    );
  }

  // Function to build FAQ content with expandable FAQ items
  Widget _buildFAQContent() {
    return ListView(
      children: [
        buildFAQItem('What is Arrive?', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
        buildFAQItem('Is the Arrive App free?', 'Yes, the Arrive app is free to download and use, with optional in-app purchases for advanced features.'),
        buildFAQItem('How can I use Arrive?', 'You can use Arrive by downloading it from the App Store or Google Play Store and creating an account to start tracking your deliveries.'),
      ],
    );
  }

  // Function to build Contact Us content (with random image paths)
  Widget _buildContactUsContent() {
    return ListView(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
        _buildContactUsItem('Contact us', 'assets/images/contactUs.png'),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
        _buildContactUsItem('Instagram', 'assets/images/insta.png'),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
        _buildContactUsItem('Facebook', 'assets/images/facebook.png'),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
        _buildContactUsItem('Twitter', 'assets/images/twitter.png'),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
        _buildContactUsItem('Website', 'assets/images/website.png'),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
      ],
    );
  }

  // Function to build each contact item with an image and text
  Widget _buildContactUsItem(String title, String imagePath) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: BoxDecoration(
        color: Color(0xFFeff3f6), // Background color similar to the search bar
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      child: Center(
        child: ListTile(
          leading: Image.asset(imagePath, width: 30, height: 30), // Random image paths
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  // Function to build each FAQ item with expandable content
  Widget buildFAQItem(String title, String content) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: BoxDecoration(
        color: Color(0xFFeff3f6), // Background color similar to the search bar
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      child: ExpansionTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        trailing: Icon(Icons.arrow_drop_down,
          color: Colors.black,
          size: 30,
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide.none, // Remove top and bottom borders
        ),
        collapsedShape: RoundedRectangleBorder(
          side: BorderSide.none, // Remove top and bottom borders when collapsed
        ),
        children: [
          Divider(
            color: Colors.black,
            thickness: 1.5, // Divider color
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(content),
          ),
        ],
      ),
    );
  }
}
