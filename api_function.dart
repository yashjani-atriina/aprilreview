import 'package:aprilreview/ApiIntegration/employee_models.dart';
import 'package:dio/dio.dart';

Future<Employee_Api_Data> getHttp() async {
  var newsResponse =
      await Dio().get('https://dummy.restapiexample.com/api/v1/employees');

  if (newsResponse.statusCode == 200) {
    return Employee_Api_Data.fromJson(newsResponse.data);
  } else {
    throw Exception('Failed to load album');
  }
}
