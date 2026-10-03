import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ChangeNotifier is used to manage the shared study session state
class StudyProvider extends ChangeNotifier {
  int studySessions = 0;

  // This method updates the study session count
  // and notifies the widgets using Provider
  void completeStudySession() {
    studySessions++;
    notifyListeners();
  }
}

// Custom widget for displaying study information
// This makes the same UI component reusable in different places
class StudyInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const StudyInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    // Card is used to create a clean reusable study information component
    return Expanded(
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 8,
          ),
          child: Column(
            children: [
              // Icon displays the type of study information
              Icon(
                icon,
                size: 28,
              ),

              const SizedBox(height: 8),

              // Displays the name of the information
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 4),

              // Displays the corresponding value
              Text(
                value,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom widget for reusable action buttons
// The same button design can be used throughout the application
class StudyActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData icon;

  const StudyActionButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // ElevatedButton uses the style defined by the application ThemeData
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(text),
      ),
    );
  }
}

void main() {
  // ChangeNotifierProvider makes StudyProvider available
  // throughout the application
  runApp(
    ChangeNotifierProvider(
      create: (_) => StudyProvider(),
      child: const StudyPlanner(),
    ),
  );
}

class StudyPlanner extends StatelessWidget {
  const StudyPlanner({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp manages the application and named routes
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Study Planner',

      // ThemeData is used to apply a consistent style
      // throughout the entire application
      theme: ThemeData(
        useMaterial3: true,

        // Defines the main application color
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),

        // Defines the background of the application screens
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),

        // Defines the default AppBar appearance
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
        ),

        // Defines the common Card appearance
        cardTheme: const CardTheme(
        elevation: 2,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
        Radius.circular(16),
        ),
      ),
    ),

        // Defines the common ElevatedButton appearance
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 20,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        // Defines common text styles
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
          ),
        ),
      ),

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

// StatefulWidget is used for the Home Screen
// The actual study session state is managed by Provider
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Provider.of reads the shared study session state
    final provider = Provider.of<StudyProvider>(context);

    // Scaffold provides the basic structure of the Home Screen
    return Scaffold(
      // AppBar displays the application title
      appBar: AppBar(
        title: const Text(
          'Study Planner',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // Navigation Drawer provides navigation to different screens
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // DrawerHeader displays the application heading
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.school,
                    color: Colors.white,
                    size: 40,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Study Planner',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Plan • Study • Achieve',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
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

      // SingleChildScrollView allows the screen to scroll when required
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section displays the study image and title
            Stack(
              alignment: Alignment.center,
              children: [
                // Image.asset displays the local study image
                Image.asset(
                  'images/studying.jpg',
                  height: 210,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                // A dark overlay improves the readability of the heading
                Container(
                  height: 210,
                  width: double.infinity,
                  color: Colors.black38,
                ),

                // Main heading displayed over the image
                const Column(
                  children: [
                    Icon(
                      Icons.menu_book,
                      color: Colors.white,
                      size: 42,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Plan Your Study',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Stay focused. Keep learning.',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Padding provides consistent spacing around the content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section heading
                  Text(
                    "Today's Study Plan",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'Keep track of your daily study activities.',
                  ),

                  const SizedBox(height: 18),

                  // Row displays the reusable custom StudyInfoCard widgets
                  Row(
                    children: [
                      // Custom widget for subject information
                      const StudyInfoCard(
                        icon: Icons.menu_book,
                        title: 'Subjects',
                        value: '5',
                      ),

                      const SizedBox(width: 10),

                      // Custom widget for study hours
                      const StudyInfoCard(
                        icon: Icons.access_time,
                        title: 'Hours',
                        value: '3.5',
                      ),

                      const SizedBox(width: 10),

                      // Custom widget for completion status
                      StudyInfoCard(
                        icon: Icons.check_circle,
                        title: 'Completed',
                        value: provider.studySessions > 0
                            ? 'Yes'
                            : 'No',
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  // This Card displays the current Provider state
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        children: [
                          // Icon represents completed study sessions
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.task_alt,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary,
                            ),
                          ),

                          const SizedBox(width: 16),

                          // Displays the current Provider value
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Study Sessions',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${provider.studySessions} session completed',
                                ),
                              ],
                            ),
                          ),

                          // Displays the current number
                          Text(
                            '${provider.studySessions}',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Custom widget is reused for the main action button
                  StudyActionButton(
                    icon: Icons.check_circle_outline,
                    text: 'Complete Study Session',
                    onPressed: () {
                      // Provider method updates the shared state
                      provider.completeStudySession();
                    },
                  ),

                  const SizedBox(height: 12),

                  // Custom widget is reused for navigation
                  StudyActionButton(
                    icon: Icons.arrow_forward,
                    text: 'View Study Details',
                    onPressed: () {
                      // Navigator.push opens the Study Details Screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const StudyDetailsScreen(
                            studyName: "Today's Study Plan",
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  // Motivational message
                  Center(
                    child: Text(
                      'Keep going! You are doing well. 📚',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium,
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Study Details Screen reads the shared state from Provider
class StudyDetailsScreen extends StatelessWidget {
  final String studyName;

  const StudyDetailsScreen({
    super.key,
    this.studyName = 'Study Details',
  });

  @override
  Widget build(BuildContext context) {
    // Provider reads the shared study session state
    final provider = Provider.of<StudyProvider>(context);

    // Scaffold provides the basic structure of the Details Screen
    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Details'),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Custom card layout is used to display study details
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Icon(
                        Icons.school,
                        size: 70,
                        color: Theme.of(context)
                            .colorScheme
                            .primary,
                      ),

                      const SizedBox(height: 18),

                      Text(
                        studyName,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall,
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 24),

                      const Divider(),

                      const SizedBox(height: 12),

                      // Displays the study information
                      const ListTile(
                        leading: Icon(Icons.menu_book),
                        title: Text('Subjects'),
                        trailing: Text('5'),
                      ),

                      const ListTile(
                        leading: Icon(Icons.access_time),
                        title: Text('Study Hours'),
                        trailing: Text('3.5'),
                      ),

                      ListTile(
                        leading: const Icon(Icons.check_circle),
                        title: const Text('Completed'),
                        trailing: Text(
                          provider.studySessions > 0
                              ? 'Yes'
                              : 'No',
                        ),
                      ),

                      ListTile(
                        leading: const Icon(Icons.repeat),
                        title: const Text('Study Sessions'),
                        trailing: Text(
                          '${provider.studySessions}',
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ThemeData controls the appearance of this button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Navigator.pop returns to the previous screen
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back to Study Planner'),
                ),
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
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Application icon
                  Icon(
                    Icons.school,
                    size: 70,
                    color: Theme.of(context)
                        .colorScheme
                        .primary,
                  ),

                  const SizedBox(height: 20),

                  // Application name
                  Text(
                    'Study Planner',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall,
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'A simple app for planning daily '
                    'study activities and tracking '
                    'study progress.',
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 25),

                  // ThemeData provides the common button style
                  ElevatedButton.icon(
                    onPressed: () {
                      // Navigator.pop returns to the previous screen
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Back'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}