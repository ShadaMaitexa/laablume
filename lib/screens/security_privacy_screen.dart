import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SecurityPrivacyScreen extends StatefulWidget {
  const SecurityPrivacyScreen({super.key});

  @override
  State<SecurityPrivacyScreen> createState() => _SecurityPrivacyScreenState();
}

class _SecurityPrivacyScreenState extends State<SecurityPrivacyScreen> {
  bool _faceIdEnabled = true;
  bool _twoFactorEnabled = false;
  bool _marketingCookies = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF8F6),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Security & Privacy',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF111827),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Security Settings'),
            const SizedBox(height: 16),
            _buildSecurityOption(
              icon: Icons.face_unlock_rounded,
              title: 'Use Face ID',
              value: _faceIdEnabled,
              onChanged: (val) => setState(() => _faceIdEnabled = val),
            ),
            const SizedBox(height: 12),
            _buildSecurityOption(
              icon: Icons.phonelink_lock_rounded,
              title: 'Two-Factor Auth',
              value: _twoFactorEnabled,
              onChanged: (val) => setState(() => _twoFactorEnabled = val),
            ),
            const SizedBox(height: 12),
            _buildNavigationOption(
              icon: Icons.password_rounded,
              title: 'Change Password',
              onTap: () {},
            ),
            
            const SizedBox(height: 32),
            
            _buildSectionHeader('Privacy Settings'),
            const SizedBox(height: 16),
            _buildSecurityOption(
              icon: Icons.cookie_outlined,
              title: 'Marketing Cookies',
              value: _marketingCookies,
              onChanged: (val) => setState(() => _marketingCookies = val),
            ),
            const SizedBox(height: 12),
            _buildNavigationOption(
              icon: Icons.description_outlined,
              title: 'Data Usage Policy',
              onTap: () {},
            ),
            const SizedBox(height: 12),
            _buildNavigationOption(
              icon: Icons.visibility_off_outlined,
              title: 'Hide Profile from Search',
              onTap: () {},
            ),
            
            const SizedBox(height: 48),
            
             _buildSectionHeader('Data Management'),
            const SizedBox(height: 16),
            _buildNavigationOption(
              icon: Icons.download_rounded,
              title: 'Download My Data',
              onTap: () {},
            ),
            const SizedBox(height: 12),
            _buildNavigationOption(
              icon: Icons.delete_outline_rounded,
              title: 'Delete Account',
              iconColor: Colors.red,
              textColor: Colors.red,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF111827),
      ),
    );
  }

  Widget _buildSecurityOption({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF111827), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1F2937),
              ),
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF12B8A6),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF111827).withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor ?? const Color(0xFF111827), size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: textColor ?? const Color(0xFF1F2937),
                ),
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: Colors.grey[400], size: 22),
          ],
        ),
      ),
    );
  }
}
