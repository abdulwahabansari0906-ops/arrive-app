import 'package:arrive_app/therapy%20screens/search_therapy.dart';
import 'package:flutter/material.dart';

import 'doctor_profile_screen.dart';

class TherapyScreen extends StatefulWidget {
  @override
  _TherapyScreenState createState() => _TherapyScreenState();
}

class _TherapyScreenState extends State<TherapyScreen> {
  List<bool> isFavorite = [false, false, false, false]; // For tracking the heart icon state
  bool isSearchActive = false; // To track the search bar visibility
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFF3F6),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(isSearchActive ? 0 : 56), // Hide AppBar when search is active
        child: AppBar(

          backgroundColor: isSearchActive
              ? Colors.white
              // Empty container, no title when search bar is active
              : Color(0xFFEFF3F6),
          title: isSearchActive
              ? Container() // Empty container, no title when search bar is active
              : Center(child: Text('Therapy')),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  isSearchActive = !isSearchActive;
                });
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Main content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Categories',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text(
                      'See all',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
                      color: Colors.blue),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      categoryButton('Anxiety', 'assets/images/anxiety.png'),
                      categoryButton('Trauma', 'assets/images/trauma.png'),
                      categoryButton('Mental', 'assets/images/mental.png'),
                      categoryButton('CBT', 'assets/images/cbt.png'),
                      categoryButton('Phobia', 'assets/images/phobia.png'),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Find therapist',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text(
                      'See all',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      final therapists = [
                        ['Jennifer Miller', 'Therapist | Mercy Hospital', 4.8],
                        ['Robert Johnson', 'Psychologist | ABC hospital', 4.8],
                        ['Laura White', 'Psychologist | Cedar Dental care', 4.8],
                        ['Brian Clark', 'Coach | ABC hospital', 4.8],
                      ];

                      return therapistCard(
                        therapists[index][0] as String,
                        therapists[index][1] as String,
                        therapists[index][2] as double,
                        index,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Dimmed background when search is active
          if (isSearchActive)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isSearchActive = false; // Dismiss search on tapping outside
                  });
                },
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
            ),

          // Search Bar floating on top
          if (isSearchActive)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: searchController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Search for doctors',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                    prefixIcon: GestureDetector(onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchTherapy()),
                      );
    },
                        child: Icon(Icons.search)),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget categoryButton(String label, String imagePath) {
    return Padding(
      padding: EdgeInsets.only(right: 5, left: 5),
      child: Container(
        width: 75,
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            SizedBox(height: 10),
            Image.asset(
              imagePath,
              width: 30,
              height: 30,
            ),
            TextButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              ),
              child: Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Therapist card with clickable heart icon
  Widget therapistCard(String name, String designation, double rating, int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.07),
                child: Container(
                  width: 30, height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFEFF3F6), width: 2),
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        // Heart icon with toggle functionality
                        IconButton(
                          icon: Icon(
                            isFavorite[index] ? Icons.favorite : Icons.favorite_border,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              isFavorite[index] = !isFavorite[index];
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      designation,
                      style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        SizedBox(width: 4),
                        Text(
                          rating.toString(),
                          style: TextStyle(fontSize: 13),
                        ),
                        Icon(Icons.star, color: Colors.amber, size: 18),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.15),
                        Image.asset("assets/images/Time.png", width: 15, height: 15),
                        Text(
                          "10:30am - 5:30pm",
                          style: TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),

                  ],
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorProfileScreen()));
            },
            child: Container(
              height: 42,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  colors: [Color(0xff98FF98), Color(0xff88D8C0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff4A5D6A),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    "Book Appoinment",
                    style: TextStyle(color: Colors.white,fontSize: 15), // Text color
                  ),
                ),
              ),
            ),
          ),
          // SizedBox(
          //   width: MediaQuery.of(context).size.width * 0.9,
          //   height: MediaQuery.of(context).size.height * 0.05,
          //   child:
          //   ElevatedButton(
          //     onPressed: () {Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => DoctorProfileScreen()),
          //     );},
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: Color(0xFF4A5D6A),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          //     ),
          //     child: Text(
          //       "Book Appointment",
          //       style: TextStyle(fontSize: 13, color: Colors.white),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
