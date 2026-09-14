import 'package:flutter/material.dart';

void main() {
  // Flutter and Dart: main() is the starting point of the application
  runApp(const StudyPlanner());
}

class StudyPlanner extends StatelessWidget {
  const StudyPlanner({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp is used to create the main Flutter application
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StudyPlannerHome(),
    );
  }
}

class StudyPlannerHome extends StatelessWidget {
  const StudyPlannerHome({super.key});

  @override
  Widget build(BuildContext context) {
    // MediaQuery is used to get the screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // MediaQuery is used to detect the screen orientation
    Orientation orientation = MediaQuery.of(context).orientation;

    // Scaffold provides the basic structure of the screen
    return Scaffold(
      // AppBar is used to display the application title
      appBar: AppBar(
        title: const Text('Study Planner'),
      ),

      // LayoutBuilder is used to check the available screen size
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Checks whether the available width is suitable for a tablet
          bool isTablet = constraints.maxWidth >= 600;

          // SingleChildScrollView allows the screen to scroll when needed
          return SingleChildScrollView(
            // Column arranges the widgets vertically
            child: Column(
              children: [
                // Stack is used to place text over the study image
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Image height changes according to orientation and screen size
                    Image.asset(
                      'images/studying.jpg',
                      height: orientation == Orientation.landscape
                          ? (isTablet ? 250 : 200)
                          : (isTablet ? 250 : 180),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),

                    // Text widget displays the heading
                    const Text(
                      'Plan Your Study',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Container width is adjusted using MediaQuery
                Container(
                  width: screenWidth * 0.9,
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10),
                  ),

                  // Column arranges the study plan contents vertically
                  child: Column(
                    children: [
                      // Text widget displays the study plan heading
                      const Text(
                        "Today's Study Plan",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Row arranges the study details horizontally
                      Row(
                        children: [
                          // Expanded divides the available space equally
                          const Expanded(
                            child: Column(
                              children: [
                                Icon(Icons.book),
                                Text('Subjects'),
                                Text('5'),
                              ],
                            ),
                          ),

                          // Expanded gives equal space to the Hours section
                          const Expanded(
                            child: Column(
                              children: [
                                Icon(Icons.access_time),
                                Text('Hours'),
                                Text('3.5'),
                              ],
                            ),
                          ),

                          // Expanded gives equal space to the Completed section
                          const Expanded(
                            child: Column(
                              children: [
                                Icon(Icons.check_circle),
                                Text('Completed'),
                                Text('Yes'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // Text widget displays a simple message
                const Text(
                  'Keep going! You are doing well.',
                  style: TextStyle(fontSize: 18),
                ),

                const SizedBox(height: 15),

                // ElevatedButton is used to create the Start Studying button
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Start Studying'),
                ),

                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}