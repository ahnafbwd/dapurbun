// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class OrderDetailPage extends StatefulWidget {
  final String idpemesanan;
  final String idrincianPesanan;
  final String idpembayaran;
  final String kodepesanan;
  final String tanggalbooking;
  final String waktubooking;
  final String totalpesanan;
  final String catatan;
  final String namapenerima;
  final String nomerteleponpenerima;
  final String alamatpengantaran;
  final String biayapengantaran;
  final String totalpembayaran;
  final String statuspesanan;

  const OrderDetailPage({
    Key? key,
    required this.idpemesanan,
    required this.idrincianPesanan,
    required this.idpembayaran,
    required this.kodepesanan,
    required this.tanggalbooking,
    required this.waktubooking,
    required this.totalpesanan,
    required this.catatan,
    required this.namapenerima,
    required this.nomerteleponpenerima,
    required this.alamatpengantaran,
    required this.biayapengantaran,
    required this.totalpembayaran,
    required this.statuspesanan,
  }) : super(key: key);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  List<Map<String, dynamic>> rincianPesanan = [];
  bool isLoading = true;
/* 
  @override
  void initState() {
    super.initState();
    fetchData();
  } */

  /* Future<void> fetchData() async {
    try {
      const url =
          'https://dapurbun.000webhostapp.com/API/pesanan/tampilrincian.php';
      final response = await http.post(Uri.parse(url), body: {
        'id_rincian_pesanan': widget.idrincianPesanan,
      });

      final responseData = json.decode(response.body);

      if (responseData['status'] == 'success') {
        setState(() {
          rincianPesanan =
              List<Map<String, dynamic>>.from(responseData['data']);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print(responseData['message']);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(responseData['message']),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Terjadi kesalahan: $error'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Detail Pesanan',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Card(
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Detail Pesanan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Kode Pesanan: ${widget.kodepesanan}'),
                  subtitle: Text('Tanggal Booking: ${widget.tanggalbooking}'),
                ),
                ListTile(
                  title: Text('Waktu Booking: ${widget.waktubooking}'),
                  subtitle: Text('Total Pesanan: ${widget.totalpesanan}'),
                ),
                ListTile(
                  title: Text('Catatan: ${widget.catatan}'),
                  subtitle: Text('Nama Penerima: ${widget.namapenerima}'),
                ),
                ListTile(
                  title: Text(
                      'Nomor Telepon Penerima: ${widget.nomerteleponpenerima}'),
                  subtitle:
                      Text('Alamat Pengantaran: ${widget.alamatpengantaran}'),
                ),
                ListTile(
                  title: Text('Biaya Pengantaran: ${widget.biayapengantaran}'),
                  subtitle: Text('Total Pembayaran: ${widget.totalpembayaran}'),
                ),
                ListTile(
                  title: Text('Status Pesanan: ${widget.statuspesanan}'),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'Pembayaran Dapat Dilakukan Pada:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Melalui Bank:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 2,)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Bank BRI : ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 2,),
                              Text(
                                '32189023188',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                            ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Bank BCA : ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 2,),
                              Text(
                                '100129732489',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Melalui E-Wallet:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 2,)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Shopeepay : ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 2,),
                              Text(
                                '2190873091738',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text(
              'Kirim Bukti Pembayaran',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
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
          const SizedBox(height: 12,)
        ]),
      ),
    );
  }
}
