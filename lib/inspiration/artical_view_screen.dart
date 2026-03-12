import 'package:flutter/material.dart';

class ArticalViewScreen extends StatefulWidget {
  const ArticalViewScreen({super.key});

  @override
  State<ArticalViewScreen> createState() => _ArticalViewScreenState();
}

class _ArticalViewScreenState extends State<ArticalViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFF3F6),
      body: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.08,
                  right: MediaQuery.of(context).size.width * 0.06,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                        child: Icon(Icons.arrow_back_ios)),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.25),
                    Text(
                      'Article',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.bookmark_border_outlined, weight: 40,),
                    SizedBox(width: 8,),
                    Icon(Icons.more_vert_outlined, weight: 40,)
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.25),
              Row(
                children: [
                  Icon(
                    Icons.assignment_ind,
                    // You can replace with any category icon
                    color: Colors.blue,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                  Text(
                    'PREGNANCY & WELL-BEING',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Row(
                children: [
                  Text(
                    'The Transformative Journey of\n Pregnancy: Connecting with Your\n Body and Mind',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Row(
                children: [
                  Text(
                    'The Verge – Kyle Barr \n 2 mint read . Jul 13, 2023, 12:31 PM GMT+5:30',
                    style: TextStyle(fontSize: 12, color: Color(0xFF465762)),
                  ),
                ],
              ),
              Row(
                children: [
                  Image(image: AssetImage('assets/images/feed3.png')),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  Image(
                    image: AssetImage('assets/images/feed4.png'),
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.075,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  GestureDetector(
                    onTap: () {
                      // Show the bottom sheet when feed5 image is clicked
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            padding: EdgeInsets.only(left: 20, top: 20),
                            height: 350, // Set the height of the bottom sheet
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width *
                                        0.35,
                                    right:
                                        MediaQuery.of(context).size.width *
                                        0.05,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Article',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);  // Close the bottom sheet
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Color(0xFF74748014),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width *
                                        0.03,
                                    top:
                                    MediaQuery.of(context).size.height *
                                        0.03,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.bookmark_border),
                                          SizedBox(width: MediaQuery.of(context).size.width *
                                              0.03,),
                                          Text(
                                            'Save to bookshelf',
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: MediaQuery.of(context).size.height *
                                          0.02,),

                                      Row(
                                        children: [
                                          Icon(Icons.check),
                                          SizedBox(width: MediaQuery.of(context).size.width *
                                              0.03,),
                                          Text(
                                            'Show more this content',
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: MediaQuery.of(context).size.height *
                                          0.02,),
                                      Row(
                                        children: [
                                          Icon(Icons.file_download_outlined),
                                          SizedBox(width: MediaQuery.of(context).size.width *
                                              0.03,),
                                          Text(
                                            'Download',
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: MediaQuery.of(context).size.height *
                                          0.02,),
                                      Row(
                                        children: [
                                          Icon(Icons.file_upload_outlined),
                                          SizedBox(width: MediaQuery.of(context).size.width *
                                              0.03,),
                                          Text(
                                            'Share',
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Image(
                      image: AssetImage('assets/images/feed5.png'),
                      height: MediaQuery.of(context).size.height * 0.03,
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Pregnancy is more than just a physical process—\nit\'s a profound journey of connection,\n transformation, and growth.\n'
                    'As your body nurtures new life, your mind and\nemotions also undergo incredible changes. It\'s a\n time to slow down, reflect, '
                    'and prioritize self-\ncare. Building mindful routines like journaling,\nmeditation, and breathing exercises can help you\nconnect deeply with your body and prepare for\n the transition to parenthood.',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              Text(
                    'Key Practices for a Healthy Pregnancy:',
                    style: TextStyle(fontSize: 12,),
                  ),
              Text(
                '•🧘Mindful Breathing: Simple breathing',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
