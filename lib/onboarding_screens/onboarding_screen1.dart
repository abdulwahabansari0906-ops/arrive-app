import 'package:arrive_app/onboarding_screens/onboarding_screen2.dart';
import 'package:arrive_app/view_screens/Started_Screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class OnboardingScreen1 extends StatefulWidget {
  const OnboardingScreen1({super.key});

  @override
  State<OnboardingScreen1> createState() => _OnboardingScreen1State();
}

class _OnboardingScreen1State extends State<OnboardingScreen1> {
   late final mqsize=MediaQuery.of(context).size;
  PageController _pageController=PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        height: mqsize.height*1,
        width: mqsize.width*1,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/backgroundimage.jpg"),fit: BoxFit.cover)
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25.0,right: 5),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: (){
                        if(_pageController.page==2){
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>StartedScreen()),
                              (Route<dynamic>route)=>false);
                        } else{
                          _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                        }
                      },
                      child: Text("Skip",style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),),
                    ),
                  ),
                ),
                SizedBox(height: 320,),
                Expanded(child: PageView(
                  controller: _pageController,
                  onPageChanged: (index){
                    setState(() {

                    });
                  },
                  children: [
                    _onboardingpage("Explore your journey", "Discover a private and secure space to process your thoughts."),
                    _onboardingpage("Deepen Your Understanding", "Receive daily feedback, insights, and guidance from professional therapists."),
                    _onboardingpage("Save Your Progress", "Write, reflect, and bookmark your thoughts."),
                  ],
                )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 80.0),
                  child: SmoothPageIndicator(controller: _pageController, count: 3,effect: ExpandingDotsEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 8,
                    expansionFactor: 4,
                    dotColor: Color(0xff697C88),
                    activeDotColor: Color(0xff98FF98),
                  ),),
                ),
                // idher ham na wo us ko flutter ma kia kahta han ... ko jo onboarding screen ma lagta han wo lgana han wo kasa lgain ga
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child:   GestureDetector(
                    onTap: (){
                      if(_pageController.page==2){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>StartedScreen()),
                            (Route<dynamic>route)=>false);
                      } else {
                        _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                      }
                    },
                    child: Container(
                      height: 48,
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
                          color: Color(0xff36454F), // Inside color of the container
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            "Next",
                            style: TextStyle(color: Colors.white,fontSize: 16), // Text color
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _onboardingpage(String title, String subtitle){
    return Column(
      children: [
        Text(title,style: TextStyle(
          fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.w900,
        ),
        textAlign: TextAlign.center,),
        SizedBox(height: 8,),
        Text(subtitle,style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
          fontFamily: "Orbikular",
          color: Colors.white,
        ),
        textAlign: TextAlign.center,)
      ],
    );
  }
}
