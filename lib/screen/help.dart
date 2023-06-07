import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 8),
            child: Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Pusat Bantuan',
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  color: Colors.green,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                Image.asset(
                  'assets/images/csdapurbun.png',
                  fit: BoxFit.cover,
                  width: 300.0,
                ),
                const Text(
                  "Hai Budi, butuh bantuan?",
                  style: TextStyle(color: Colors.black87,height: 16,fontWeight: FontWeight.bold),
                ),
                
                Container(
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: const Border.fromBorderSide(
                          BorderSide(color: Colors.black))),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]));
  }
}
