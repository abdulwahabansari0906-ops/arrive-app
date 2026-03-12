import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  bool isLiked = false;
  bool isLiked2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              /// 🔹 HEADER
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.015,
                  top: MediaQuery.of(context).size.height * 0.02,
                  right: MediaQuery.of(context).size.width * 0.03,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                        width:
                        MediaQuery.of(context).size.width * 0.25),
                    const Text(
                      'Feed',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    const Icon(Icons.search, size: 28),
                  ],
                ),
              ),

              /// 🔹 FIRST POST
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal:
                  MediaQuery.of(context).size.width * 0.04,
                  vertical:
                  MediaQuery.of(context).size.height * 0.02,
                ),
                child: _buildPost(
                  context,
                  isFirst: true,
                  name: "Anna",
                  username: "@annapreg",
                  showImage: false,
                ),
              ),

              /// 🔹 SECOND POST
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal:
                  MediaQuery.of(context).size.width * 0.04,
                  vertical:
                  MediaQuery.of(context).size.height * 0.01,
                ),
                child: _buildPost(
                  context,
                  isFirst: false,
                  name: "John_mentalhealth",
                  username: "@username",
                  showImage: true,
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPost(
      BuildContext context, {
        required bool isFirst,
        required String name,
        required String username,
        required bool showImage,
      }) {
    bool liked = isFirst ? isLiked : isLiked2;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// PROFILE SECTION
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: ClipOval(
              child: Image.asset(
                'assets/images/chatscreen5.png',
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              name,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 12),
            ),
            subtitle: Text(
              username,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF697C88),
              ),
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Replying to @Lilia_Psyghologist',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: Color(0xFF697C88),
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Take one step at a time. Healing and growth are not linear, and it’s okay to move slowly. What matters most is showing up for yourself, day after day. Be kind to yourself, always.',
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w500),
          ),

          if (showImage) ...[
            const SizedBox(height: 8),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ],

          const SizedBox(height: 10),
          const Divider(),

          /// ACTION ROW
          Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    if (isFirst) {
                      isLiked = !isLiked;
                    } else {
                      isLiked2 = !isLiked2;
                    }
                  });
                },
                child: Icon(
                  liked
                      ? Icons.favorite
                      : Icons.favorite_border,
                  size: 25,
                  color:
                  liked ? Colors.red : Colors.grey,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                '32',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF697C88),
                ),
              ),
              const SizedBox(width: 25),
    Image(
                             image: AssetImage('assets/images/feed1.png'),
                             height: MediaQuery.of(context).size.height * 0.04,
                             width: MediaQuery.of(context).size.width * 0.06,
                           ),
                           SizedBox(
                             width: MediaQuery.of(context).size.width * 0.02,
                          ),

              const Text(
                'Reply',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF697C88),
                ),
              ),
              const SizedBox(width: 25),
    Image(
                            image: AssetImage('assets/images/feed2.png'),
                             height: MediaQuery.of(context).size.height * 0.04,
                             width: MediaQuery.of(context).size.width * 0.04,
                           ),
                           SizedBox(
                             width: MediaQuery.of(context).size.width * 0.02,
                           ),
              const Text(
                'Copy link',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF697C88),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Container(
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Center(
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
    );
  }
}




