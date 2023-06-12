import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dapurbun/screen/product_detail_page.dart';
import 'dart:convert';

class MenuPage extends StatefulWidget {
  final String namaMenu;
  const MenuPage({super.key, required this.namaMenu});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late String menu;

  @override
  void initState() {
    super.initState();
    menu = widget.namaMenu;
  }
  final String url = "https://dapurbun.000webhostapp.com/API/produk/menu/menu";
  final String foto = "https://dapurbun.000webhostapp.com/image/";
  
  Future getproduk() async {
    String fixurl = "$url$menu.php";
    var response = await http.get(Uri.parse(fixurl));
    return json.decode(response.body);
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
        title: Row(
          children: [
            const Text(
              'Menu Makan ',
              style: TextStyle(
                fontStyle: FontStyle.normal,
                color: Colors.green,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.namaMenu,
              style: const TextStyle(
                fontStyle: FontStyle.normal,
                color: Colors.green,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: getproduk(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                   const Padding(
                     padding: EdgeInsets.all(10.0),
                     child: Card(
                      margin: EdgeInsets.all(8),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(height: 8,),
                            Row(
                              children: [
                                Text(
                                  "Kualitas Terjamin",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8,),
                            Text(
                              "Kami menjamin kualitas dan mutu dari setiap citarasa dari makanan kami",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.normal
                              ),
                            ),
                            SizedBox(height: 8,),
                          ],
                        ),
                      ),
                                     ),
                   ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing:
                            6, // Jarak antar produk secara horizontal
                        mainAxisSpacing: 6,
                      ),
                      itemCount: snapshot.data['data'].length,
                      itemBuilder: (context, index) {
                        final fotoProduk =
                            snapshot.data['data'][index]['foto_produk'];
                        final fotoProdukUrl = foto + fotoProduk;
                        final idproduk =
                            snapshot.data['data'][index]['id_produk'];
                        final namaProduk =
                            snapshot.data['data'][index]['nama_produk'];
                        final hargaProduk =
                            snapshot.data['data'][index]['harga_produk'];
                        final deskripsiProduk =
                            snapshot.data['data'][index]['deskripsi_produk'];
                        final ratingProduk =
                            snapshot.data['data'][index]['rating_produk'];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailPage(
                                  idproduk: idproduk,
                                  fotoproduk: fotoProdukUrl,
                                  namaproduk: namaProduk,
                                  hargaproduk: hargaProduk,
                                  deskripsiproduk: deskripsiProduk,
                                  ratingproduk: ratingProduk,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(8),
                                    ),
                                    child: Image.network(
                                      fotoProdukUrl,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: Text(
                                    namaProduk,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    hargaProduk,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Text('No data found');
          }
        },
      ),
    );
  }
}
