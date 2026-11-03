class Student {
  final int? id;
  final String name;
  final String regno;
  final double cgpa;

  Student({
    this.id,
    required this.name,
    required this.regno,
    required this.cgpa,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'regno': regno,
      'cgpa': cgpa,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'] as int?,
      name: map['name'] as String,
      regno: map['regno'] as String,
      cgpa: (map['cgpa'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
