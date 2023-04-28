import 'package:aprilreview/db.dart';
import 'package:aprilreview/list_employees.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddEmployee extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddEmployee();
  }
}

class _AddEmployee extends State<AddEmployee> {
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController mobileno = TextEditingController();
  TextEditingController email = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  //test editing controllers for form

  MyDb mydb = new MyDb(); //mydb new object from db.dart

  @override
  void initState() {
    mydb.open(); //initilization database
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee Employee"),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: fname,
                decoration: InputDecoration(
                  hintText: "Employee Name",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'First Name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: lname,
                decoration: InputDecoration(
                  hintText: "Last Name.",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Last Name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: mobileno,
                decoration: InputDecoration(
                  hintText: "Mobile No:",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mobile No';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                  hintText: "Email:",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    mydb.db.rawInsert(
                        "INSERT INTO employees (fname, lname, email, mobileno) VALUES (?, ?, ?, ?);",
                        [
                          fname.text,
                          lname.text,
                          email.text,
                          mobileno.text
                        ]); //add employee from form to database

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("New Employee Added")));
                    //show snackbar message after adding Employee

                    fname.text = "";
                    lname.text = "";
                    mobileno.text = "";
                    email.text = "";
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ListEmployees()),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
