import 'package:flutter/material.dart';

import 'artical_view_screen.dart';
import 'feed.dart';


class InspirationFeed extends StatefulWidget {
  const InspirationFeed({super.key});

  @override
  State<InspirationFeed> createState() => _InspirationFeedState();
}

class _InspirationFeedState extends State<InspirationFeed>
    with SingleTickerProviderStateMixin {
  late TabController
  _tabController; // Use late here because it's initialized in initState
bool isLiked = false;
  @override
  void initState() {
    super.initState();
    // Initialize the TabController in initState
    _tabController = TabController(
      length: 4,
      vsync: this,
    ); // 4 tabs: Mindfulness, Motivation, Self-Care, Creativity
  }

  @override
  void dispose() {
    _tabController
        .dispose(); // Dispose of the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFF3F6),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // First row with title and icons
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.02,
                top: MediaQuery.of(context).size.height * 0.08,
                right: MediaQuery.of(context).size.width * 0.05,
              ),
              child: Row(
                children: [
              IconButton(
              icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context); // Pops the current screen from the stack
      },
    ),

                  SizedBox(width: MediaQuery.of(context).size.width * 0.12),
                  Text(
                    'Inspiration Feed',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  Icon(Icons.search, size: 28),
                ],
              ),
            ),

            // TabBar (below first row)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: TabBar(
                controller: _tabController,
                tabs: [
                  Tab(text: 'Mindfulness'),
                  Tab(text: 'Motivation'),
                  Tab(text: 'Self-Care'),
                  Tab(text: 'Creativity'),
                ],
                // Selected tab color
                unselectedLabelColor: Colors.black, // Unselected tab color
                indicatorColor: Colors.blue,
                labelStyle: TextStyle(fontSize: 10),// Underline color for selected tab
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    'Top Stories',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                  ),
                  Spacer(),
                  Text(
                    'See all',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 114,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0,right: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 62,
                              width: 62,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Pregnancy . anna love",style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),),
                              SizedBox(height: 8,),
                              Text("How Mindfulness Can Support You\nThrough Pregnancy",style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Text("Jul 13, 2024 • 2 min read",style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff122029),
                          ),),
                          Spacer(),
                          Icon(Icons.bookmark_border_outlined,color: Colors.black,size: 18,),
                          SizedBox(width: 8,),
                          Icon(Icons.more_vert_outlined,color: Colors.black,size: 16,)

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 114,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0,right: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 62,
                              width: 62,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Pregnancy . anna love",style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),),
                              SizedBox(height: 8,),
                              Text("How Mindfulness Can Support You\nThrough Pregnancy",style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Text("Jul 13, 2024 • 2 min read",style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff122029),
                          ),),
                          Spacer(),
                          Icon(Icons.bookmark_border_outlined,color: Colors.black,size: 18,),
                          SizedBox(width: 8,),
                          Icon(Icons.more_vert_outlined,color: Colors.black,size: 16,)

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 114,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0,right: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 62,
                              width: 62,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Pregnancy . anna love",style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),),
                              SizedBox(height: 8,),
                              Text("How Mindfulness Can Support You\nThrough Pregnancy",style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Text("Jul 13, 2024 • 2 min read",style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff122029),
                          ),),
                          Spacer(),
                          Icon(Icons.bookmark_border_outlined,color: Colors.black,size: 18,),
                          SizedBox(width: 8,),
                          Icon(Icons.more_vert_outlined,color: Colors.black,size: 16,)

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(children: [
               GestureDetector(onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => Feed(),));
    },

                   child:  Text('Feed',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),)),
                Spacer(),
                GestureDetector(onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ArticalViewScreen(),));
                },
                  child: Text(
                    'See all',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.04,
                top: MediaQuery.of(context).size.height * 0.04,
                right: MediaQuery.of(context).size.width * 0.04,
              ),
              child: Container(
                padding: const EdgeInsets.all(12), // Inner padding
                decoration: BoxDecoration(
                  color: Colors.white, // White background
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ListTile at the top
                    ListTile(
                      contentPadding: EdgeInsets.zero, // remove default padding
                      leading: ClipOval(
                        child: Image.asset(
                          'assets/images/chatscreen5.png',
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width * 0.15,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        'Anna',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      subtitle: Text(
                        '@annapreg',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF697C88),
                        ),
                      ),
                    ),

                    SizedBox(height: 12),

                    // Column below ListTile
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Replying to @Lilia_Psyghologist',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF697C88),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Take one step at a time. Healing and growth\n are not linear, and it’s okay to move slowly.\n What matters most is showing up for yourself,\n day after day. Be kind to yourself, always.',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Divider(),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isLiked = !isLiked; // Toggle state
                                });
                              },
                              child: Icon(
                                isLiked ? Icons.favorite : Icons.favorite_border,
                                size: 25,
                                color: isLiked ? Colors.red : Colors.grey,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            Text(
                              '32',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF697C88),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.06,
                            ),
                            Image(
                              image: AssetImage('assets/images/feed1.png'),
                              height: MediaQuery.of(context).size.height * 0.04,
                              width: MediaQuery.of(context).size.width * 0.06,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04,
                            ),
                            Text(
                              'Reply',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF697C88),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.08,
                            ),
                            Image(
                              image: AssetImage('assets/images/feed2.png'),
                              height: MediaQuery.of(context).size.height * 0.04,
                              width: MediaQuery.of(context).size.width * 0.04,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03,
                            ),
                            Text(
                              'Copy link',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF697C88),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 2,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              'Read 5 replies',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
