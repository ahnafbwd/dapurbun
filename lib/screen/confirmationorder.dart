// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmationOrderPage extends StatefulWidget {
  ConfirmationOrderPage({super.key});

  @override
  _ConfirmationOrderPageState createState() => _ConfirmationOrderPageState();
}

class _ConfirmationOrderPageState extends State<ConfirmationOrderPage> {
  TextEditingController namaPenerimaController = TextEditingController();
  TextEditingController nomerTeleponController = TextEditingController();
  TextEditingController lokasiPengantaranController = TextEditingController();
  List<Map<String, dynamic>> cartData = [];
  String idUser = '';

  Future<void> fetchCartData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      idUser = prefs.getString('iduser') ?? '';
    });

    final String apiUrl =
        'https://dapurbun.000webhostapp.com/API/keranjang/tampilkeranjang.php?id_user=$idUser';

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        cartData = responseData.cast<Map<String, dynamic>>().toList();
      });
    } else {
      throw Exception('Failed to fetch cart data');
    }
  }

  double calculateTotalPrice() {
    double totalPrice = 0;
    for (var cartItem in cartData) {
      double itemTotal =
          double.parse(cartItem['total_harga'].toString().replaceAll(',', ''));
      totalPrice += itemTotal;
    }
    return totalPrice;
  }

  @override
  void initState() {
    super.initState();
    fetchCartData();
  }

  @override
  Widget build(BuildContext context) {
    if (cartData.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text(
            'Tidak ada data dalam keranjang',
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      );
    } else {
      final double totalHarga = calculateTotalPrice();
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 44, 16, 16),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.green,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Text(
                        'Konfirmasi Pesanan',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          color: Colors.green,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: const Border.fromBorderSide(
                                  BorderSide(color: Colors.black))),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                      child: Text(
                                        "Penerima : ",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextField(
                                      controller: namaPenerimaController,
                                      decoration: const InputDecoration(
                                          labelText: 'Nama Penerima',
                                          floatingLabelStyle:
                                              TextStyle(color: Colors.green),
                                          hintStyle:
                                              TextStyle(color: Colors.green),
                                          border: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.green))),
                                    ),
                                    const SizedBox(height: 12.0),
                                    TextField(
                                      controller: nomerTeleponController,
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                          labelText: 'Nomer Telepon Penerima',
                                          floatingLabelStyle:
                                              TextStyle(color: Colors.green),
                                          hintStyle:
                                              TextStyle(color: Colors.green),
                                          border: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.green))),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        Container(
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: const Border.fromBorderSide(
                                  BorderSide(color: Colors.black))),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                      child: Text(
                                        "Lokasi Pengantaran : ",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextField(
                                      controller: lokasiPengantaranController,
                                      decoration: const InputDecoration(
                                          labelText: 'Lokasi Pengantaran',
                                          floatingLabelStyle:
                                              TextStyle(color: Colors.green),
                                          hintStyle:
                                              TextStyle(color: Colors.green),
                                          border: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.green))),
                                    ),
                                    const SizedBox(height: 12.0),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                      ),
                                      onPressed: () {},
                                      child: const Text(
                                        'Pilih Lokasi',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
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
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Total: Rp $totalHarga',
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text(
                  'Pesan Sekarang',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      );
    }
  }
}
