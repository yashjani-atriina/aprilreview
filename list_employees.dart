import 'package:aprilreview/ApiIntegration/api_function.dart';
import 'package:aprilreview/ApiIntegration/employee_models.dart';
import 'package:aprilreview/db.dart';
import 'package:aprilreview/online_code/disp_employee_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListEmployees extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListEmployees();
  }
}

class _ListEmployees extends State<ListEmployees> {
  List<Map> slist = [];
  MyDb mydb = new MyDb();

  @override
  void initState() {
    mydb.open();
    getdata();
    super.initState();
  }

  getdata() {
    Future.delayed(const Duration(milliseconds: 500), () async {
      //use delay min 500 ms, because database takes time to initilize.
      slist = await mydb.db.rawQuery('SELECT * FROM employees');

      setState(() {}); //refresh UI after getting data from table.
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: "Tab 1"),
              Tab(text: "Tab 2"),
              Tab(text: "API"),
            ],
          ),
          title: const Text('Employees Records'),
        ),
        body: TabBarView(
          children: [
            GetEmployeesScreen(),
            SingleChildScrollView(
              child: Container(
                child: slist.isEmpty
                    ? const Text("No employees to show.")
                    : Column(
                        children: slist.map((empone) {
                          return Card(
                            child: ListTile(
                              leading: const Icon(Icons.people),
                              title: Text(empone["fname"]),
                              subtitle: Text(
                                  "Mob No:${empone["mobileno"]}, L Name: " +
                                      empone["lname"]),
                              trailing: Wrap(
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      await mydb.db.rawDelete(
                                          "DELETE FROM employees WHERE mobileno = ?",
                                          [empone["mobileno"]]);
                                      //delete employee data with roll no.
                                      print("Data Deleted");
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text("Employee's Data Deleted"),
                                        ),
                                      );
                                      getdata();
                                    },
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                  )
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
              ),
            ),
            FutureBuilder<Employee_Api_Data>(
              future: getHttp(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data!.data![index].employeeName!),
                        subtitle:
                            Text(snapshot.data!.data![index].employeeName!),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                        SizedBox(height: 10),
                        Text('Please check your connection'),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