// import 'package:flutter/material.dart';
//
// class Feed extends StatefulWidget {
//   const Feed({super.key});
//
//   @override
//   State<Feed> createState() => _FeedState();
// }
//
// class _FeedState extends State<Feed> {
//   bool isLiked = false;
//   bool isLiked2 = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFEFF3F6),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(
//               left: MediaQuery.of(context).size.width * 0.09,
//               top: MediaQuery.of(context).size.height * 0.08,
//               right: MediaQuery.of(context).size.width * 0.09,
//             ),
//             child: Row(
//               children: [
//             IconButton(
//             icon: Icon(Icons.arrow_back_ios),
//             onPressed: () {
//             Navigator.pop(context); // Pops the current screen from the stack
//             },
//             ),
//
//                 SizedBox(width: MediaQuery.of(context).size.width * 0.25),
//                 Text(
//                   'Feed',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//                 ),
//                 Spacer(),
//                 Icon(Icons.search, size: 28),
//               ],
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(
//               left: MediaQuery.of(context).size.width * 0.04,
//               top: MediaQuery.of(context).size.height * 0.02,
//               right: MediaQuery.of(context).size.width * 0.04,
//             ),
//             child: Container(
//               padding: const EdgeInsets.all(12), // Inner padding
//               decoration: BoxDecoration(
//                 color: Colors.white, // White background
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // ListTile at the top
//                   ListTile(
//                     contentPadding: EdgeInsets.zero, // remove default padding
//                     leading: ClipOval(
//                       child: Image.asset(
//                         'assets/images/chatscreen5.png',
//                         height: MediaQuery.of(context).size.height * 0.15,
//                         width: MediaQuery.of(context).size.width * 0.15,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     title: Text(
//                       'Anna',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 12,
//                       ),
//                     ),
//                     subtitle: Text(
//                       '@annapreg',
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500,
//                         color: Color(0xFF697C88),
//                       ),
//                     ),
//                   ),
//
//                   SizedBox(height: 12),
//
//                   // Column below ListTile
//                   Column(
//                     children: [
//                       Row(
//                         children: [
//                           Text(
//                             'Replying to @Lilia_Psyghologist',
//                             style: TextStyle(
//                               fontSize: 11,
//                               fontWeight: FontWeight.w400,
//                               color: Color(0xFF697C88),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             'Take one step at a time. Healing and growth\n are not linear, and it’s okay to move slowly.\n What matters most is showing up for yourself,\n day after day. Be kind to yourself, always.',
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.01,
//                       ),
//                       Divider(),
//                       Row(
//                         children: [
//                           InkWell(
//                             onTap: () {
//                               setState(() {
//                                 isLiked = !isLiked; // Toggle state
//                               });
//                             },
//                             child: Icon(
//                               isLiked ? Icons.favorite : Icons.favorite_border,
//                               size: 25,
//                               color: isLiked ? Colors.red : Colors.grey,
//                             ),
//                           ),
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width * 0.02,
//                           ),
//                           Text(
//                             '32',
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w400,
//                               color: Color(0xFF697C88),
//                             ),
//                           ),
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width * 0.06,
//                           ),
//                           Image(
//                             image: AssetImage('assets/images/feed1.png'),
//                             height: MediaQuery.of(context).size.height * 0.04,
//                             width: MediaQuery.of(context).size.width * 0.06,
//                           ),
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width * 0.04,
//                           ),
//                           Text(
//                             'Reply',
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               color: Color(0xFF697C88),
//                             ),
//                           ),
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width * 0.08,
//                           ),
//                           Image(
//                             image: AssetImage('assets/images/feed2.png'),
//                             height: MediaQuery.of(context).size.height * 0.04,
//                             width: MediaQuery.of(context).size.width * 0.04,
//                           ),
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width * 0.03,
//                           ),
//                           Text(
//                             'Copy link',
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               color: Color(0xFF697C88),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.02,
//                       ),
//                       Container(
//                         width: MediaQuery.of(context).size.width * 2,
//                         height: MediaQuery.of(context).size.height * 0.05,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.black12),
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                         child: Center(
//                           child: Text(
//                             'Read 5 replies',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w700,
//                               fontSize: 12,
//                               color: Colors.blue,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(
//               left: MediaQuery.of(context).size.width * 0.04,
//               top: MediaQuery.of(context).size.height * 0.01,
//               right: MediaQuery.of(context).size.width * 0.04,
//             ),
//             child: Container(
//               padding: const EdgeInsets.all(12), // Inner padding
//               decoration: BoxDecoration(
//                 color: Colors.white, // White background
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // ListTile at the top
//                   ListTile(
//                     contentPadding: EdgeInsets.zero, // remove default padding
//                     leading: ClipOval(
//                       child: Image.asset(
//                         'assets/images/chatscreen5.png',
//                         height: MediaQuery.of(context).size.height * 0.15,
//                         width: MediaQuery.of(context).size.width * 0.15,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     title: Text(
//                       'John_mentalhealth',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 12,
//                       ),
//                     ),
//                     subtitle: Text(
//                       '@username',
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500,
//                         color: Color(0xFF697C88),
//                       ),
//                     ),
//                   ),
//
//                   SizedBox(height: 12),
//
//                   // Column below ListTile
//                   Column(
//                     children: [
//                       Row(
//                         children: [
//                           Text(
//                             'Replying to @Lilia_Psyghologist',
//                             style: TextStyle(
//                               fontSize: 11,
//                               fontWeight: FontWeight.w400,
//                               color: Color(0xFF697C88),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             'Take one step at a time. Healing and growth\n are not linear, and it’s okay to move slowly.\n What matters most is showing up for yourself,\n day after day. Be kind to yourself, always.',
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.01,
//                       ),
//                       Divider(),
//                       Row(
//                         children: [
//                           InkWell(
//                             onTap: () {
//                               setState(() {
//                                 isLiked2 = !isLiked2; // Toggle state
//                               });
//                             },
//                             child: Icon(
//                               isLiked2 ? Icons.favorite : Icons.favorite_border,
//                               size: 25,
//                               color: isLiked2 ? Colors.red : Colors.grey,
//                             ),
//                           ),
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width * 0.02,
//                           ),
//                           Text(
//                             '32',
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w400,
//                               color: Color(0xFF697C88),
//                             ),
//                           ),
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width * 0.06,
//                           ),
//                           Image(
//                             image: AssetImage('assets/images/feed1.png'),
//                             height: MediaQuery.of(context).size.height * 0.04,
//                             width: MediaQuery.of(context).size.width * 0.06,
//                           ),
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width * 0.04,
//                           ),
//                           Text(
//                             'Reply',
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               color: Color(0xFF697C88),
//                             ),
//                           ),
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width * 0.08,
//                           ),
//                           Image(
//                             image: AssetImage('assets/images/feed2.png'),
//                             height: MediaQuery.of(context).size.height * 0.04,
//                             width: MediaQuery.of(context).size.width * 0.04,
//                           ),
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width * 0.03,
//                           ),
//                           Text(
//                             'Copy link',
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               color: Color(0xFF697C88),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.02,
//                       ),
//                       Container(
//                         width: MediaQuery.of(context).size.width * 2,
//                         height: MediaQuery.of(context).size.height * 0.05,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.black12),
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                         child: Center(
//                           child: Text(
//                             'Read 5 replies',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w700,
//                               fontSize: 12,
//                               color: Colors.blue,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
