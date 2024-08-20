import 'package:fakeapi/services/new_profile_service.dart';
import 'package:flutter/material.dart';

class CreateUserScreen extends StatefulWidget {
  @override
  _CreateUserScreenState createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _cityController = TextEditingController();
  final _streetController = TextEditingController();
  final _numberController = TextEditingController();
  final _zipcodeController = TextEditingController();
  final _latController = TextEditingController();
  final _longController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _loading = false;
  String? _error;

  void _createUser() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final newUser = await UserService().createUser(
        email: _emailController.text,
        username: _usernameController.text,
        password: _passwordController.text,
        firstName: _firstnameController.text,
        lastName: _lastnameController.text,
        city: _cityController.text,
        street: _streetController.text,
        number: int.parse(_numberController.text),
        zipcode: _zipcodeController.text,
        lat: _latController.text,
        long: _longController.text,
        phone: _phoneController.text,
      );
      print('User created: $newUser');
      Navigator.pop(context);
    } catch (e) {
      setState(() {
        _error = 'Kullanıcı oluşturma başarısız';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFEE0971),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Kullanıcı Oluştur',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEE0979), Color(0xFFFF6A00)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 30),
                  _buildTextField('Email', _emailController, Icons.email),
                  SizedBox(height: 20),
                  _buildTextField(
                      'Kullanıcı Adı', _usernameController, Icons.person),
                  SizedBox(height: 20),
                  _buildTextField('Şifre', _passwordController, Icons.lock,
                      isPassword: true),
                  SizedBox(height: 20),
                  _buildTextField(
                      'Ad', _firstnameController, Icons.text_fields),
                  SizedBox(height: 20),
                  _buildTextField(
                      'Soyad', _lastnameController, Icons.text_fields),
                  SizedBox(height: 20),
                  _buildTextField(
                      'Şehir', _cityController, Icons.location_city),
                  SizedBox(height: 20),
                  _buildTextField('Sokak', _streetController, Icons.streetview),
                  SizedBox(height: 20),
                  _buildTextField(
                      'Numara', _numberController, Icons.confirmation_number,
                      isNumber: true),
                  SizedBox(height: 20),
                  _buildTextField('Posta Kodu', _zipcodeController,
                      Icons.local_post_office),
                  SizedBox(height: 20),
                  _buildTextField('Enlem', _latController, Icons.map),
                  SizedBox(height: 20),
                  _buildTextField('Boylam', _longController, Icons.map),
                  SizedBox(height: 20),
                  _buildTextField('Telefon', _phoneController, Icons.phone),
                  SizedBox(height: 20),
                  if (_loading)
                    CircularProgressIndicator()
                  else
                    ElevatedButton(
                      onPressed: _createUser,
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: Colors.white,
                        foregroundColor: Color(0xFF00C6FF),
                      ),
                      child: Text(
                        'Kayıt Ol',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  if (_error != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        _error!,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String hintText,
    TextEditingController controller,
    IconData icon, {
    bool isPassword = false,
    bool isNumber = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        prefixIcon: Icon(icon, color: Colors.white),
        filled: true,
        fillColor: Colors.white.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
