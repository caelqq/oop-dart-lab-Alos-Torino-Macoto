import 'dart:io';

// ---------- Person (base class) ----------
class Person {
  String _name;
  int _age;

  Person(this._name, this._age);

  String get name => _name;
  int get age => _age;

  set age(int value) {
    if (value < 0) {
      throw ArgumentError('Age cannot be negative');
    }
    _age = value;
  }

  String introduce() {
    return "Hi, I'm $_name, $_age years old.";
  }
}

// ---------- Student ----------
class Student extends Person {
  String _course;

  Student(String name, int age, this._course) : super(name, age);

  String get course => _course;

  @override
  String introduce() {
    return "Hi, I'm $name, $age years old, studying $_course.";
  }
}

// ---------- Teacher ----------
class Teacher extends Person {
  String _subject;

  Teacher(String name, int age, this._subject) : super(name, age);

  String get subject => _subject;

  @override
  String introduce() {
    return "Hi, I'm $name, $age years old, teaching $_subject.";
  }
}

// ---------- School ----------
class School {
  final List<Person> _people = [];

  void addPerson(Person p) {
    _people.add(p);
  }

  void introduceAll() {
    for (var person in _people) {
      print(person.introduce());
    }
  }
  
  int countStudents() => _people.whereType<Student>().length;

  int countTeachers() => _people.whereType<Teacher>().length;
  
}



// ---------- Input helpers ----------

// Reads a non-empty string, re-prompting until valid.
String readNonEmptyString(String prompt) {
  while (true) {
    stdout.write(prompt);
    String? input = stdin.readLineSync();
    if (input != null && input.trim().isNotEmpty) {
      return input.trim();
    }
    print('  This field cannot be empty. Please try again.');
  }
}

// Reads a valid whole number, re-prompting until valid.
int readInt(String prompt) {
  while (true) {
    stdout.write(prompt);
    String? input = stdin.readLineSync();
    if (input != null) {
      int? value = int.tryParse(input.trim());
      if (value != null) {
        return value;
      }
    }
    print('  Please enter a valid whole number.');
  }
}

// Reads a valid, non-negative age, re-prompting until valid.
int readAge(String prompt) {
  while (true) {
    int value = readInt(prompt);
    if (value >= 0) {
      return value;
    }
    print('  Age cannot be negative. Please try again.');
  }
}

// ---------- Main program ----------
void main() {
  print('=== School Personnel Management ===');
  School school = School();

  int studentCount = readInt('How many students will you add? ');
  print('');

  for (int i = 1; i <= studentCount; i++) {
    print('-- Student #$i --');
    String name = readNonEmptyString('  Name: ');
    int age = readAge('  Age: ');
    String course = readNonEmptyString('  Course: ');
    school.addPerson(Student(name, age, course));
    print('');
  }

  int teacherCount = readInt('How many teachers will you add? ');
  print('');

  for (int i = 1; i <= teacherCount; i++) {
    print('-- Teacher #$i --');
    String name = readNonEmptyString('  Name: ');
    int age = readAge('  Age: ');
    String subject = readNonEmptyString('  Subject: ');
    school.addPerson(Teacher(name, age, subject));
    print('');
  }

  //print('=== School Roster ===');
  //school.introduceAll();
  
  print('=== School Roster ===');
  print('Total people: ${school.countStudents() + school.countTeachers()}');
  
}