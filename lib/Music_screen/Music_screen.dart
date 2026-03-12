import 'package:flutter/material.dart';
class MusicScreen extends StatefulWidget {
  const MusicScreen({super.key});

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  late final mqsize = MediaQuery.of(context).size;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEFF3F6),
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.only(top: 20.0,right: 15,left: 15,bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios,size: 22,)),
                  SizedBox(width: 40,),
                  Text("Sunday, October 6",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),),
                ],
              ),
              SizedBox(height: 15,),
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("What did you have difficulties with\ntoday but manage to overcome?",style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),),
                      SizedBox(height: 8,),
                      Container(
                        height: 145,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xffEFF3F6),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color: Colors.black,
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(child: Text("I was feeling overwhelmed by\nwork but i took a few short\nbreaks to clear my head and\nrefocus.",style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.black
                          ),)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Today's photo",style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),),
                          Spacer(),
                          Icon(Icons.add,size: 22,color: Colors.black,)
                        ],
                      ),
                      SizedBox(height: 8,),
                      Container(
                          height: 85,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0xffEFF3F6),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                                color: Colors.black,
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Container(
                                  height: 70,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage("assets/images/4k image.jpg"),fit: BoxFit.cover,),
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ],
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Text("Great! Now let's add \n some music.",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8,),
              Text("Do you have a song in mind or would \n you like the AI to suggest a song for you?",style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.grey,
              ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10,),
              Container(
                height: mqsize.height*0.17,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0,left: 12,right: 12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image(image: AssetImage("assets/images/spotify_image.png"),height:40,width: 40,),
                          SizedBox(width: 10,),
                          Text("Search song by name...",style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 15,
                          ),),
                        ],
                      ),
                      SizedBox(height: 12,),
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 15.0),
                          filled: true,
                          prefixIcon: Icon(Icons.search),
                          hintText: "Search song by name...",
                          border: InputBorder.none, // Hides the border
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent), // No visible border
                            borderRadius: BorderRadius.circular(8), // Border radius applied
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent), // No visible border on focus
                            borderRadius: BorderRadius.circular(8), // Border radius applied
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: mqsize.height*0.2,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0,left: 12,right: 12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image(image: AssetImage("assets/images/spotify_image.png"),height:40,width: 40,),
                          SizedBox(width: 10,),
                          Text("Search song by name...",style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 15,
                          ),),
                        ],
                      ),
                      SizedBox(height: 12,),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("We'll find a song that matches\nyour journal entry.",)),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          height: 35,
                          width: mqsize.width*0.3,
                          decoration: BoxDecoration(
                            color: Colors.brown,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text("Generate",style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      )),
    );
  }
}