import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/patient_provider.dart';
import 'common/feedback_screen.dart';
import 'payment_screen.dart';

class LabDetailScreen extends StatefulWidget {
  final Map<String, dynamic> lab;

  const LabDetailScreen({super.key, required this.lab});

  @override
  State<LabDetailScreen> createState() => _LabDetailScreenState();
}

class _LabDetailScreenState extends State<LabDetailScreen> {
  List<dynamic> _tests = [];
  bool _isLoadingTests = true;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _testsKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _fetchTests();
  }

  Future<void> _fetchTests() async {
    setState(() => _isLoadingTests = true);
    final provider = context.read<PatientProvider>();
    final results = await provider.getLabTests(widget.lab['id'] ?? widget.lab['_id'] ?? '');
    setState(() {
      _tests = results;
      _isLoadingTests = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: Text(
          'Lab Details',
          style: GoogleFonts.poppins(
            color: const Color(0xFF111827),
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabInfoCard(),
            const SizedBox(height: 32),
            _buildSectionHeader('Available Tests', key: _testsKey),
            const SizedBox(height: 16),
            _isLoadingTests
                ? const Center(child: CircularProgressIndicator(color: Color(0xFF12B8A6)))
                : _tests.isEmpty
                    ? _buildEmptyTests()
                    : _buildTestsList(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildLabInfoCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFF12B8A6).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.science_rounded, size: 40, color: Color(0xFF12B8A6)),
          ),
          const SizedBox(height: 16),
          Text(
            widget.lab['name'] ?? 'Lab Name',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF111827),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on_rounded, color: Color(0xFF9CA3AF), size: 16),
              const SizedBox(width: 4),
              Text(
                widget.lab['city'] ?? 'City Location',
                style: GoogleFonts.poppins(fontSize: 14, color: const Color(0xFF6B7280)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatColumn('Rating', (widget.lab['rating'] ?? 4.7).toString(), Icons.star_rounded),
              _buildStatColumn('Experience', '10+ Yrs', Icons.verified_user_rounded),
              _buildStatColumn('Support', '24/7', Icons.support_agent_rounded),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Scrollable.ensureVisible(
                  _testsKey.currentContext!,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF12B8A6),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 0,
              ),
              child: Text(
                'Browse All Tests',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FeedbackScreen(
                      targetId: widget.lab['id'] ?? widget.lab['_id'] ?? '',
                      targetName: widget.lab['name'] ?? 'Lab',
                      targetType: 'lab',
                    ),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF12B8A6)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(
                'Submit Review',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, color: const Color(0xFF12B8A6)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF12B8A6), size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF111827),
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF6B7280)),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, {Key? key}) {
    return Text(
      key: key,
      title,
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF111827),
      ),
    );
  }

  Widget _buildEmptyTests() {
    return Container(
      padding: const EdgeInsets.all(40),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Icon(Icons.science_outlined, size: 48, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'No tests listed yet',
            style: GoogleFonts.poppins(color: const Color(0xFF6B7280)),
          ),
        ],
      ),
    );
  }

  Widget _buildTestsList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _tests.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final test = _tests[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF111827).withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      test['name'] ?? 'Diagnostic Test',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Price: ₹${test['price'] ?? '500'}',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF12B8A6),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => _bookTest(test),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF12B8A6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                child: Text(
                  'Book',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _bookTest(Map<String, dynamic> test) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentScreen(
          title: test['name'] ?? 'Diagnostic Test',
          subtitle: widget.lab['name'] ?? 'Laboratory',
          amount: double.tryParse(test['price']?.toString() ?? '500') ?? 500.0,
          type: PaymentType.labTest,
          bookingData: {
            'labId': widget.lab['id'] ?? widget.lab['_id'],
            'testId': test['id'] ?? test['_id'],
            'testName': test['name'],
            'price': test['price'],
            'bookingDate': DateTime.now().toIso8601String(),
          },
        ),
      ),
    );
  }
}
