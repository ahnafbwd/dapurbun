import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String profilePictureUrl = 'https://example.com/profile_picture.jpg';
  final String username = 'Nama Pengguna';
  final String phoneNumber = 'Nomor Telepon';
  final String editProfileButtonLabel = 'Edit Profil';
  final String addressButtonLabel = 'Alamat Tersimpan';
  final String notificationButtonLabel = 'Pengaturan Notifikasi';
  final String termsButtonLabel = 'Syarat dan Ketentuan';
  final String reviewButtonLabel = 'Ulas Aplikasi Dapur Bunda';
  final String logoutButtonLabel = 'Keluar';

  const ProfilePage({Key? key}) : super(key: key);

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
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/profile_picture.jpg'),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'John Doe',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'john.doe@example.com',
                            style: TextStyle(
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
                  // Aksi ketika menu Personal Information diklik
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.payment),
                title: const Text('Payment Methods'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Aksi ketika menu Payment Methods diklik
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Aksi ketika menu Settings diklik
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  // Aksi ketika menu Logout diklik
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
