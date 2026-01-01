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
      backgroundColor: const Color(0xFFEFF7F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFF7F6),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Lab Tests',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Container(
              height: 46,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() => _searchQuery = value);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search tests...',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 13,
                          color: const Color(0xFF9CA3AF),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: Color(0xFF12B8A6),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Tabs
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: const Color(0xFF12B8A6),
                borderRadius: BorderRadius.circular(30),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: const Color(0xFF6B7280),
              labelStyle: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
              tabs: const [
                Tab(text: 'All Tests'),
                Tab(text: 'Popular'),
                Tab(text: 'Packages'),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Test List
          Expanded(
            child: FutureBuilder<List<LabTest>>(
              future: fetchLabTests(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF12B8A6),
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
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  itemCount: filteredTests.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
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
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    test.name,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (test.isPopular)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF12B8A6).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Popular',
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF12B8A6),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              test.description,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 14,
                  color: const Color(0xFF9CA3AF),
                ),
                const SizedBox(width: 4),
                Text(
                  test.preparationTime,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
                const Spacer(),
                Text(
                  '₹${test.price}',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
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

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.science_outlined,
            size: 64,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            'No tests found',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: const Color(0xFF9CA3AF),
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
