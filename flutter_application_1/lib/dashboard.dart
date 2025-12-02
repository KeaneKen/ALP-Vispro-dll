import 'package:flutter/material.dart';
import 'detailproduk.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String selectedFilter = 'All';

  final List<Map<String, dynamic>> products = [
    {
      'name': 'Jagung',
      'category': 'Jagung',
      'price': 'Rp 4,500',
      'unit': 'kg',
      'image': 'assets/images/jagung 1.jpg',
      'description': 'Jagung berkualitas tinggi dari lahan tani lokal. Biji penuh, manis, dan segar. Cocok untuk berbagai olahan makanan seperti rebusan, bakwan, atau campuran sayur.',
    },
    {
      'name': 'Padi',
      'category': 'Padi',
      'price': 'Rp 6,500',
      'unit': 'kg',
      'image': 'assets/images/padi 1.jpg',
      'description': 'Padi pilihan hasil panen terbaik. Bulir padi berkualitas premium dengan kadar air optimal. Menghasilkan beras pulen dan wangi setelah digiling.',
    },
    {
      'name': 'Cabai',
      'category': 'Cabai',
      'price': 'Rp 35,000',
      'unit': 'kg',
      'image': 'assets/images/cabai 2.jpg',
      'description': 'Cabai merah segar dengan tingkat kepedasan sedang. Daging tebal dan aroma khas. Sempurna untuk sambal, tumisan, atau bumbu masakan.',
    },
    {
      'name': 'Jagung Manis',
      'category': 'Jagung',
      'price': 'Rp 5,500',
      'unit': 'kg',
      'image': 'assets/images/jagung 2.jpg',
      'description': 'Jagung super manis varietas Super Sigma Keane. Biji kuning cerah, tekstur renyah, dan rasa manis alami. Ideal untuk direbus atau dijadikan cemilan sehat.',
    },
    {
      'name': 'Padi Organik',
      'category': 'Padi',
      'price': 'Rp 6,500',
      'unit': 'kg',
      'image': 'assets/images/padi 2.jpg',
      'description': 'Padi organik tanpa pestisida kimia. Dibudidayakan dengan metode alami ramah lingkungan. Menghasilkan beras organik sehat dengan nutrisi tinggi.',
    },
    {
      'name': 'Cabai Rawit',
      'category': 'Cabai',
      'price': 'Rp 45,000',
      'unit': 'kg',
      'image': 'assets/images/cabai 1.jpg',
      'description': 'Cabai rawit super pedas dengan ukuran kecil namun rasa yang mantap. Cocok untuk pecinta pedas sejati. Dapat digunakan untuk sambal mentah atau cabai kering.',
    },
  ];

  List<Map<String, dynamic>> get filteredProducts {
    if (selectedFilter == 'All') {
      return products;
    }
    return products.where((product) => product['category'] == selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEFAE0),
      body: Column(
        children: [
          const SizedBox(height: 40),
          // Filter Section
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFFFEFAE0),
            child: Row(
              children: [
                const Icon(
                  Icons.tune,
                  color: Color(0xFF40250D),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFF40250D).withOpacity(0.2),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedFilter,
                        isExpanded: true,
                        menuMaxHeight: 200,
                        borderRadius: BorderRadius.circular(8),
                        elevation: 8,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0xFF40250D),
                        ),
                        style: const TextStyle(
                          color: Color(0xFF40250D),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        dropdownColor: Colors.white,
                        items: ['All', 'Jagung', 'Padi', 'Cabai']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                children: [
                                  Container(
                                    width: 4,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: selectedFilter == value
                                          ? const Color(0xFF40250D)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    value,
                                    style: TextStyle(
                                      fontWeight: selectedFilter == value
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedFilter = newValue;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Products Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return _buildProductCard(product);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailProduk(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Container(
              height: 120,
              width: double.infinity,
              color: const Color(0xFFEDCEAB).withOpacity(0.3),
              child: product['image'] != null && product['image'].isNotEmpty
                  ? Image.asset(
                      product['image'],
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.image,
                          size: 50,
                          color: Color(0xFF40250D),
                        );
                      },
                    )
                  : const Icon(
                      Icons.image,
                      size: 50,
                      color: Color(0xFF40250D),
                    ),
              ),
            ),
            // Product Info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF40250D),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product['category'],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: product['price'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF788F3D),
                          ),
                        ),
                        TextSpan(
                          text: '/${product['unit']}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
