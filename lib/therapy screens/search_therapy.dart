import 'package:flutter/material.dart';

import 'doctor_profile_screen.dart';

class SearchTherapy extends StatefulWidget {
  const SearchTherapy({super.key});

  @override
  State<SearchTherapy> createState() => _SearchTherapyState();
}

class _SearchTherapyState extends State<SearchTherapy> {
  List<bool> isFavorite = [false, false, false, false]; // For tracking the heart icon state
  bool isSearchActive = false; // To track the search bar visibility
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0, // Removes the shadow from the AppBar
        backgroundColor: Colors.white.withOpacity(0.8), // Adds slight opacity for a "dull" effect
        leading: IconButton(
          icon: Icon(Icons.search, color: Colors.black),
          onPressed: () {
            setState(() {
              isSearchActive = true;
            });
          },
        ),
        title: isSearchActive
            ? TextField(
          controller: searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search for doctors',
            hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 14),
          ),
        )
            : Text(
          'Search for doctors',
          style: TextStyle(color: Colors.grey, fontSize: 18),
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
                SizedBox(height: 30,child:
                  Container(
                    width:double.infinity,

                   height: MediaQuery.of(context).size.height * 0.1
                    ,
                    color: Colors.grey,
                  ),),
                Text(
                  'Results',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                        context, // Pass the context here
                        therapists[index][0] as String,
                        therapists[index][1] as String,
                        therapists[index][2] as double,
                        index,
                        isFavorite,
                        setState,
                      );
                    },
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

Widget therapistCard(
    BuildContext context, // Add BuildContext parameter here
    String name,
    String designation,
    double rating,
    int index,
    List<bool> isFavorite,
    Function setState,
    ) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFEFF3F6),
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
              padding: EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.05),
                child: Container(
                  width: 30, height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFEFF3F6), width: 2),
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
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
                      SizedBox(width: 40),
                      Image.asset("assets/images/Time.png", width: 15, height: 15),
                      Text(
                        "10:30am - 5:30pm",
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(right: 0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 1,
            height: 40,
            child: Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DoctorProfileScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4A5D6A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
                child: Text(
                  "Book Appointment",
                  style: TextStyle(fontSize: 13, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
      ],
    ),
  );
}
