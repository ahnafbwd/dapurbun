// ignore_for_file: file_names
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dapurbun/screen/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  final List<String> images = [
    'assets/images/image1.jpg',
    'assets/images/image2.jpg',
    'assets/images/image3.jpg',
    'assets/images/image2.jpg',
    'assets/images/image1.jpg',
  ];

  final List<String> categories = [
    'Semua',
    'Katering A',
    'Katering B',
    'Katering C',
  ];

  final String url =
      "https://dapurbun.000webhostapp.com/API/produk/tampilproduk.php";
  final String foto = "https://dapurbun.000webhostapp.com/image/";
  Future getproduk() async {
    var response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    color: Colors.green,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 44.0),
                        const Text(
                          'Selamat datang',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        const Text(
                          'Jadwalkan makananmu mulai sekarang',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Cari makanan',
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 2.0,
                    ),
                    items: images.map((image) {
                      return Container(
                        margin: const EdgeInsets.all(5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset(
                            image,
                            fit: BoxFit.cover,
                            width: 1000.0,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text("Kategori"),
                  SizedBox(
                    height: 50.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(8.0),
                          child: ChoiceChip(
                            label: Text(
                              categories[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            selected: index == 0,
                            selectedColor: Colors.green,
                            onSelected: (bool selected) {
                              // Implementasi logika pemilihan kategori di sini
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(),
                  SizedBox(
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
