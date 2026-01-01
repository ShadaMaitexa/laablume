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
      backgroundColor: const Color(0xFFEFF7F6),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFEFF7F6),
        leading: const Icon(
          Icons.arrow_back_ios,
          size: 18,
          color: Colors.black,
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Handle skip action
              _showSnackBar('Lifestyle information skipped');
            },
            child: Text(
              'Skip',
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: const Color(0xFF12B8A6),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            // Green tab indicator
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 32,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFF12B8A6),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 32,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFF12B8A6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  Container(
                    width: 32,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFF12B8A6),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 32,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFF12B8A6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  Container(
                    width: 32,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 185, 231, 224),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Title
            Text(
              'Lifestyle information',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 6),

            // Subtitle
            Text(
              'Sharing lifestyle details helps doctors tailor\nadvice and treatment to your health needs.',
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: const Color(0xFF6B7280),
                height: 1.4,
              ),
            ),

            const SizedBox(height: 24),

            // Smoking
            _sectionTitle('Smoking'),
            _pillRow(
              const ['Yes', 'No', 'Occasionally'],
              selectedIndex: _selectedSmokingIndex,
              onChanged: (index) {
                setState(() {
                  _selectedSmokingIndex = index;
                });
              },
            ),

            const SizedBox(height: 20),

            // Alcohol
            _sectionTitle('Alcohol'),
            _pillRow(
              const ['Yes', 'No', 'Occasionally'],
              selectedIndex: _selectedAlcoholIndex,
              onChanged: (index) {
                setState(() {
                  _selectedAlcoholIndex = index;
                });
              },
            ),

            const SizedBox(height: 20),

            // Activity level
            _sectionTitle('Activity Level'),
            _activityTile(
              'Light (sports 1–3 days a week)',
              selected: _selectedActivityIndex == 0,
              onTap: () {
                setState(() {
                  _selectedActivityIndex = 0;
                });
              },
            ),
            _activityTile(
              'Moderate (sports 3–5 days a week)',
              selected: _selectedActivityIndex == 1,
              onTap: () {
                setState(() {
                  _selectedActivityIndex = 1;
                });
              },
            ),
            _activityTile(
              'Very Active (sports 6–7 days a week)',
              selected: _selectedActivityIndex == 2,
              onTap: () {
                setState(() {
                  _selectedActivityIndex = 2;
                });
              },
            ),

            const SizedBox(height: 24),

            // Next button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  // Handle next action
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
                  shape: const StadiumBorder(),
                  elevation: 0,
                ),
                child: Text(
                  'Save Information',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  // ---------- SECTION TITLE ----------
  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF6B7280)),
    );
  }

  // ---------- PILL ROW ----------
  Widget _pillRow(
    List<String> labels, {
    required int selectedIndex,
    required Function(int) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: List.generate(labels.length, (index) {
          final isSelected = index == selectedIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(index),
              child: Container(
                margin: EdgeInsets.only(
                  right: index == labels.length - 1 ? 0 : 8,
                ),
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF12B8A6) : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: isSelected
                      ? null
                      : Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Text(
                  labels[index],
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ---------- ACTIVITY TILE ----------
  Widget _activityTile(
    String text, {
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF12B8A6) : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: selected ? null : Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: selected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
