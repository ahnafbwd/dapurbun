import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalInformationPage extends StatefulWidget {
  const PersonalInformationPage({Key? key}) : super(key: key);

  @override
  _PersonalInformationPageState createState() => _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
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

  @override
  void initState() {
    super.initState();
    getDataFromSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Informasi Akun',
          style: TextStyle(
            fontStyle: FontStyle.normal,
            color: Colors.green,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Nama Lengkap: ',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          namalengkap,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Jenis Kelamin: ',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          jeniskelamin,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Tanggal Lahir: ',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          tanggallahir,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Email: ',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          email,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Nomor Telepon: ',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          nomertelepon,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Password: ',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          password,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
