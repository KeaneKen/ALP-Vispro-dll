import 'package:flutter/material.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEFAE0),
      appBar: AppBar(
        backgroundColor: Color(0xFFFEFAE0),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
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
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Pengiriman
            _buildDeliveryStatus(),
            SizedBox(height: 20),
            
            // Detail Barang
            _buildItemDetails(),
            SizedBox(height: 20),
            
            // Rincian Pesanan
            _buildOrderDetails(),
            SizedBox(height: 20),
            
            // Alamat Detail
            _buildAddressDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryStatus() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
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
        children: [
          _buildStatusStep(
            title: 'Sedang Dikirim',
            subtitle: 'Menuju Alamatmu',
            isActive: true,
            isCompleted: true,
          ),
          _buildStatusStep(
            title: 'Pesanan Tiba',
            subtitle: 'Pesanan tiba di alamat tujuan',
            isActive: false,
            isCompleted: true,
          ),
        ],
      ),
    );
  }

  Widget _buildStatusStep({
    required String title,
    required String subtitle,
    required bool isActive,
    required bool isCompleted,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Status
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
          SizedBox(width: 12),
          
          // Text Status
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isActive ? Colors.black : Colors.grey.shade600,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: isActive ? Color(0xFF606C38) : Colors.grey.shade500,
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

  Widget _buildItemDetails() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
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
            'Barang Pesanan:',
            style: TextStyle(
              color: Color(0xFF606C38),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Padi',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12),
          
          Text(
            'Jumlah Pesanan:',
            style: TextStyle(
              color: Color(0xFF606C38),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '1 Ton',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12),
          
          Text(
            'Total Harga:',
            style: TextStyle(
              color: Color(0xFF606C38),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Rp. 10.000.000',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderDetails() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
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
          // Header Rincian Pesanan
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFBC6C25),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Text(
              'Rincian Pesanan',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          
          // Timeline
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                _buildTimelineItem(
                  time: '25 Nov 17:43',
                  description: 'Pesanan tiba di alamat tujuan.',
                  isActive: true,
                ),
                _buildTimelineItem(
                  time: '25 Nov 17:37',
                  description: 'Pesanan dalam proses pengantaran.',
                  isActive: true,
                ),
                _buildTimelineItem(
                  time: '25 Nov 17:19',
                  description: 'Pesanan telah diserahkan ke jasa kirim untuk diproses.',
                  isActive: true,
                ),
                _buildTimelineItem(
                  time: '25 Nov 16:54',
                  description: 'Kurir ditugaskan untuk menjemput pesanan.',
                  isActive: true,
                ),
                _buildTimelineItem(
                  time: '25 Nov 16:50',
                  description: 'Pengirim telah mengatur pengiriman. Menunggu pesanan diserahkan ke pihak jasa kirim.',
                  isActive: true,
                ),
                _buildTimelineItem(
                  time: '25 Nov 16:49',
                  description: 'Pesanan Dibuat',
                  isActive: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String time,
    required String description,
    required bool isActive,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline dot
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
          
          // Timeline content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
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

  Widget _buildAddressDetails() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
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
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Wesconde',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
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