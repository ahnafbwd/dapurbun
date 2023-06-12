// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _namaLengkapController = TextEditingController();
  String? _jenisKelamin;
  DateTime? _selectedDate;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nomerTeleponController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> sendDataToAPI() async {
    var url =
        Uri.parse('https://dapurbun.000webhostapp.com/API/akun/register.php');

    var requestBody = {
      'nama_lengkap': _namaLengkapController.text,
      'jenis_kelamin': _jenisKelamin,
      'tanggal_lahir': DateFormat('yyyy-MM-dd').format(_selectedDate!),
      'email': _emailController.text,
      'nomer_telepon': _nomerTeleponController.text,
      'password': _passwordController.text,
    };

    var response = await http.post(url, body: requestBody);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      if (responseData['status'] == 'success') {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Registrasi Berhasil'),
            content: Text(responseData['message']),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/login'),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Registrasi Gagal'),
            content: Text(responseData['message']),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Terjadi Kesalahan'),
          content: const Text('Terjadi kesalahan saat menghubungi API.'),
          actions: <Widget>[
            Center(
              child: TextButton(
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Registrasi',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade800,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                TextField(
                  controller: _namaLengkapController,
                  decoration: const InputDecoration(
                      labelText: 'Nama Lengkap',
                      floatingLabelStyle: TextStyle(color: Colors.green),
                      hintStyle: TextStyle(color: Colors.green),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                ),
                const SizedBox(height: 12.0),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                      labelText: 'Jenis Kelamin',
                      floatingLabelStyle: TextStyle(color: Colors.green),
                      hintStyle: TextStyle(color: Colors.green),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                  value: _jenisKelamin,
                  hint: const Text('Pilih Jenis Kelamin'),
                  items: <String>['Laki-laki', 'Perempuan']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _jenisKelamin = newValue;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                ListTile(
                  title: const Text('Tanggal Lahir'),
                  subtitle: Text(
                    _selectedDate == null
                        ? 'Pilih tanggal'
                        : DateFormat('dd MMMM yyyy').format(_selectedDate!),
                  ),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () {
                    _selectDate(context);
                  },
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      labelText: 'Email',
                      floatingLabelStyle: TextStyle(color: Colors.green),
                      hintStyle: TextStyle(color: Colors.green),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _nomerTeleponController,
                  decoration: const InputDecoration(
                      labelText: 'Nomer Telepon',
                      floatingLabelStyle: TextStyle(color: Colors.green),
                      hintStyle: TextStyle(color: Colors.green),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      labelText: 'Password',
                      floatingLabelStyle: TextStyle(color: Colors.green),
                      hintStyle: TextStyle(color: Colors.green),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green)),
                  onPressed: () {
                    sendDataToAPI();
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sudah punya akun?',
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: const Text(
                        "Login Sekarang",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
