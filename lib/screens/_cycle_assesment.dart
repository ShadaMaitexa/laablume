import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laablume/screens/main_navigation_screen.dart';

class LifestyleInformationScreen extends StatefulWidget {
  const LifestyleInformationScreen({super.key});

  @override
  State<LifestyleInformationScreen> createState() =>
      _LifestyleInformationScreenState();
}

class _LifestyleInformationScreenState
    extends State<LifestyleInformationScreen> {
  // Selected values for lifestyle choices
  int _selectedSmokingIndex = 1; // Default: No
  int _selectedAlcoholIndex = 2; // Default: Occasionally
  int _selectedActivityIndex = 1; // Default: Moderate

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF8F6),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFEAF8F6),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: _buildProgressBar(4, 5),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
              );
            },
            child: Text(
              'Skip',
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF12B8A6),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                'Lifestyle information',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Sharing lifestyle details helps doctors tailor advice and treatment to your health needs.',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  height: 1.5,
                  color: const Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 32),

              // Smoking
              _sectionTitle('Smoking'),
              const SizedBox(height: 12),
              _pillRow(
                const ['Yes', 'No', 'Occasionally'],
                selectedIndex: _selectedSmokingIndex,
                onChanged: (index) {
                  setState(() => _selectedSmokingIndex = index);
                },
              ),

              const SizedBox(height: 24),

              // Alcohol
              _sectionTitle('Alcohol'),
              const SizedBox(height: 12),
              _pillRow(
                const ['Yes', 'No', 'Occasionally'],
                selectedIndex: _selectedAlcoholIndex,
                onChanged: (index) {
                  setState(() => _selectedAlcoholIndex = index);
                },
              ),

              const SizedBox(height: 32),

              // Activity level
              _sectionTitle('Activity Level'),
              const SizedBox(height: 12),
              _activityTile(
                'Light',
                'Sports 1–3 days a week',
                selected: _selectedActivityIndex == 0,
                onTap: () => setState(() => _selectedActivityIndex = 0),
              ),
              _activityTile(
                'Moderate',
                'Sports 3–5 days a week',
                selected: _selectedActivityIndex == 1,
                onTap: () => setState(() => _selectedActivityIndex = 1),
              ),
              _activityTile(
                'Very Active',
                'Sports 6–7 days a week',
                selected: _selectedActivityIndex == 2,
                onTap: () => setState(() => _selectedActivityIndex = 2),
              ),

              const SizedBox(height: 48),

              // Next button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    _showSnackBar('Lifestyle information saved!');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainNavigationScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF12B8A6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Save & Complete',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar(int step, int total) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(total, (index) {
        return Container(
          width: 36,
          height: 4,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: index < step 
                ? const Color(0xFF12B8A6) 
                : const Color(0xFF12B8A6).withOpacity(0.2),
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message), 
        backgroundColor: const Color(0xFF12B8A6),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  // ---------- SECTION TITLE ----------
  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 13, 
        fontWeight: FontWeight.w500,
        color: const Color(0xFF1F2937)
      ),
    );
  }

  // ---------- PILL ROW ----------
  Widget _pillRow(
    List<String> labels, {
    required int selectedIndex,
    required Function(int) onChanged,
  }) {
    return Row(
      children: List.generate(labels.length, (index) {
        final isSelected = index == selectedIndex;
        return Expanded(
          child: GestureDetector(
            onTap: () => onChanged(index),
            child: Container(
              margin: EdgeInsets.only(
                right: index == labels.length - 1 ? 0 : 8,
              ),
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF12B8A6) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: isSelected
                    ? null
                    : Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Text(
                labels[index],
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? Colors.white : const Color(0xFF111827),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  // ---------- ACTIVITY TILE ----------
  Widget _activityTile(
    String title,
    String subtitle, {
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF1F2937) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: selected ? null : Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                color: selected ? Colors.white : const Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: selected ? Colors.white.withOpacity(0.7) : const Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
