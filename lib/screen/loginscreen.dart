// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    const String apiUrl =
        'https://dapurbun.000webhostapp.com//API/akun/login.php'; // Ganti dengan URL API login.php

    final response = await http.post(Uri.parse(apiUrl), body: {
      'email': emailController.text,
      'password': passwordController.text,
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['status'] == 'success') {
        // Login berhasil
        // Simpan data pengguna ke dalam shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('iduser', data['data']['id_user'] ?? '');
        prefs.setString('namalengkap', data['data']['nama_lengkap'] ?? '');
        prefs.setString('jeniskelamin', data['data']['jenis_kelamin'] ?? '');
        prefs.setString('tanggallahir', data['data']['tanggal_lahir'] ?? '');
        prefs.setString('email', data['data']['email'] ?? '');
        prefs.setString('nomertelepon', data['data']['nomer_telepon'] ?? '');
        prefs.setString('password', data['data']['password'] ?? '');
        loginFinished();
        // Navigasi ke halaman utama
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Login gagal
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Login Gagal'),
              content: const Text('Email atau password salah.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      // Terjadi kesalahan saat koneksi ke API
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Kesalahan'),
            content: const Text('Terjadi kesalahan saat koneksi ke server.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    // Dispose controllers
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'assets/images/LogoDapurBundaHijauKuning.png',
                  height: 100.0,
                ),
                const SizedBox(height: 30.0),
                const Text(
                  'Selamat Datang!',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30.0),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      labelText: 'Email',
                      floatingLabelStyle: TextStyle(color: Colors.green),
                      hintStyle: TextStyle(color: Colors.green),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                ),
                const SizedBox(height: 12.0),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: 'Password',
                      floatingLabelStyle: TextStyle(color: Colors.green),
                      hintStyle: TextStyle(color: Colors.green),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green)),
                  onPressed: () {
                    login();
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10.0),
                TextButton(
                  onPressed: () {
                    // Teks Lupa Password ditekan
                  },
                  child: const Text(
                    'Lupa Password?',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                const SizedBox(height: 20.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Belum punya akun?',
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/register');
                      },
                      child: const Text(
                        "Daftar Sekarang",
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

  void loginFinished() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool("Finished login", true);
  }
}
