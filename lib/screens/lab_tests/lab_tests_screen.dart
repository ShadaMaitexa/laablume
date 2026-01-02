import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'test_details_screen.dart';

class LabTestsScreen extends StatefulWidget {
  const LabTestsScreen({super.key});

  @override
  State<LabTestsScreen> createState() => _LabTestsScreenState();
}

class _LabTestsScreenState extends State<LabTestsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // API READY - Fetch lab tests
  Future<List<LabTest>> fetchLabTests() async {
    // TODO: Replace with actual API call
    await Future.delayed(const Duration(milliseconds: 500));
    
    return [
      LabTest(
        id: '1',
        name: 'Complete Blood Count (CBC)',
        description: 'Measures different components of blood',
        price: 299,
        preparationTime: '8-12 hours fasting',
        category: 'Blood Tests',
        isPopular: true,
      ),
      LabTest(
        id: '2',
        name: 'Lipid Profile',
        description: 'Cholesterol and triglycerides test',
        price: 499,
        preparationTime: '12 hours fasting',
        category: 'Blood Tests',
        isPopular: true,
      ),
      LabTest(
        id: '3',
        name: 'Thyroid Function Test',
        description: 'TSH, T3, T4 levels',
        price: 599,
        preparationTime: 'No fasting required',
        category: 'Hormone Tests',
        isPopular: false,
      ),
      LabTest(
        id: '4',
        name: 'Diabetes Screening',
        description: 'HbA1c and fasting glucose',
        price: 399,
        preparationTime: '8 hours fasting',
        category: 'Blood Tests',
        isPopular: true,
      ),
      LabTest(
        id: '5',
        name: 'Liver Function Test',
        description: 'SGOT, SGPT, Bilirubin',
        price: 449,
        preparationTime: 'No fasting required',
        category: 'Blood Tests',
        isPopular: false,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FAFB),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Color(0xFF111827)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Diagnostic Tests',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF111827),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF111827).withOpacity(0.06),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                   Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.search_rounded, color: Color(0xFF111827), size: 20),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() => _searchQuery = value);
                      },
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF111827),
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search blood tests, x-rays...',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF9CA3AF),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Tabs
          Container(
            height: 52,
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(18),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              labelColor: const Color(0xFF111827),
              unselectedLabelColor: const Color(0xFF6B7280),
              dividerColor: Colors.transparent,
              labelStyle: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              tabs: const [
                Tab(text: 'All Tests'),
                Tab(text: 'Popular'),
                Tab(text: 'Packages'),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Test List
          Expanded(
            child: FutureBuilder<List<LabTest>>(
              future: fetchLabTests(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF12B8A6),
                      strokeWidth: 3,
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return _emptyState();
                }

                final tests = snapshot.data!;
                final filteredTests = _searchQuery.isEmpty
                    ? tests
                    : tests.where((test) =>
                        test.name.toLowerCase().contains(_searchQuery.toLowerCase())).toList();

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                  itemCount: filteredTests.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return _testCard(filteredTests[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _testCard(LabTest test) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TestDetailsScreen(test: test),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF111827).withOpacity(0.04),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF12B8A6).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.biotech_rounded, color: Color(0xFF12B8A6), size: 26),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        test.name,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        test.description,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF6B7280),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                if (test.isPopular)
                  _badge(
                    text: 'Popular',
                    color: const Color(0xFF92400E),
                    bgColor: const Color(0xFFFEF3C7),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.timer_outlined, size: 14, color: Color(0xFF6B7280)),
                      const SizedBox(width: 6),
                      Text(
                        test.preparationTime,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  '₹${test.price.toInt()}',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF12B8A6),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _badge({required String text, required Color color, required Color bgColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: color,
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Icon(Icons.science_rounded, size: 64, color: Colors.grey.shade400),
          ),
          const SizedBox(height: 24),
          Text(
            'No Tests Found',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'We couldn\'t find any tests matching your search',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }
}

// =================================================
// MODEL (API READY)
// =================================================
class LabTest {
  final String id;
  final String name;
  final String description;
  final double price;
  final String preparationTime;
  final String category;
  final bool isPopular;

  LabTest({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.preparationTime,
    required this.category,
    this.isPopular = false,
  });

  factory LabTest.fromJson(Map<String, dynamic> json) {
    return LabTest(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      preparationTime: json['preparation_time'],
      category: json['category'],
      isPopular: json['is_popular'] ?? false,
    );
  }
}
