import 'package:flutter/material.dart';

class OnboardingPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child:  Container(
          width: double.infinity,
          height: 250,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  children:[ Text(
                    'Today’s photo',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6B7A88),
                    ),
                  ),
                    Spacer(),
                    Image(image: AssetImage("assets/images/ic_round-plus.png"))
                  ]
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  // Handle photo selection here
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
                        SizedBox(height: 15,),
                        Text(
                          'Select up to 4 photos',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF6B7A88),
                          ),
                        ),
                      ]
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
