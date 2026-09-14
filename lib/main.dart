import 'package:flutter/material.dart';

void main() {
  // Navigator and Named Routes are used to move between different screens
  runApp(const StudyPlanner());
}

class StudyPlanner extends StatelessWidget {
  const StudyPlanner({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp is used to manage the application and named routes
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Study Planner',

      // Named routes are registered here
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/details': (context) => const StudyDetailsScreen(),
        '/about': (context) => const AboutScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold provides the basic structure of the Home Screen
    return Scaffold(
      // AppBar displays the application title
      appBar: AppBar(
        title: const Text('Study Planner'),
      ),

      // Navigation Drawer provides navigation to different screens
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // DrawerHeader displays the drawer heading
            const DrawerHeader(
              child: Center(
                child: Text(
                  'Study Planner',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Named route is used to return to the Home Screen
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
            ),

            // Named route is used to open the Study Details Screen
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Study Details'),
              onTap: () {
                Navigator.pushNamed(context, '/details');
              },
            ),

            // Named route is used to open the About Screen
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
          ],
        ),
      ),

      // SingleChildScrollView allows the screen to scroll when needed
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Stack places the heading over the study image
            Stack(
              alignment: Alignment.center,
              children: [
                // Image.asset displays the local study image
                Image.asset(
                  'images/studying.jpg',
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                // Text displays the main heading
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

            // Container groups the study plan information
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(10),
              ),

              // Column arranges the study plan contents vertically
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

                  // Row arranges the study details horizontally
                  Row(
                    children: [
                      // Expanded divides the available Row space
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

            const Text(
              'Keep going! You are doing well.',
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 15),

            // Navigator.push with MaterialPageRoute opens another screen
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // Data is passed to the Study Details Screen
                    builder: (context) => const StudyDetailsScreen(
                      studyName: 'Today\'s Study Plan',
                    ),
                  ),
                );
              },
              child: const Text('View Study Details'),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Study Details Screen receives data from the Home Screen
class StudyDetailsScreen extends StatelessWidget {
  final String studyName;

  const StudyDetailsScreen({
    super.key,
    this.studyName = 'Study Details',
  });

  @override
  Widget build(BuildContext context) {
    // Scaffold provides the basic structure of the Details Screen
    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Details'),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),

          // Column arranges the details vertically
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.school,
                size: 70,
              ),

              const SizedBox(height: 20),

              // Displays the data passed from the Home Screen
              Text(
                studyName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              const Text(
                'Subjects: 5',
                style: TextStyle(fontSize: 18),
              ),

              const Text(
                'Study Hours: 3.5',
                style: TextStyle(fontSize: 18),
              ),

              const Text(
                'Completed: Yes',
                style: TextStyle(fontSize: 18),
              ),

              const SizedBox(height: 25),

              // Navigator.pop returns to the previous screen
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back to Study Planner'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// About Screen demonstrates another named route
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold provides the basic structure of the About Screen
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),

      // Center places the About information in the middle
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.school,
              size: 70,
            ),

            const SizedBox(height: 20),

            const Text(
              'Study Planner',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'A simple app for planning daily study activities.',
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 25),

            // Navigator.pop returns to the previous screen
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}