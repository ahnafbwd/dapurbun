// ignore_for_file: library_private_types_in_public_api

import 'package:dapurbun/screen/personalinfo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String iduser = '';
  String namalengkap = '';
  String jeniskelamin = '';
  String tanggallahir = '';
  String email = '';
  String nomertelepon = '';
  String password = '';

  Future<void> getDataFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      iduser = prefs.getString('iduser') ?? '';
      namalengkap = prefs.getString('namalengkap') ?? '';
      jeniskelamin = prefs.getString('jeniskelamin') ?? '';
      tanggallahir = prefs.getString('tanggallahir') ?? '';
      email = prefs.getString('email') ?? '';
      nomertelepon = prefs.getString('nomertelepon') ?? '';
      password = prefs.getString('password') ?? '';
    });
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('iduser', '');
    prefs.setString('namalengkap', '');
    prefs.setString('jeniskelamin', '');
    prefs.setString('tanggallahir', '');
    prefs.setString('email', '');
    prefs.setString('nomertelepon', '');
    prefs.setString('password', ''); // Hapus semua data di SharedPreferences
  }

  void loginFinished() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool("Finished login", false);
  }

  @override
  void initState() {
    super.initState();
    getDataFromSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            AssetImage('assets/profile_picture.jpg'),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            namalengkap,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            email,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Personal Information'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PersonalInformationPage(),
                    ),
                  );// Aksi ketika menu Personal Information diklik
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  logout();
                  loginFinished();
                  Navigator.pushReplacementNamed(
                      context, '/login'); // Aksi ketika menu Logout diklik
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
