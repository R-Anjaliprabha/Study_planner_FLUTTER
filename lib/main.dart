void main() {
  // Basic details used in the study planner
  String studentName = "Anjali";
  int subjects = 5;
  double studyHours = 3.5;
  bool studyCompleted = true;

  // Display the study details in the terminal
  print("Study Planner");
  print("Student Name: $studentName");
  print("Number of Subjects: $subjects");
  print("Study Hours: $studyHours");
  print("Study Completed: $studyCompleted");

  // Calculate the total study time in minutes
  int totalMinutes = calculateMinutes(3);
  print("Today's Study Time: $totalMinutes minutes");

  // Check whether today's study goal is completed
  if (studyCompleted) {
    print("Great! Today's study goal is completed.");
  } else {
    print("Complete today's study goal.");
  }
}

// This function converts study hours into minutes
int calculateMinutes(int hours) {
  return hours * 60;
}