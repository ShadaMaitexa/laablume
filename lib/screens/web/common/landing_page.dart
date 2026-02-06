import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'role_login_screen.dart';
import 'unified_signup_screen.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _featuresKey = GlobalKey();
  final GlobalKey _trustKey = GlobalKey();
  final GlobalKey _footerKey = GlobalKey();

  void _scrollToSegment(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            _buildNavbar(context),
            _buildHero(context, key: _heroKey),
            _buildFeatures(context, key: _featuresKey),
            _buildTrustSection(context, key: _trustKey),
            _buildContactSection(context),
            _buildFooter(context, key: _footerKey),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
      color: const Color(0xFFF1F5F9),
      child: Column(
        children: [
          Text(
            'Get in Touch',
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Our team is here to help you with any questions.',
            style: GoogleFonts.poppins(fontSize: 18, color: const Color(0xFF64748B)),
          ),
          const SizedBox(height: 64),
          Wrap(
            spacing: 40,
            runSpacing: 40,
            alignment: WrapAlignment.center,
            children: [
              _contactCard(
                icon: Icons.email_outlined,
                title: 'Email Us',
                detail: 'support@lablume.com',
                desc: 'Response within 24 hours',
              ),
              _contactCard(
                icon: Icons.phone_outlined,
                title: 'Call Us',
                detail: '+1 (555) 000-1234',
                desc: 'Mon-Fri from 9am to 6pm',
              ),
              _contactCard(
                icon: Icons.location_on_outlined,
                title: 'Visit Us',
                detail: '123 Healthcare Way',
                desc: 'Silicon Valley, CA 94025',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _contactCard({required IconData icon, required String title, required String detail, required String desc}) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF12B8A6).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF12B8A6), size: 28),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF1E293B)),
          ),
          const SizedBox(height: 12),
          Text(
            detail,
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: const Color(0xFF12B8A6)),
          ),
          const SizedBox(height: 8),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 14, color: const Color(0xFF64748B)),
          ),
        ],
      ),
    );
  }

  Widget _buildNavbar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => _scrollToSegment(_heroKey),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Row(
                children: [
                  Image.asset('assets/logo.png', height: 40, errorBuilder: (c, e, s) => const Icon(Icons.hub, color: Color(0xFF12B8A6), size: 40)),
                  const SizedBox(width: 12),
                  Text(
                    'LabLume',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          _navbarItem('Solutions', onTap: () => _scrollToSegment(_featuresKey)),
          _navbarItem('About', onTap: () => _scrollToSegment(_trustKey)),
          _navbarItem('Contact', onTap: () => _scrollToSegment(_footerKey)),
          const SizedBox(width: 20),
          TextButton(
            onPressed: () {
               _showRoleLoginPicker(context);
            },
            child: Text(
              'Login',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E293B),
              ),
            ),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UnifiedSignupScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF12B8A6),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              'Sign Up',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navbarItem(String title, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              color: const Color(0xFF64748B),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context, {Key? key}) {
    bool isSmall = MediaQuery.of(context).size.width < 900;
    return Container(
      key: key,
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF12B8A6).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Next Generation Healthcare',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF12B8A6),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Precision Diagnostics\nfor Everyone.',
                  style: GoogleFonts.poppins(
                    fontSize: isSmall ? 40 : 64,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1E293B),
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Connected laboratories, clinicians, and patients through an\nintelligent ecosystem. Data-driven care simplified.',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: const Color(0xFF64748B),
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 48),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const UnifiedSignupScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF12B8A6),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(
                        'Get Started Free',
                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 20),
                    OutlinedButton(
                      onPressed: () => _scrollToSegment(_featuresKey),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        side: const BorderSide(color: Color(0xFFCBD5E1)),
                      ),
                      child: Text(
                        'Learn More',
                        style: GoogleFonts.poppins(
                          fontSize: 16, 
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (!isSmall)
            Expanded(
              flex: 1,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 500,
                    height: 500,
                    decoration: BoxDecoration(
                      color: const Color(0xFF12B8A6).withOpacity(0.05),
                      shape: BoxShape.circle,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Image.asset(
                      'assets/realistic_hero.jpg',
                      width: 600,
                      height: 500,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          padding: const EdgeInsets.all(40),
                          decoration: BoxDecoration(
                            color: const Color(0xFF12B8A6).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.medical_services_outlined,
                                size: 100,
                                color: Color(0xFF12B8A6),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Failed to load: assets/realistic_hero.jpg\n${error.toString().split('\n').first}',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(color: const Color(0xFF12B8A6), fontSize: 10),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFeatures(BuildContext context, {Key? key}) {
    return Container(
      key: key,
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            'Everything you need to manage your practice',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Unified tools for doctors, labs, and patients.',
            style: GoogleFonts.poppins(fontSize: 18, color: const Color(0xFF64748B)),
          ),
          const SizedBox(height: 80),
          Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: [
              _featureCard(
                icon: Icons.biotech,
                title: 'Smart Lab Integration',
                desc: 'Real-time test tracking and automated report generation.',
              ),
              _featureCard(
                icon: Icons.security,
                title: 'Consent-based Privacy',
                desc: 'Patients control who sees their data with blockchain-grade security.',
              ),
              _featureCard(
                icon: Icons.analytics,
                title: 'AI Insights',
                desc: 'Leverage AI to identify trends and anomalies in patient reports.',
              ),
            ],
          ),
          const SizedBox(height: 100),
          _buildClinicalGallery(context),
        ],
      ),
    );
  }

  Widget _buildClinicalGallery(BuildContext context) {
    return Column(
      children: [
        Text(
          'Clinical Excellence in Action',
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 48),
        Row(
          children: [
            Expanded(
              child: _galleryImage(
                'assets/realistic_research.jpg',
                'Precision Research',
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: _galleryImage(
                'assets/realistic_consultation.jpg',
                'Clinical Consulting',
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: _galleryImage(
                'assets/realistic_diagnostics.jpg',
                'Advanced Diagnostics',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _galleryImage(String assetPath, String label) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            assetPath,
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF12B8A6).withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.medical_services_outlined, color: Color(0xFF12B8A6), size: 48),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Failed to load: $assetPath\n${error.toString().split('\n').first}',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(color: const Color(0xFF12B8A6), fontSize: 10),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF64748B),
          ),
        ),
      ],
    );
  }

  Widget _featureCard({required IconData icon, required String title, required String desc}) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF12B8A6).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF12B8A6), size: 32),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xFF1E293B)),
          ),
          const SizedBox(height: 12),
          Text(
            desc,
            style: GoogleFonts.poppins(fontSize: 16, color: const Color(0xFF64748B), height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildTrustSection(BuildContext context, {Key? key}) {
    return Container(
      key: key,
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Column(
        children: [
          Text(
            'Trusted by leading medical institutions',
            style: GoogleFonts.poppins(color: const Color(0xFF94A3B8), fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 60,
            runSpacing: 30,
            children: [
               _trustLogo('General Health'),
               _trustLogo('BioDiagnostic'),
               _trustLogo('MediGroup'),
               _trustLogo('UnityCare'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _trustLogo(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        color: const Color(0xFFCBD5E1),
      ),
    );
  }

  Widget _buildFooter(BuildContext context, {Key? key}) {
    return Container(
      key: key,
      padding: const EdgeInsets.all(80),
      color: const Color(0xFF1E293B),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LabLume',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'The intelligent healthcare platform bridging the gap between diagnosis and treatment.',
                      style: GoogleFonts.poppins(color: const Color(0xFF94A3B8), height: 1.6),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              _footerCol('Product', ['Features', 'Pricing', 'API', 'Docs']),
              const SizedBox(width: 40),
              _footerCol('Company', ['About', 'Careers', 'Press', 'Contact']),
              const SizedBox(width: 40),
              _footerCol('Contact', ['support@lablume.com', '+1 (555) 000-1234', '123 Healthcare Way']),
            ],
          ),
          const SizedBox(height: 80),
          const Divider(color: Color(0xFF334155)),
          const SizedBox(height: 40),
          Text(
            '© 2026 LabLume Systems Inc. All rights reserved.',
            style: GoogleFonts.poppins(color: const Color(0xFF64748B)),
          ),
        ],
      ),
    );
  }

  Widget _footerCol(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        ...items.map((e) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(e, style: GoogleFonts.poppins(color: const Color(0xFF94A3B8))),
        )),
      ],
    );
  }

  void _showRoleLoginPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Portal', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _roleOption(context, 'Doctor', Icons.medical_services),
            _roleOption(context, 'Lab', Icons.biotech),
            _roleOption(context, 'Hospital', Icons.local_hospital),
            _roleOption(context, 'Admin', Icons.admin_panel_settings),
          ],
        ),
      ),
    );
  }

  Widget _roleOption(BuildContext context, String role, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF12B8A6)),
      title: Text(role, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => RoleLoginScreen(role: role)),
        );
      },
    );
  }
}
