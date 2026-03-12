import 'package:flutter/material.dart';
import 'appointment.dart'; // Ensure this file contains AppointmentScreen class

class DoctorProfileScreen extends StatefulWidget {
  @override
  _DoctorProfileScreenState createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isAppointmentSelected = false;
  String? _selectedDay;
  String? _selectedMonth;

  final List<String> days = List.generate(31, (index) => (index + 1).toString());
  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August',
    'September', 'October', 'November', 'December'
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFEFF3F6),
      appBar: AppBar(
        backgroundColor: Color(0xFFEFF3F6),
        title: Center(child: Text('Therapy')),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Top Image (Fixed)
          Container(
            width: double.infinity,
            height: screenHeight * 0.2,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/heartbeatGraph.png"),
              ),
            ),
          ),
          // Scrollable Content Section with white background
          Expanded(
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Doctor info card
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'David H. Brown',
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.05,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Psychologist | Apollo Hospital',
                                  style: TextStyle(fontSize: 14, color: Colors.grey),
                                ),
                                Row(
                                  children: [
                                    Image.asset("assets/images/Time.png",
                                        width: 20, height: 20),
                                    SizedBox(width: 5),
                                    Text('10:30am - 5:30pm'),
                                  ],
                                ),
                              ],
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                              child: Row(
                                children: [
                                  Icon(Icons.star, color: Colors.amber),
                                  Text('4.8'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.grey.withOpacity(0.2),
                          thickness: 1),

                      // Experience and treated info
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _infoColumn('15yr', 'Experience'),
                          _infoColumn('50+', 'Treated'),
                          _infoColumn('\$25.00', 'Hourly Rate'),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      // Select Date Text
                      Text(
                        'Select Date',
                        style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      // Date Selector
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildDateDropdown('Day', days, _selectedDay, (newValue) {
                            setState(() {
                              _selectedDay = newValue;
                            });
                          }),
                          SizedBox(width: 10),
                          _buildDateDropdown('Month', months, _selectedMonth, (newValue) {
                            setState(() {
                              _selectedMonth = newValue;
                            });
                          }),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      // Schedules Text
                      Text(
                        'Schedules',
                        style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      // Schedule Options
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildScheduleRow('10:30am - 11:30am', '11:30am - 12:30pm'),
                          _buildScheduleRow('12:30pm - 1:30pm', '2:30pm - 3:30pm'),
                          _buildScheduleRow('3:30pm - 4:30pm', '4:30pm - 5:30pm'),
                        ],
                      ),
                      SizedBox(height: 20),
                      // Book Appointment Button
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AppointmentScreen()));
                        },
                        child: Container(
                          height: 48,
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
                              color: Color(0xff4A5D6A),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                "Book Appoinment",
                                style: TextStyle(color: Colors.white,fontSize: 15), // Text color
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method for info columns
  Column _infoColumn(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  // Helper method for date dropdowns
  Widget _buildDateDropdown(String hint, List<String> items, String? value, ValueChanged<String?> onChanged) {
    return Container(
      width: 150,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton<String>(
        dropdownColor: Color(0xFFEFF3F6),
        value: value,
        hint: Text(hint),
        isExpanded: true,
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        icon: Icon(
          Icons.keyboard_arrow_down, // Custom icon for dropdown
          color: Colors.black, // Set color for the icon
        ),
        underline: SizedBox(), // Removes the underline
      ),
    );
  }

  // Helper method for schedule rows
  Row _buildScheduleRow(String time1, String time2) {
    return Row(
      children: [
        ScheduleOption(time: time1, onSelect: () {
          setState(() {
            _isAppointmentSelected = true;
          });
        }),
        ScheduleOption(time: time2, onSelect: () {
          setState(() {
            _isAppointmentSelected = true;
          });
        }),
      ],
    );
  }
}

class ScheduleOption extends StatelessWidget {
  final String time;
  final VoidCallback onSelect;

  const ScheduleOption({required this.time, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: onSelect,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.4,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    time,
                    style: TextStyle(fontSize: 11),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

