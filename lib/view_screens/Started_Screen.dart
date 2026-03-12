import 'package:arrive_app/onboarding_screens/onboarding_screen2.dart';
import 'package:flutter/material.dart';
class StartedScreen extends StatefulWidget {
  const StartedScreen({super.key});

  @override
  State<StartedScreen> createState() => _StartedScreenState();
}

class _StartedScreenState extends State<StartedScreen> {
  late final mqsize=MediaQuery.of(context).size;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: mqsize.height*1,
        width: mqsize.width*1,
        decoration: BoxDecoration(
         image: DecorationImage(image: AssetImage("assets/images/backgroundimage2.jpg"),fit: BoxFit.cover)
        ),
        child: SingleChildScrollView(
          child: SafeArea(child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 27.0,right: 5),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>OnboardingScreen()),
                                (Route<dynamic>route)=>false);
                      },
                      child: Text("Skip",style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                      ),),
                    ),
                  ),
                ),
                SizedBox(height: 370,),
                Text("Stay Connected to \n Your Faith",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 24,
                ),textAlign: TextAlign.center,),
                SizedBox(height: 35,),
                GestureDetector(
                  onTap: (){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>OnboardingScreen()),
                        (Route<dynamic>route)=>false);
                  },
                  child: Container(
                    height: 44,
                    width: mqsize.width * 0.9,
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
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xff36454f),Color(0xff8EE7B0)],stops: [0.2,1]), // Inside color of the container
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          "Get Started",
                          style: TextStyle(color: Colors.white,fontSize: 20), // Text color
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 35,),
                Text("By Continuing, You Accept Our Terms Of Services\n And Acknowledge Receipt of Our Privacy Policy",style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
