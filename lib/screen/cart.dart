// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api
import 'package:dapurbun/screen/confirmationorder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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

  Future<void> updateCartItem(String idKeranjang, String jml) async {
    const String apiUrl =
        'https://dapurbun.000webhostapp.com/API/keranjang/updatekeranjang.php';

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'idkeranjang': idKeranjang,
        'jml': jml,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['success'] == true) {
        // Jumlah produk berhasil diperbarui, lakukan pembaruan data keranjang
        fetchCartData();
        Fluttertoast.showToast(
          msg: "Jumlah produk berhasil diperbarui",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      } else {
        // Gagal memperbarui jumlah produk, tampilkan pesan error
        final errorMessage = responseData['message'];
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(errorMessage),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      // Gagal melakukan permintaan ke server, tampilkan pesan error
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Gagal memperbarui keranjang'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> removeCartItem(String idKeranjang) async {
    const String apiUrl =
        'https://dapurbun.000webhostapp.com/API/keranjang/hapuskeranjang.php';

    final response = await http.post(Uri.parse(apiUrl), body: {
      'idkeranjang': idKeranjang,
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['success'] == true) {
        // Jumlah produk berhasil diperbarui, lakukan pembaruan data keranjang
        fetchCartData();
        Fluttertoast.showToast(
          msg: "Produk berhasil dihapus dari keranjang",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      } else {
        // Gagal memperbarui jumlah produk, tampilkan pesan error
        final errorMessage = responseData['message'];
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(errorMessage),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      // Gagal melakukan permintaan ke server, tampilkan pesan error
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Gagal menghapus produk dari keranjang'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCartData();
  }

  Future<void> refreshCartData() async {
    await fetchCartData();
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
          child: RefreshIndicator(
            color: Colors.green,
            onRefresh:
                refreshCartData, // Menjalankan refreshCartData saat melakukan gestur refresh
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(16, 44, 16, 16),
                  child: const Text(
                    'Keranjang',
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      color: Colors.green,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: cartData.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartData[index];
                      final List<dynamic> idkeranjang = cartItem['idkeranjang'];
                      final List<dynamic> products = cartItem['produk'];
                      final List<dynamic> photos = cartItem['foto'];
                      final List<dynamic> price = cartItem['harga'];
                      final List<dynamic> jml = cartItem['jml'];

                      final tgl = cartItem['tanggal_booking'];
                      final wkt = cartItem['waktu_booking'];
                      final itemCount = cartItem['jumlah_item'];

                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 4,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const SizedBox(height: 8),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '$tgl',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    '$wkt',
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.normal,
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
                                                style: TextStyle(fontSize: 14),
                                              ),
                                              Text(
                                                itemCount.join(',').toString(),
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
                                          const EdgeInsets.fromLTRB(8, 2, 8, 8),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: products.length,
                                        itemBuilder: (context, index) {
                                          final idkeranjan = idkeranjang[index];
                                          final product = products[index];
                                          final photo = photos[index];
                                          final harga = price[index];
                                          final jmll = jml[index];
                                          int quantity = int.parse(jmll);
                                          final fotoUrl =
                                              'https://dapurbun.000webhostapp.com/image/$photo';

                                          return SizedBox(
                                            child: Row(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 60,
                                                      height: 60,
                                                      margin:
                                                          const EdgeInsets.all(
                                                              8),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              fotoUrl),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 8),
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
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        Text(
                                                          "Rp $harga ",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        const Text(
                                                          'Item :',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                IconButton(
                                                                  icon:
                                                                      const Icon(
                                                                    Icons
                                                                        .remove,
                                                                    size: 20,
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    // Mengurangi jumlah produk dalam keranjang
                                                                    if (quantity >
                                                                        1) {
                                                                      setState(
                                                                          () {
                                                                        quantity--;
                                                                      });
                                                                      updateCartItem(
                                                                        idkeranjan
                                                                            .toString(),
                                                                        quantity
                                                                            .toString(),
                                                                      );
                                                                    } else {
                                                                      // Menghapus jumlah produk dalam keranjang
                                                                      removeCartItem(
                                                                          idkeranjan
                                                                              .toString());
                                                                    }
                                                                  },
                                                                ),
                                                                Text(
                                                                  quantity
                                                                      .toString(),
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        16.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                IconButton(
                                                                  icon:
                                                                      const Icon(
                                                                    Icons.add,
                                                                    size: 20,
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    // Menambah jumlah produk dalam keranjang
                                                                    setState(
                                                                        () {
                                                                      quantity++;
                                                                    });
                                                                    updateCartItem(
                                                                      idkeranjan
                                                                          .toString(),
                                                                      quantity
                                                                          .toString(),
                                                                    );
                                                                  },
                                                                ),
                                                                IconButton(
                                                                  icon:
                                                                      const Icon(
                                                                    Icons
                                                                        .delete,
                                                                    size: 20,
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    // Menghapus produk dalam keranjang
                                                                    removeCartItem(
                                                                        idkeranjan
                                                                            .toString());
                                                                  },
                                                                ),
                                                              ],
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
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfirmationOrderPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    }
  }
}
