void main() {
  String studentName = "Anjali";
  int subjects = 5;
  double studyHours = 3.5;
  bool studyCompleted = true;

  print("Study Planner");
  print("Student Name: $studentName");
  print("Number of Subjects: $subjects");
  print("Study Hours: $studyHours");
  print("Study Completed: $studyCompleted");

  int totalMinutes = calculateMinutes(3);
  print("Today's Study Time: $totalMinutes minutes");

  if (studyCompleted) {
    print("Great! Today's study goal is completed.");
  } else {
    print("Complete today's study goal.");
  }
}

int calculateMinutes(int hours) {
  return hours * 60;
}