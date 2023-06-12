// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors_in_immutables

import 'package:dapurbun/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConfirmationOrderPage extends StatefulWidget {
  ConfirmationOrderPage({Key? key}) : super(key: key);

  @override
  _ConfirmationOrderPageState createState() => _ConfirmationOrderPageState();
}

class _ConfirmationOrderPageState extends State<ConfirmationOrderPage> {
  TextEditingController namaPenerimaController = TextEditingController();
  TextEditingController nomerTeleponController = TextEditingController();
  TextEditingController lokasiPengantaranController = TextEditingController();
  List<Map<String, dynamic>> cartData = [];
  String idUser = '';

  void showSuccessNotification() {
    Fluttertoast.showToast(
      msg: 'Produk berhasil dipesan',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  void showErrorNotification() {
    Fluttertoast.showToast(
      msg: 'Gagal melakukan pemesanan',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

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

  double ongkire() {
    double ongkir = 10000.0;

    return ongkir;
  }

  double totalsemua(double ongkir) {
    double totale = 0;
    for (var cartItem in cartData) {
      double itemTotal =
          double.parse(cartItem['total_harga'].toString().replaceAll(',', ''));
      totale += itemTotal;
      totale += ongkir;
    }
    return totale;
  }

  @override
  void initState() {
    super.initState();
    fetchCartData();
  }

  Future<void> addToOrder(String totalbayar, String ongkir, String totalpesan) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      idUser = prefs.getString('iduser') ?? '';
    });

    const String apiUrl =
        'https://dapurbun.000webhostapp.com/API/pesanan/masukpesanan.php'; // Ganti dengan URL API PHP yang sesuai

    final response = await http.post(Uri.parse(apiUrl), body: {
      'id_user': idUser,
      'total_pembayaran': totalbayar,
      'status_pembayaran': 'Belum bayar',
      'total_pesanan': totalpesan,
      'catatan': '',
      'nama_penerima': namaPenerimaController.text,
      'nomer_telepon_penerima': nomerTeleponController.text,
      'alamat_pengantaran': lokasiPengantaranController.text,
      'biaya_pengantaran': ongkir,
      'status_pesanan': 'Belum bayar',
    });
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body.replaceAll('<br />', ''));
      if (responseData['status'] == 'success') {
        print('Data berhasil dikirim');
        showSuccessNotification();
      } else {
        print('Gagal mengirim data: ${responseData['message']}');
        showErrorNotification();
      }
    } else {
      print('Error: ${response.statusCode}');
    }
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
      final double ongkir = ongkire();
      final double totale = totalsemua(ongkir);
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
            'Konfirmasi Pesanan',
            style: TextStyle(
              fontStyle: FontStyle.normal,
              color: Colors.green,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 8),
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
                        const SizedBox(height: 8.0),
                        Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                const Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 8),
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
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Card(
                          elevation: 2,
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(16, 16, 16, 2),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Pesanan : ",
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: cartData.length,
                                    itemBuilder: (context, index) {
                                      final cartItem = cartData[index];
                                      final List<dynamic> idkeranjang =
                                          cartItem['idkeranjang'];
                                      final List<dynamic> products =
                                          cartItem['produk'];
                                      final List<dynamic> photos =
                                          cartItem['foto'];
                                      final List<dynamic> price =
                                          cartItem['harga'];
                                      final List<dynamic> jml = cartItem['jml'];

                                      final tgl = cartItem['tanggal_booking'];
                                      final wkt = cartItem['waktu_booking'];
                                      final itemCount = cartItem['jumlah_item'];
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 8, 8, 8),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            const SizedBox(height: 8),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        '$tgl',
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            '$wkt',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      const Text(
                                                        'Total Items: ',
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                      Text(
                                                        itemCount
                                                            .join(',')
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                      const SizedBox(height: 8),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 8),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 2, 8, 2),
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: products.length,
                                                itemBuilder: (context, index) {
                                                  final idkeranjan =
                                                      idkeranjang[index];
                                                  final product =
                                                      products[index];
                                                  final photo = photos[index];
                                                  final harga = price[index];
                                                  final jmll = jml[index];
                                                  int quantity =
                                                      int.parse(jmll);
                                                  final fotoUrl =
                                                      'https://dapurbun.000webhostapp.com/image/$photo';

                                                  return SizedBox(
                                                    child: Row(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width: 60,
                                                              height: 60,
                                                              margin:
                                                                  const EdgeInsets
                                                                      .all(8),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                image:
                                                                    DecorationImage(
                                                                  image: NetworkImage(
                                                                      fotoUrl),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 8),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Text(
                                                                  product,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                                Text(
                                                                  "Rp $harga ",
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                  ),
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    const Text(
                                                                      'Item :',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      quantity
                                                                          .toString(),
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            16.0,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                const Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 8),
                                      child: Text(
                                        "Rincian Pembayaran : ",
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Total Pesanan",
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          totalHarga.toString(),
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Biaya Pengantaran",
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          ongkir.toString(),
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Total Harga",
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          totale.toString(),
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
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
                'Total: Rp $totale',
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
                onPressed: () {
                  addToOrder(totale.toString(), ongkir.toString(),
                          totalHarga.toString())
                      .then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyHomePage()));
                  });
                },
              ),
            ],
          ),
        ),
      );
    }
  }
}
