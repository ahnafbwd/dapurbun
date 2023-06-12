import 'package:dapurbun/screen/orderdetails.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<dynamic> pemesananData = [];
  String idUser = '';

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      idUser = prefs.getString('iduser') ?? '';
    });

    Uri url = Uri.parse(
        'https://dapurbun.000webhostapp.com/API/pesanan/tampilpesanan.php?id_user=$idUser');
    final response = await http.get(url);

    // Memeriksa status response
    if (response.statusCode == 200) {
      // Mengubah response body menjadi list data pemesanan
      var data = jsonDecode(response.body);
      setState(() {
        pemesananData = data['data'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (pemesananData.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text(
            'Tidak ada data dalam riwayat pesanan',
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Pesanan',
            style: TextStyle(
              fontStyle: FontStyle.normal,
              color: Colors.green,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: pemesananData.length,
            itemBuilder: (context, index) {
              final pemesanan = pemesananData[index];
              final idpemesanan = pemesanan['id_pemesanan'];
              final idrincianPesanan = pemesanan['id_rincian_pesanan'];
              final idpembayaran = pemesanan['id_pembayaran'];
              final kodepesanan = pemesanan['kode_pesanan'];
              final tanggalbooking = pemesanan['tanggal_booking'];
              final waktubooking = pemesanan['waktu_booking'];
              final totalpesanan = pemesanan['total_pesanan'];
              final catatan = pemesanan['catatan'];
              final namapenerima = pemesanan['nama_penerima'];
              final nomerteleponpenerima = pemesanan['nomer_telepon_penerima'];
              final alamatpengantaran = pemesanan['alamat_pengantaran'];
              final biayapengantaran = pemesanan['biaya_pengantaran'];
              final totalpembayaran = pemesanan['total_pembayaran'];
              final statuspesanan = pemesanan['status_pesanan'];

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderDetailPage(
                                  idpemesanan: idpemesanan,
                                  idrincianPesanan: idrincianPesanan,
                                  idpembayaran: idpembayaran,
                                  kodepesanan: kodepesanan,
                                  tanggalbooking: tanggalbooking,
                                  waktubooking: waktubooking,
                                  totalpesanan: totalpesanan,
                                  catatan: catatan,
                                  namapenerima: namapenerima,
                                  nomerteleponpenerima: nomerteleponpenerima,
                                  alamatpengantaran: alamatpengantaran,
                                  biayapengantaran: biayapengantaran,
                                  totalpembayaran: totalpembayaran,
                                  statuspesanan: statuspesanan
                                ),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 4,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 8, 10, 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '$kodepesanan',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '$tanggalbooking',
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                                Text(
                                                  ' $waktubooking',
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          side: const BorderSide(
                                              color: Colors.black12,
                                              width: 1.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        'Nama Penerima : ',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        '$namapenerima',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        'Nomer Telepon Penerima : ',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        '$nomerteleponpenerima',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        'Alamat Pengantaran : ',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        '$alamatpengantaran',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 6, 10, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Status : ",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87),
                                      ),
                                      Text(
                                        "$statuspesanan",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 6, 10, 12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Total Pembayaran",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87),
                                      ),
                                      Text(
                                        "$totalpembayaran",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
              );
            },
          ),
        ),
      );
    }
  }
}
