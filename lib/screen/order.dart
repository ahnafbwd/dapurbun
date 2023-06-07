import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        order.kodePesanan,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        order.tanggalPesanan,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Jumlah Item: ${order.jumlahItem}',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Item: ${order.item}',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Status Pesanan: ${order.statusPesanan}',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Keterangan: ${order.keterangan}',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Total Pembayaran:',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Rp ${order.totalPembayaran}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


class Order {
  final String kodePesanan;
  final String tanggalPesanan;
  final int jumlahItem;
  final String item;
  final String statusPesanan;
  final String keterangan;
  final double totalPembayaran;

  Order({
    required this.kodePesanan,
    required this.tanggalPesanan,
    required this.jumlahItem,
    required this.item,
    required this.statusPesanan,
    required this.keterangan,
    required this.totalPembayaran,
  });
}

List<Order> orders = [
  Order(
    kodePesanan: 'GOJ12345',
    tanggalPesanan: '5 Juni 2023',
    jumlahItem: 3,
    item: 'Item 1, Item 2, Item 3',
    statusPesanan: 'Dalam Proses',
    keterangan: 'Pesanan sedang diproses',
    totalPembayaran: 150000,
  ),
  Order(
    kodePesanan: 'GOJ67890',
    tanggalPesanan: '4 Juni 2023',
    jumlahItem: 2,
    item: 'Item 4, Item 5',
    statusPesanan: 'Selesai',
    keterangan: 'Pesanan telah selesai',
    totalPembayaran: 100000,
  ),
  Order(
    kodePesanan: 'GOJ12348',
    tanggalPesanan: '2 Juni 2023',
    jumlahItem: 3,
    item: 'Item 1, Item 2, Item 3',
    statusPesanan: 'Dalam Proses',
    keterangan: 'Pesanan sedang diproses',
    totalPembayaran: 150000,
  ),
  Order(
    kodePesanan: 'GOJ67899',
    tanggalPesanan: '1 Juni 2023',
    jumlahItem: 2,
    item: 'Item 4, Item 5',
    statusPesanan: 'Selesai',
    keterangan: 'Pesanan telah selesai',
    totalPembayaran: 100000,
  ),
  Order(
    kodePesanan: 'GOJ12343',
    tanggalPesanan: '9 Juni 2023',
    jumlahItem: 3,
    item: 'Item 1, Item 2, Item 3',
    statusPesanan: 'Dalam Proses',
    keterangan: 'Pesanan sedang diproses',
    totalPembayaran: 150000,
  ),
  Order(
    kodePesanan: 'GOJ67894',
    tanggalPesanan: '8 Juni 2023',
    jumlahItem: 2,
    item: 'Item 4, Item 5',
    statusPesanan: 'Selesai',
    keterangan: 'Pesanan telah selesai',
    totalPembayaran: 100000,
  ),
];
