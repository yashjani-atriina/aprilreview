import 'package:aprilreview/list_employees.dart';
import 'package:aprilreview/online_code/DatabaseService.dart';
import 'package:aprilreview/online_code/disp_employee_data.dart';
import 'package:flutter/material.dart';

class AddEmployeeScreen extends StatefulWidget {
  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobilenoController = TextEditingController();
  final _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee with firebase'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _fnameController,
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lnameController,
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter last name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _mobilenoController,
                decoration: InputDecoration(labelText: 'Mobile No'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a mobile no';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final fname = _fnameController.text;
                    final lname = _lnameController.text;
                    final email = _emailController.text;
                    final mobileno = _mobilenoController.text;
                    await _databaseService.addEmployeeWithTextFields(
                        fname, lname, email, mobileno);
                  }
                },
                child: Text('Add Employee'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListEmployees(),
                    ),
                  );
                },
                child: const Text("Show List"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
