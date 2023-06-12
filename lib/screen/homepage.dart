// ignore_for_file: file_names, unnecessary_null_comparison
import 'dart:convert';

import 'package:dapurbun/screen/menu.dart';
import 'package:dapurbun/util/menu.dart';
import 'package:dapurbun/widgets/slide_item.dart';
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
    'pagi',
    'siang',
    'malam',
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
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            alignment: AlignmentDirectional.centerStart,
            color: Colors.green[900],
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 44.0),
                Text(
                  'Selamat datang',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Jadwalkan makananmu mulai sekarang',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
            alignment: AlignmentDirectional.centerStart,
            color: Colors.green,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Pilihan Makanan',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: buildRestaurantList(context),
          ),
        ],
      ),
    ));
  }

  buildRestaurantList(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.4,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: menu == null ? 0 : menu.length,
        itemBuilder: (BuildContext context, int index) {
          Map menus = menu[index];
          final namame = menus["title"];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MenuPage(namaMenu: namame),
                ),
              );
            },
            child: SlideItem(
              img: menus["img"],
              title: menus["title"],
              deskripsi: menus["deskripsi"],
            ),
          );
        },
      ),
    );
  }
}
