import 'package:flutter/material.dart';

void main() {
  runApp(const StudyPlanner());
}

class StudyPlanner extends StatelessWidget {
  const StudyPlanner({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Study Planner"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Stack for the heading section
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    "images/studying.jpg",
                    height: 180,
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

              // Container for today's study details
              Container(
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

                    // Row for subject information
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Column(
                          children: [
                            Icon(Icons.book),
                            Text("Subjects"),
                            Text("5"),
                          ],
                        ),
                        const Column(
                          children: [
                            Icon(Icons.access_time),
                            Text("Hours"),
                            Text("3.5"),
                          ],
                        ),
                        const Column(
                          children: [
                            Icon(Icons.check_circle),
                            Text("Completed"),
                            Text("Yes"),
                          ],
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
            ],
          ),
        ),
      ),
    );
  }
}