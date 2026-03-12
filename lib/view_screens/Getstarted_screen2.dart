import 'package:arrive_app/onboarding_screens/onboarding_screen3.dart';
import 'package:arrive_app/view_screens/RateMood_Screen.dart';
import 'package:flutter/material.dart';

class GetStartedScreen2 extends StatefulWidget {
  @override
  _GetStartedScreen2State createState() => _GetStartedScreen2State();
}

class _GetStartedScreen2State extends State<GetStartedScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2EC598),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30,right: 30,top: 50),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios,size: 22,color: Colors.white,)),
              ),
            ),
            SizedBox(height: 20,),
            // Greeting Text
            Text(
              'Hi Anna!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            // Subheading Text
            Padding(
              padding: const EdgeInsets.only(left: 25,right: 25,),
              child: Text(
                'Log your mood',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 80),
            // Circle with Image
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Center(
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/ghi.jpg', // Replace with your image path
                      fit: BoxFit.cover,
                      width: 140,
                      height: 140,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 280,),
            // 'Get Started' Button
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>RateMoodScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Container(
                  width: double.infinity,
                  height: 48,
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xff98FF98), Color(0xff88D8C0)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff122029),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        "Get Started",
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
