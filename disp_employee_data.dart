import 'package:aprilreview/online_code/DatabaseService.dart';
import 'package:aprilreview/online_code/employee_model.dart';
import 'package:flutter/material.dart';

class GetEmployeesScreen extends StatelessWidget {
  const GetEmployeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Employee>>(
        stream: DatabaseService().getEmployees(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final employees = snapshot.data!;

          if (employees.isEmpty) {
            return const Center(
              child: Text('No employees found'),
            );
          }

          return ListView.builder(
            itemCount: employees.length,
            itemBuilder: (context, index) {
              final employee = employees[index];
              return Card(
                elevation: 1.0,
                child: ListTile(
                  leading: const Icon(Icons.people),
                  title: Text(employee.fname),
                  subtitle: Text(employee.lname),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      await DatabaseService().deleteEmployee(employee.id);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
