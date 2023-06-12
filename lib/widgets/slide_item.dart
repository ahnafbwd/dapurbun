// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class SlideItem extends StatefulWidget {
  final String img;
  final String title;
  final String deskripsi;

  const SlideItem({
    Key? key,
    required this.img,
    required this.title,
    required this.deskripsi,
  }) : super(key: key);

  @override
  _SlideItemState createState() => _SlideItemState();
}

class _SlideItemState extends State<SlideItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 160,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 3.0,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 150,
              width: 150,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                child: Image.asset(
                  widget.img,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 7.0),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            const SizedBox(height: 7.0),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  widget.deskripsi,
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
