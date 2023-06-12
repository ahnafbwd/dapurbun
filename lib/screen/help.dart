// ignore_for_file: deprecated_member_use, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key}); // Ganti dengan URL website Anda

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Pusat Bantuan',
          style: TextStyle(
            fontStyle: FontStyle.normal,
            color: Colors.green,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/csdapurbun.png', // Ganti dengan path gambar ilustrasi customer service Anda
              width: 300,
              height: 300,
            ),
            const SizedBox(height: 2),
            const Text(
              'Hai, ada yang bisa kami bantu?',
              style: TextStyle(
                color: Colors.black,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                leading: const Icon(
                  Icons.message,
                  color: Colors.green,
                ),
                title: const Text('Hubungi Kami'),
                onTap: () {
                  String phoneNumber =
                      '6281934342238'; // Nomor telepon yang ingin Anda tuju
                  String message =
                      'Halo, dengan CS Dapur Bunda?'; // Pesan yang ingin Anda kirim

                  final link = WhatsAppUnilink(
                    phoneNumber: phoneNumber,
                    text: message,
                  );

                  launch('$link');
                },
              ),
            ),
            const SizedBox(height: 20),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                leading: const Icon(Icons.language, color: Colors.green),
                title: const Text('Kunjungi Website'),
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WebViewPage(
                          url: 'https://dapurbun.000webhostapp.com/'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WebViewPage extends StatefulWidget {
  final String url;

  const WebViewPage({Key? key, required this.url}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
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
          'Pusat Bantuan',
          style: TextStyle(
            fontStyle: FontStyle.normal,
            color: Colors.green,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
