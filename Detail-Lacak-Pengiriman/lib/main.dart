import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Untuk Clipboard

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lacak Pengiriman',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Color(0xFFFEFAE0),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFFEFAE0),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: TrackingDetailScreen(),
    );
  }
}

class TrackingDetailScreen extends StatefulWidget {
  const TrackingDetailScreen({Key? key}) : super(key: key);

  @override
  State<TrackingDetailScreen> createState() => _TrackingDetailScreenState();
}

class _TrackingDetailScreenState extends State<TrackingDetailScreen> {
  bool _showDetails = false;
  bool _showCopiedMessage = false;

  // Fungsi untuk menyalin nomor resi ke clipboard
  void _copyResiToClipboard() async {
    await Clipboard.setData(ClipboardData(text: 'RESI123456789'));
    
    setState(() {
      _showCopiedMessage = true;
    });
    
    // Sembunyikan pesan "Berhasil disalin" setelah 2 detik
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _showCopiedMessage = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEFAE0),
      appBar: AppBar(
        backgroundColor: Color(0xFFFEFAE0),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: Text(
          'Lacak Pengiriman',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10),
              color: Color(0xFFFEFAE0),
              child: Column(
                children: [
                  _buildHorizontalStatus(),
                ],
              ),
            ),

            _buildItemDetailsCard(),
            
            _buildDeliveryProcessCard(),
            
            _buildAddressCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalStatus() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFFBFBF9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatusItem('Sedang Dikirim', true),
          _buildStatusItem('Menuju Alamatmu', true),
          _buildStatusItem('Pesanan Tiba', true),
        ],
      ),
    );
  }

  Widget _buildStatusItem(String title, bool isCompleted) {
    return Column(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted ? Color(0xFF606C38) : Colors.grey.shade300,
          ),
          child: isCompleted
              ? Icon(Icons.check, color: Colors.white, size: 16)
              : null,
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildItemDetailsCard() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFFFBFBF9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header dengan toggle dropdown
          GestureDetector(
            onTap: () {
              setState(() {
                _showDetails = !_showDetails;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rincian Pesanan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF788F3D),
                  ),
                ),
                Icon(
                  _showDetails ? Icons.expand_less : Icons.expand_more,
                  color: Color(0xFF788F3D),
                ),
              ],
            ),
          ),
          
          // Informasi dasar barang yang selalu tampil
          SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Foto barang
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage('assets/padi.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 16),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hanya menampilkan nama barang
                    _buildDetailRow('Barang Pesanan:', 'Padi'),
                    
                    // Informasi detail hanya muncul saat dropdown dibuka
                    if (_showDetails) ...[
                      SizedBox(height: 12),
                      _buildDetailRow('Jumlah Pesanan:', '1 Ton'),
                      SizedBox(height: 12),
                      _buildDetailRow('Total Harga:', 'Rp. 10.000.000'),
                      SizedBox(height: 12),
                      _buildDetailRow('Metode Pembayaran:', 'Transfer Bank'),
                      SizedBox(height: 4),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bank: BCA',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'No. Rekening: 1234567890',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      _buildDetailRow('Tanggal Pesanan:', '25 November 2023'),
                      SizedBox(height: 4),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          'Waktu: 16:49 WIB',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          
          // Tombol Lihat Rincian Lengkap
          if (_showDetails) ...[
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF788F3D),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.list_alt, color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'Lihat Rincian Lengkap',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Color(0xFF606C38),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryProcessCard() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFFFBFBF9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Proses Pengiriman',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 16),
          
          // Nomor Resi ditempatkan di sini
          _buildResiNumberSection(),
          
          // Timeline vertikal
          Column(
            children: [
              _buildTimelineItem(
                '25 Nov 17:43',
                'Pesanan tiba di alamat tujuan.',
                isActive: true,
              ),
              _buildTimelineItem(
                '25 Nov 17:37',
                'Pesanan dalam proses pengantaran.',
                isActive: true,
              ),
              _buildTimelineItem(
                '25 Nov 17:19',
                'Pesanan telah diserahkan ke jasa kirim untuk diproses.',
                isActive: true,
              ),
              _buildTimelineItem(
                '25 Nov 16:54',
                'Kurir ditugaskan untuk menjemput pesanan.',
                isActive: true,
              ),
              _buildTimelineItem(
                '25 Nov 16:50',
                'Pengirim telah mengatur pengiriman. Menunggu pesanan diserahkan ke pihak jasa kirim.',
                isActive: true,
              ),
              _buildTimelineItem(
                '25 Nov 16:49',
                'Pesanan Dibuat',
                isActive: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResiNumberSection() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 5, top: 0),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Color(0xFFF0F4E4),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xFF788F3D).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nomor Resi',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      'RESI123456789',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF788F3D),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                      decoration: BoxDecoration(
                        color: Color(0xFF788F3D).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
                
                // Pesan "Berhasil disalin" yang muncul saat tombol ditekan
                if (_showCopiedMessage) ...[
                  SizedBox(height: 4),
                  Text(
                    'Berhasil disalin!',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
          
          // Tombol salin yang diperkecil
          GestureDetector(
            onTap: _copyResiToClipboard,
            child: Container(
              width: 32, // Diperkecil dari 40
              height: 32, // Diperkecil dari 40
              decoration: BoxDecoration(
                color: Color(0xFF788F3D),
                borderRadius: BorderRadius.circular(6), // Diperkecil dari 8
              ),
              child: Icon(
                Icons.content_copy,
                color: Colors.white,
                size: 16, // Diperkecil dari 20
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(String time, String description, {required bool isActive}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 12,
            height: 12,
            margin: EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? Color(0xFF606C38) : Colors.grey.shade300,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFFFBFBF9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Alamat Detail',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Wesconde',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'JI Karæng Loe Sero, No. 55, Tombolo, Kec. Somba Opu, Kebupaten Gowa, Sulawesi Selatan 90233, Indonesia',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}