import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  final String _baseUrl = 'https://fakestoreapi.com';

  Future<Map<String, dynamic>> createUser({
    required String email,
    required String username,
    required String password,
    required String firstName,
    required String lastName,
    required String city,
    required String street,
    required int number,
    required String zipcode,
    required String lat,
    required String long,
    required String phone,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'username': username,
        'password': password,
        'name': {
          'firstname': firstName,
          'lastname': lastName,
        },
        'address': {
          'city': city,
          'street': street,
          'number': number,
          'zipcode': zipcode,
          'geolocation': {
            'lat': lat,
            'long': long,
          },
        },
        'phone': phone,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create user');
    }
  }
}