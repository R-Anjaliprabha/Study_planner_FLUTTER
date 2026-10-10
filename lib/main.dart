import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Stores the details entered for one subject.
class StudySubject {
  final String name;
  final double studyHours;
  final double targetHours;
  final String description;
  final Color color;

  const StudySubject({
    required this.name,
    required this.studyHours,
    required this.targetHours,
    required this.description,
    required this.color,
  });
}

// Experiment 5(B): Provider manages shared study data.
class StudyProvider extends ChangeNotifier {
  final List<StudySubject> _subjects = [];
  int studySessions = 0;

  List<StudySubject> get subjects => List.unmodifiable(_subjects);

  int get subjectCount => _subjects.length;

  double get totalStudyHours =>
      _subjects.fold<double>(0.0, (total, subject) => total + subject.studyHours);

  double get totalTargetHours =>
      _subjects.fold<double>(0.0, (total, subject) => total + subject.targetHours);

  void addSubject(StudySubject subject) {
    _subjects.add(subject);
    notifyListeners();
  }

  void completeStudySession() {
    studySessions++;
    notifyListeners();
  }
}

// Experiment 6: Reusable information card.
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
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Column(
            children: [
              Icon(icon, size: 26),
              const SizedBox(height: 8),
              Text(title, textAlign: TextAlign.center),
              const SizedBox(height: 4),
              Text(
                value,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Experiment 6: Reusable action button.
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Study Planner',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
        appBarTheme: const AppBarTheme(centerTitle: false, elevation: 0),
        cardTheme: CardTheme(
          elevation: 2,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        textTheme: const TextTheme(
          headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          bodyMedium: TextStyle(fontSize: 14),
        ),
      ),
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

  Future<void> _openAddSubject(BuildContext context) async {
    final subject = await Navigator.push<StudySubject>(
      context,
      MaterialPageRoute(builder: (_) => const AddSubjectScreen()),
    );

    if (subject != null && context.mounted) {
      context.read<StudyProvider>().addSubject(subject);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${subject.name} added successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StudyProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Study Planner',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.school, color: Colors.white, size: 40),
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
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Navigator.pushNamed(context, '/'),
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Study Details'),
              onTap: () => Navigator.pushNamed(context, '/details'),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () => Navigator.pushNamed(context, '/about'),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'images/studying.jpg',
                  height: 210,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 210,
                    width: double.infinity,
                    color: Colors.indigo.shade300,
                  ),
                ),
                Container(
                  height: 210,
                  width: double.infinity,
                  color: Colors.black38,
                ),
                const Column(
                  children: [
                    Icon(Icons.menu_book, color: Colors.white, size: 42),
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
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today's Study Plan",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 6),
                  const Text('Add your subjects and track your study hours.'),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      StudyInfoCard(
                        icon: Icons.menu_book,
                        title: 'Subjects',
                        value: '${provider.subjectCount}',
                      ),
                      const SizedBox(width: 10),
                      StudyInfoCard(
                        icon: Icons.access_time,
                        title: 'Study Hours',
                        value: provider.totalStudyHours.toStringAsFixed(1),
                      ),
                      const SizedBox(width: 10),
                      StudyInfoCard(
                        icon: Icons.check_circle,
                        title: 'Sessions',
                        value: '${provider.studySessions}',
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.task_alt,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Study Sessions',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text('Keep recording each completed session.'),
                              ],
                            ),
                          ),
                          Text(
                            '${provider.studySessions}',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  StudyActionButton(
                    icon: Icons.check_circle_outline,
                    text: 'Complete Study Session',
                    onPressed: () => provider.completeStudySession(),
                  ),
                  const SizedBox(height: 12),
                  StudyActionButton(
                    icon: Icons.arrow_forward,
                    text: 'View Study Details',
                    onPressed: () => Navigator.pushNamed(context, '/details'),
                  ),
                  const SizedBox(height: 12),
                  StudyActionButton(
                    icon: Icons.add_circle_outline,
                    text: 'Add New Subject',
                    onPressed: () => _openAddSubject(context),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'My Subjects',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  if (provider.subjects.isEmpty)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Icon(
                              Icons.menu_book_outlined,
                              size: 42,
                              color: Colors.indigo.shade300,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'No subjects added yet',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Tap “Add New Subject” to enter your subject name and study hours.',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ...provider.subjects.map(
                      (subject) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SubjectCard(subject: subject),
                      ),
                    ),
                  const SizedBox(height: 12),
                  Center(
                    child: Text(
                      'Keep going! You are doing well. 📚',
                      style: Theme.of(context).textTheme.bodyMedium,
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

class SubjectCard extends StatelessWidget {
  final StudySubject subject;

  const SubjectCard({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    final progress = subject.targetHours <= 0
        ? 0.0
        : (subject.studyHours / subject.targetHours).clamp(0.0, 1.0).toDouble();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: subject.color.withOpacity(0.15),
              child: Icon(Icons.menu_book, color: subject.color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(subject.name, style: Theme.of(context).textTheme.titleMedium),
                  if (subject.description.isNotEmpty) ...[
                    const SizedBox(height: 3),
                    Text(
                      subject.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: progress,
                    color: subject.color,
                    backgroundColor: subject.color.withOpacity(0.12),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${subject.studyHours.toStringAsFixed(1)} / ${subject.targetHours.toStringAsFixed(1)} hours',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Experiment 7(A): Form that collects subject information.
class AddSubjectScreen extends StatefulWidget {
  const AddSubjectScreen({super.key});

  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController subjectNameController = TextEditingController();
  final TextEditingController studyHoursController = TextEditingController();
  final TextEditingController targetHoursController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Color selectedColor = Colors.indigo;

  @override
  void dispose() {
    subjectNameController.dispose();
    studyHoursController.dispose();
    targetHoursController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void _saveSubject() {
    // Basic required-field checks keep empty values out of the subject list.
    if (!_formKey.currentState!.validate()) return;

    final subject = StudySubject(
      name: subjectNameController.text.trim(),
      studyHours: double.parse(studyHoursController.text.trim()),
      targetHours: double.parse(targetHoursController.text.trim()),
      description: descriptionController.text.trim(),
      color: selectedColor,
    );

    Navigator.pop(context, subject);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Subject')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.menu_book_rounded, size: 48, color: Colors.indigo),
                  const SizedBox(height: 12),
                  Text('Subject Details', style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 6),
                  const Text('Enter the details for your new study subject.'),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: subjectNameController,
                    decoration: const InputDecoration(
                      labelText: 'Subject Name',
                      hintText: 'e.g. Mathematics',
                      prefixIcon: Icon(Icons.book_outlined),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a subject name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    controller: studyHoursController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Study Hours',
                      hintText: 'e.g. 2',
                      prefixIcon: Icon(Icons.access_time),
                    ),
                    validator: (value) {
                      final hours = double.tryParse(value?.trim() ?? '');
                      if (hours == null || hours < 0) {
                        return 'Enter a valid number of hours';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    controller: targetHoursController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Target Hours',
                      hintText: 'e.g. 5',
                      prefixIcon: Icon(Icons.flag_outlined),
                    ),
                    validator: (value) {
                      final hours = double.tryParse(value?.trim() ?? '');
                      if (hours == null || hours <= 0) {
                        return 'Target hours must be greater than zero';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    controller: descriptionController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Description (Optional)',
                      hintText: 'Add a short note about this subject',
                      prefixIcon: Icon(Icons.notes),
                      alignLabelWithHint: true,
                    ),
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    'Choose Subject Color',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    children: [
                      Colors.indigo,
                      Colors.pink,
                      Colors.teal,
                      Colors.orange,
                      Colors.blue,
                    ].map((color) {
                      return GestureDetector(
                        onTap: () => setState(() => selectedColor = color),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: color,
                          child: selectedColor == color
                              ? const Icon(Icons.check, color: Colors.white)
                              : null,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _saveSubject,
                      icon: const Icon(Icons.save_outlined),
                      label: const Text('Save Subject'),
                    ),
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

class StudyDetailsScreen extends StatelessWidget {
  const StudyDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StudyProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Study Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Icon(
                      Icons.school,
                      size: 70,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Your Study Plan',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.menu_book),
                      title: const Text('Subjects'),
                      trailing: Text('${provider.subjectCount}'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.access_time),
                      title: const Text('Total Study Hours'),
                      trailing: Text(provider.totalStudyHours.toStringAsFixed(1)),
                    ),
                    ListTile(
                      leading: const Icon(Icons.flag_outlined),
                      title: const Text('Target Hours'),
                      trailing: Text(provider.totalTargetHours.toStringAsFixed(1)),
                    ),
                    ListTile(
                      leading: const Icon(Icons.check_circle),
                      title: const Text('Completed Sessions'),
                      trailing: Text('${provider.studySessions}'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Subjects', style: Theme.of(context).textTheme.titleLarge),
            ),
            const SizedBox(height: 12),
            if (provider.subjects.isEmpty)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Text('No subjects added yet. Add a subject from the home screen.'),
                ),
              )
            else
              ...provider.subjects.map(
                (subject) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SubjectCard(subject: subject),
                ),
              ),
            const SizedBox(height: 24),
            StudyActionButton(
              icon: Icons.arrow_back,
              text: 'Back to Study Planner',
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.school,
                    size: 70,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 20),
                  Text('Study Planner', style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 10),
                  const Text(
                    'A simple app for adding subjects, planning study hours, and tracking study progress.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
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