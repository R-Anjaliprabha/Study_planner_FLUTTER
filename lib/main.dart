import 'package:flutter/material.dart';

void main() {
  // Start the Study Planner app
  runApp(const StudyPlanner());
}

class StudyPlanner extends StatelessWidget {
  const StudyPlanner({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Study Planner',
      home: const StudyPlannerHome(),
    );
  }
}

class StudyPlannerHome extends StatelessWidget {
  const StudyPlannerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar for the Study Planner
      appBar: AppBar(
        title: const Text('Study Planner'),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // Stack is used to place the heading over the image
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'images/studying.jpg',
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
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

            // Container is used to show today's study plan
            Container(
              width: double.infinity,
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

                  // Row arranges the study details side by side
                  Row(
                    children: [
                      // Expanded gives equal space to each section
                      const Expanded(
                        child: Column(
                          children: [
                            Icon(Icons.book),
                            Text('Subjects'),
                            Text('5'),
                          ],
                        ),
                      ),

                      const Expanded(
                        child: Column(
                          children: [
                            Icon(Icons.access_time),
                            Text('Hours'),
                            Text('3.5'),
                          ],
                        ),
                      ),

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

            // Shows a simple study message
            const Text(
              'Keep going! You are doing well.',
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 15),

            // Button to start studying
            ElevatedButton(
              onPressed: () {},
              child: const Text('Start Studying'),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}