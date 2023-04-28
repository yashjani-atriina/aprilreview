class Employee {
  final String id;
  final String fname;
  final String lname;
  final String email;
  final String mobileno;

  Employee({
    required this.id,
    required this.fname,
    required this.lname,
    required this.email,
    required this.mobileno,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fname': fname,
      'lname': lname,
      'email': email,
      'mobileno': mobileno,
    };
  }
}
