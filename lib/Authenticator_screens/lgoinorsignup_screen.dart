import 'package:arrive_app/Authenticator_screens/Loginbottemsheet.dart';
import 'package:arrive_app/Authenticator_screens/otp_screen.dart';
import 'package:flutter/material.dart';

/// ---------------- COUNTRY MODEL ----------------
class Country {
  final String name;
  final String code;
  final String flag;

  Country({required this.name, required this.code, required this.flag});
}

/// ---------------- COUNTRY LIST ----------------
final List<Country> allCountries = [
  Country(name: "Tuvalu", code: "+688", flag: "🇹🇻"),
  Country(name: "Taiwan", code: "+886", flag: "🇹🇼"),
  Country(name: "Tanzania, United Republic Of", code: "+255", flag: "🇹🇿"),
  Country(name: "Ukraine", code: "+380", flag: "🇺🇦"),
  Country(name: "United Arab Emirates", code: "+971", flag: "🇦🇪"),
  Country(name: "United States", code: "+1", flag: "🇺🇸"),
  Country(name: "United Kingdom", code: "+44", flag: "🇬🇧"),
  Country(name: "Pakistan", code: "+92", flag: "🇵🇰"),
  Country(name: "India", code: "+91", flag: "🇮🇳"),
  Country(name: "Malaysia", code: "+60", flag: "🇲🇾"),
];

/// ---------------- MAIN SCREEN ----------------
class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  Country selectedCountry =
  Country(name: "Malaysia", code: "+60", flag: "🇲🇾");

  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Log in or sign up",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Create an account or log in to track your spiritual journey.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),

            /// PHONE ROW
            Row(
              children: [
                GestureDetector(
                  onTap: () => openCountryPicker(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        /// ✅ FLAG REMOVED – ONLY CODE
                        Text(
                          selectedCountry.code,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.keyboard_arrow_down),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: "Phone number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpScreen()));
              },
              child: Container(
                height: 55,
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
                    color: Color(0xff36454F), // Inside color of the container
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "Continue",
                      style: TextStyle(color: Colors.white,fontSize: 18), // Text color
                    ),
                  ),
                ),
              ),
            ),

            /// CONTINUE BUTTON
            // SizedBox(
            //   width: double.infinity,
            //   height: 55,
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: const Color(0xFF37474F),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(12),
            //       ),
            //     ),
            //     onPressed: () {
            //       Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpScreen()));
            //     },
            //     child: const Text(
            //       "Continue",
            //       style: TextStyle(fontSize: 18, color: Colors.white),
            //     ),
            //   ),
            // ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(child: Divider(color: Colors.grey.shade300)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text("OR"),
                ),
                Expanded(child: Divider(color: Colors.grey.shade300)),
              ],
            ),

            const SizedBox(height: 24),

            socialButton(icon: Icons.apple, text: "Continue with Apple"),
            const SizedBox(height: 8),
            socialButton(
                icon: Icons.facebook,
                text: "Continue with Facebook",
                iconColor: Colors.blue),
            const SizedBox(height: 8),
            socialButton1(
              image: Image.asset("assets/images/google.png"),
                text: "Continue with Google",
                iconColor: Colors.red),

            const SizedBox(height: 20),

             const Text("Have an account already?"),
            GestureDetector(
              onTap: (){

                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => const LoginBottomSheet(),
                );
              },
              child: const Text(
                "Sign in an account",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 25),

            Row(
              children: const [
                Icon(Icons.language, size: 18),
                SizedBox(width: 5),
                Text("English"),
                SizedBox(width: 20),
                Icon(Icons.support_agent, size: 18),
                SizedBox(width: 5),
                Text("Support"),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// ---------------- SOCIAL BUTTON ----------------
  Widget socialButton({
    required IconData icon,
    required String text,
    Color iconColor = Colors.black,
  }) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Icon(icon, color: iconColor, size: 32),
          ),
          const SizedBox(width: 35),
          Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
  Widget socialButton1({
    required Image image,
    required String text,
    Color iconColor = Colors.black,
  }) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Image(image: image.image , width: 30, height: 30),
          ),
          const SizedBox(width: 35),
          Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  /// ---------------- COUNTRY PICKER ----------------
  void openCountryPicker(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    List<Country> filteredList = List.from(allCountries);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,

      /// ✅ NOT FULL SCREEN
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.92,
      ),

      backgroundColor: Colors.transparent,

      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,

            /// ✅ TOP ROUNDED CORNERS
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return Column(
                children: [
                  const SizedBox(height: 12),

                  /// HEADER
                  Row(
                    children: [
                      const Expanded(
                        child: Center(
                          child: Text(
                            "Country/Region",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  ),

                  /// SEARCH
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "Search by country/Region",
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        setModalState(() {
                          filteredList = allCountries
                              .where((c) => c.name
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                              .toList();
                        });
                      },
                    ),
                  ),

                  /// LIST
                  Expanded(
                    child: ListView.separated(
                      itemCount: filteredList.length,
                      separatorBuilder: (_, __) =>
                          Divider(color: Colors.grey.shade300),
                      itemBuilder: (context, index) {
                        final country = filteredList[index];
                        final isSelected =
                            country.code == selectedCountry.code;

                        return ListTile(
                          leading: Text(country.flag,
                              style: const TextStyle(fontSize: 22)),
                          title:
                          Text("${country.name} (${country.code})"),
                          trailing: Icon(
                            isSelected
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off,
                            color:
                            isSelected ? Colors.green : Colors.grey,
                          ),
                          onTap: () {
                            setState(() {
                              selectedCountry = country;
                            });
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
