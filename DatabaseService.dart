import 'package:aprilreview/online_code/employee_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference _employeesCollection =
      FirebaseFirestore.instance.collection('employees');

  Future<void> addEmployee(Employee employee) async {
    await _employeesCollection.doc(employee.id).set(employee.toMap());
  }

  Future<void> addEmployeeWithTextFields(
      String fname, String lname, String email, String mobileno) async {
    final employee = Employee(
      id: DateTime.now().toString(),
      fname: fname,
      lname: lname,
      email: email,
      mobileno: mobileno,
    );
    await addEmployee(employee);
  }

  Stream<List<Employee>> getEmployees() {
    return _employeesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Employee(
          id: doc.id,
          fname: doc.get('fname'),
          lname: doc.get('lname'),
          email: doc.get('email'),
          mobileno: doc.get('mobileno'),
        );
      }).toList();
    });
  }

  Future<void> deleteEmployee(String id) async {
    await _employeesCollection.doc(id).delete();
  }
}
