import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'upload_report_screen.dart';
import 'report_detail_screen.dart';

class LabReportsScreen extends StatefulWidget {
  const LabReportsScreen({super.key});

  @override
  State<LabReportsScreen> createState() => _LabReportsScreenState();
}

class _LabReportsScreenState extends State<LabReportsScreen> {
  // API READY - Fetch lab reports
  Future<List<LabReport>> fetchLabReports() async {
    // TODO: Replace with actual API call
    await Future.delayed(const Duration(milliseconds: 500));
    
    return [
      LabReport(
        id: '1',
        testName: 'Complete Blood Count',
        date: DateTime.now().subtract(const Duration(days: 5)),
        status: 'analyzed',
        labName: 'LabLume Diagnostics',
        hasAbnormalities: false,
      ),
      LabReport(
        id: '2',
        testName: 'Lipid Profile',
        date: DateTime.now().subtract(const Duration(days: 15)),
        status: 'analyzed',
        labName: 'LabLume Diagnostics',
        hasAbnormalities: true,
      ),
      LabReport(
        id: '3',
        testName: 'Thyroid Function Test',
        date: DateTime.now().subtract(const Duration(days: 30)),
        status: 'pending',
        labName: 'LabLume Diagnostics',
        hasAbnormalities: false,
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
          'Lab Reports',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF111827),
          ),
        ),
        centerTitle: true,
        actions: [
          _iconButton(Icons.tune_rounded),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // Upload Report Button
          Padding(
            padding: const EdgeInsets.all(24),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UploadReportScreen(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF111827), Color(0xFF1F2937)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF111827).withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF12B8A6).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.add_circle_rounded,
                        color: Color(0xFF12B8A6),
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Analyze New Report',
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Get instant AI insights from results',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white24,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Reports List
          Expanded(
            child: FutureBuilder<List<LabReport>>(
              future: fetchLabReports(),
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

                final reports = snapshot.data!;

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                  itemCount: reports.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return _reportCard(reports[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(icon, size: 22, color: const Color(0xFF111827)),
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget _reportCard(LabReport report) {
    return GestureDetector(
      onTap: () {
        if (report.status == 'analyzed') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReportDetailScreen(report: report),
            ),
          );
        }
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
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _getStatusColor(report.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    _getStatusIcon(report.status),
                    color: _getStatusColor(report.status),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        report.testName,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        report.labName,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Color(0xFFD1D5DB)),
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
                      const Icon(
                        Icons.calendar_month_rounded,
                        size: 14,
                        color: Color(0xFF6B7280),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _formatDate(report.date),
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
                _statusBadgeContainer(report.status, report.hasAbnormalities),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusBadgeContainer(String status, bool hasAbnormalities) {
    if (status == 'pending') {
      return _badge(
        text: 'Processing',
        color: const Color(0xFFF59E0B),
        bgColor: const Color(0xFFFEF3C7),
      );
    }

    if (hasAbnormalities) {
      return _badge(
        text: 'Flagged',
        color: const Color(0xFFEF4444),
        bgColor: const Color(0xFFFEE2E2),
      );
    }

    return _badge(
      text: 'Healthy',
      color: const Color(0xFF10B981),
      bgColor: const Color(0xFFD1FAE5),
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
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'analyzed':
        return const Color(0xFF12B8A6);
      case 'pending':
        return const Color(0xFFF59E0B);
      default:
        return const Color(0xFF6B7280);
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'analyzed':
        return Icons.verified_user_rounded;
      case 'pending':
        return Icons.sync_rounded;
      default:
        return Icons.description_rounded;
    }
  }

  String _formatDate(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${date.day} ${months[date.month - 1]}, ${date.year}';
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
            child: Icon(Icons.description_outlined, size: 64, color: Colors.grey.shade400),
          ),
          const SizedBox(height: 24),
          Text(
            'No Reports Yet',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Keep all your diagnostic records in one place',
            textAlign: TextAlign.center,
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
class LabReport {
  final String id;
  final String testName;
  final DateTime date;
  final String status; // 'pending', 'analyzed'
  final String labName;
  final bool hasAbnormalities;

  LabReport({
    required this.id,
    required this.testName,
    required this.date,
    required this.status,
    required this.labName,
    this.hasAbnormalities = false,
  });

  factory LabReport.fromJson(Map<String, dynamic> json) {
    return LabReport(
      id: json['id'],
      testName: json['test_name'],
      date: DateTime.parse(json['date']),
      status: json['status'],
      labName: json['lab_name'],
      hasAbnormalities: json['has_abnormalities'] ?? false,
    );
  }
}
