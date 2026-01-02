import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'lab_reports_screen.dart';

class ReportDetailScreen extends StatelessWidget {
  final LabReport report;

  const ReportDetailScreen({super.key, required this.report});

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
          'Detailed Analysis',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF111827),
          ),
        ),
        centerTitle: true,
        actions: [
          _iconButton(Icons.share_rounded),
          const SizedBox(width: 8),
          _iconButton(Icons.download_rounded),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Report Header Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF111827), Color(0xFF1F2937)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF111827).withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF12B8A6).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.auto_awesome_rounded,
                          color: Color(0xFF12B8A6),
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                         'AI Powered Analysis',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF12B8A6),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    report.testName,
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on_rounded, color: Colors.white38, size: 14),
                      const SizedBox(width: 6),
                      Text(
                        report.labName,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.white60,
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Divider(color: Colors.white10),
                  ),
                  Row(
                    children: [
                      _headerStat('Date', _formatDateShort(report.date)),
                      const Spacer(),
                      _headerStat('Status', report.hasAbnormalities ? 'Attention' : 'Normal'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Overall Status
            _sectionTitle('Health Recommendation'),
            const SizedBox(height: 16),
            _statusCard(
              status: report.hasAbnormalities ? 'Follow-up Suggested' : 'Good Health Condition',
              color: report.hasAbnormalities ? const Color(0xFFF59E0B) : const Color(0xFF10B981),
              icon: report.hasAbnormalities ? Icons.notifications_active_rounded : Icons.verified_rounded,
              description: report.hasAbnormalities
                  ? 'We noticed some irregularities in your report parameters. We recommend scheduling a consultation.'
                  : 'Great! All your diagnostic parameters are within the standard medical reference ranges.',
            ),

            const SizedBox(height: 32),

            // Test Parameters
            _sectionTitle('Detailed Findings'),
            const SizedBox(height: 16),
            _parameterCard(
              name: 'Hemoglobin',
              value: '14.2',
              unit: 'g/dL',
              normalRange: '13.0 - 17.0',
              status: 'normal',
            ),
            const SizedBox(height: 12),
            _parameterCard(
              name: 'White Blood Cells',
              value: '7.5',
              unit: 'x10³/µL',
              normalRange: '4.0 - 11.0',
              status: 'normal',
            ),
            const SizedBox(height: 12),
            _parameterCard(
              name: 'Platelets',
              value: '250',
              unit: 'x10³/µL',
              normalRange: '150 - 400',
              status: 'normal',
            ),

            const SizedBox(height: 32),

            // AI Recommendations
            _sectionTitle('AI Action Plan'),
            const SizedBox(height: 16),
            _recommendationsCard(),

            const SizedBox(height: 32),

            // Consult Doctor Button
            Container(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Navigate to doctor consultation
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF12B8A6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.videocam_rounded, size: 22, color: Colors.white),
                    const SizedBox(width: 12),
                    Text(
                      'Consult a Specialist',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _headerStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.white38,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _iconButton(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(icon, size: 20, color: const Color(0xFF111827)),
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: const Color(0xFF111827),
      ),
    );
  }

  Widget _statusCard({
    required String status,
    required Color color,
    required IconData icon,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
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
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  status,
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF111827),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF6B7280),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _parameterCard({
    required String name,
    required String value,
    required String unit,
    required String normalRange,
    required String status,
  }) {
    final isNormal = status == 'normal';
    final statusColor = isNormal ? const Color(0xFF10B981) : const Color(0xFFF59E0B);

    return Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF111827),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  isNormal ? 'NORMAL' : 'FLAGGED',
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF111827),
                ),
              ),
              const SizedBox(width: 6),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  unit,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Reference Range',
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                  Text(
                    normalRange,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _recommendationsCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF12B8A6).withOpacity(0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF12B8A6).withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.tips_and_updates_rounded,
                color: Color(0xFF0D9488),
                size: 22,
              ),
              const SizedBox(width: 12),
              Text(
                'Health Optimization',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0D9488),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _recommendationItem('Maintain your current diet and hydration levels'),
          _recommendationItem('Stay active with at least 30 minutes of cardio'),
          _recommendationItem('Schedule a routine checkup in 6 months'),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'DISCLAIMER: This analysis is AI-generated for informative purposes only. Always consult a certified medical professional.',
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF9CA3AF),
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _recommendationItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_rounded, size: 16, color: Color(0xFF12B8A6)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF4B5563),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateShort(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${date.day} ${months[date.month - 1]}, ${date.year}';
  }
}
