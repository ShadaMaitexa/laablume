import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'lab_tests/lab_tests_screen.dart';
import 'reports/lab_reports_screen.dart';
import 'reports/upload_report_screen.dart';
import 'doctors/find_doctors_screen.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({super.key});

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  // ---------------- API READY ----------------
  Future<Map<String, dynamic>> fetchDashboardData() async {
    // TODO: Replace with actual API call
    await Future.delayed(const Duration(milliseconds: 500));
    
    return {
      'upcoming_appointments': 2,
      'pending_reports': 1,
      'health_score': 85,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // ---------------- HEADER ----------------
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF111827).withOpacity(0.05),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset('assets/logo.png'),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Morning,',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                      Text(
                        'John Doe',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF111827),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  _iconButton(Icons.notifications_none_rounded),
                ],
              ),

              const SizedBox(height: 32),

              // ---------------- TITLE ----------------
              Text(
                'How are you feeling\ntoday?',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF111827),
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 24),

              // ---------------- SEARCH ----------------
              Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF111827).withOpacity(0.04),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search_rounded, color: Color(0xFF9CA3AF), size: 22),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search tests, doctors...',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 14,
                            color: const Color(0xFF9CA3AF),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // ---------------- SUMMARY CARD ----------------
              FutureBuilder<Map<String, dynamic>>(
                future: fetchDashboardData(),
                builder: (context, snapshot) {
                  final data = snapshot.data ?? {};
                  return Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1F2937), Color(0xFF111827)],
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
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _statItem('Appointments', '${data['upcoming_appointments'] ?? 0}', Icons.calendar_month_rounded),
                            _statItem('Reports', '${data['pending_reports'] ?? 0}', Icons.description_rounded),
                            _statItem('Health Score', '${data['health_score'] ?? 0}%', Icons.favorite_rounded),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 40),

              // ---------------- QUICK ACTIONS ----------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _sectionHeader('Services'),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'View all',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF12B8A6),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.1,
                children: [
                  _serviceCard(
                    icon: Icons.science_rounded,
                    title: 'Book Lab Test',
                    subtitle: 'Accurate results',
                    color: const Color(0xFF12B8A6),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LabTestsScreen())),
                  ),
                  _serviceCard(
                    icon: Icons.upload_file_rounded,
                    title: 'Upload Report',
                    subtitle: 'AI Analysis',
                    color: Colors.indigo,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const UploadReportScreen())),
                  ),
                  _serviceCard(
                    icon: Icons.people_rounded,
                    title: 'Find Doctors',
                    subtitle: 'Top specialists',
                    color: Colors.orange,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FindDoctorsScreen())),
                  ),
                  _serviceCard(
                    icon: Icons.folder_rounded,
                    title: 'My Reports',
                    subtitle: 'Manage records',
                    color: Colors.pink,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LabReportsScreen())),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // ---------------- AI BANNER ----------------
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF8F6),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFF12B8A6).withOpacity(0.1)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF12B8A6).withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.auto_awesome_rounded, color: Color(0xFF12B8A6), size: 28),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'AI Analysis Ready',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF111827),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Analyze your blood work instantly.',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: const Color(0xFF4B5563),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right_rounded, color: Color(0xFF12B8A6)),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              _sectionHeader('Health Insights'),
              const SizedBox(height: 16),

              _healthInsightCard(
                'Daily Hydration',
                'You reached 80% of your goal today.',
                Icons.water_drop_rounded,
                const Color(0xFF3B82F6),
              ),
              const SizedBox(height: 12),
              _healthInsightCard(
                'Activity Level',
                'Your step count is up by 15% this week.',
                Icons.bolt_rounded,
                const Color(0xFFF59E0B),
              ),

              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconButton(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(icon, size: 22, color: const Color(0xFF111827)),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF111827),
      ),
    );
  }

  Widget _statItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(height: 12),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  Widget _serviceCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF111827).withOpacity(0.04),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 26),
            ),
            const Spacer(),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _healthInsightCard(String title, String description, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withOpacity(0.02),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
