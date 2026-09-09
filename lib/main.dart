import 'package:flutter/material.dart';

void main() {
  runApp(const StudyPlanner());
}

class StudyPlanner extends StatelessWidget {
  const StudyPlanner({super.key});

  @override
  Widget build(BuildContext context) {
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
    // MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;

    // Orientation
    Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Study Planner"),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // LayoutBuilder
          bool isTablet = constraints.maxWidth >= 600;

          return SingleChildScrollView(
            child: Column(
              children: [
                // Stack for the heading section
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      "images/studying.jpg",
                      height: orientation == Orientation.landscape
                          ? (isTablet ? 250 : 200)
                          : (isTablet ? 250 : 180),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    const Text(
                      "Plan Your Study",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Responsive container using MediaQuery
                Container(
                  width: screenWidth * 0.9,
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Today's Study Plan",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Expanded - shares available width equally
                      Row(
                        children: [
                          const Expanded(
                            child: Column(
                              children: [
                                Icon(Icons.book),
                                Text("Subjects"),
                                Text("5"),
                              ],
                            ),
                          ),
                          const Expanded(
                            child: Column(
                              children: [
                                Icon(Icons.access_time),
                                Text("Hours"),
                                Text("3.5"),
                              ],
                            ),
                          ),
                          const Expanded(
                            child: Column(
                              children: [
                                Icon(Icons.check_circle),
                                Text("Completed"),
                                Text("Yes"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Keep going! You are doing well.",
                  style: TextStyle(fontSize: 18),
                ),

                const SizedBox(height: 15),

                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Start Studying"),
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