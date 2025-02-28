import 'package:flutter/foundation.dart';

class ExchangeProvider with ChangeNotifier {
  List<Student> _students = [];

  List<Student> get students => _students;

  void addStudent(Map<String, String> studentData) {
    final newStudent = Student(
      name: studentData['name']!,
      university: studentData['university']!,
      country: studentData['country']!,
    );
    _students.add(newStudent);
    print('Added student: ${newStudent.name}, Total: ${_students.length}');
    notifyListeners();
  }

  void updateStudent(Student oldStudent, Map<String, String> newData) {
    final index = _students.indexOf(oldStudent);
    if (index != -1) {
      _students[index] = Student(
        name: newData['name']!,
        university: newData['university']!,
        country: newData['country']!,
      );
      print('Updated student at index $index: ${newData['name']}');
      notifyListeners();
    } else {
      print('Student not found for update: ${oldStudent.name}');
    }
  }

  void removeStudent(Student student) {
    _students.remove(student);
    print('Removed student: ${student.name}, Total: ${_students.length}');
    notifyListeners();
  }
}

class Student {
  final String name;
  final String university;
  final String country;

  Student({
    required this.name,
    required this.university,
    required this.country,
  });

  @override
  bool operator ==(Object other) =>
      other is Student &&
      name == other.name &&
      university == other.university &&
      country == other.country;

  @override
  int get hashCode => Object.hash(name, university, country);

  @override
  String toString() => 'Student(name: $name, university: $university, country: $country)';
}
