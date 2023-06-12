// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _webViewKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    // Aktifkan WebView pada inisialisasi halaman
    // ignore: prefer_conditional_assignment, unnecessary_null_comparison
    if (WebView.platform == null) {
      // Cek apakah WebView sudah diinisialisasi
      WebView.platform = SurfaceAndroidWebView();
      // Jika belum, inisialisasi WebView pada platform Android
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tripay Flutter WebView'),
      ),
      body: SafeArea(
        child: WebView(
          key: _webViewKey,
          initialUrl: 'https://url_tripay_anda',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            // Lakukan sesuatu setelah WebView dibuat
          },
          onPageFinished: (String url) {
            if (url.contains('https://url_pemrosesan_selesai')) {
              // Lakukan tindakan setelah proses pembayaran selesai
              print('Pembayaran selesai');
            }
          },
        ),
      ),
    );
  }
}
