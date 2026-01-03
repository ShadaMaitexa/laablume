import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LifestyleScreen extends StatefulWidget {
  const LifestyleScreen({super.key});

  @override
  State<LifestyleScreen> createState() => _LifestyleScreenState();
}

class _LifestyleScreenState extends State<LifestyleScreen> {
  String sleepHours = '7-8';
  String waterIntake = '1-1.5';
  String smoking = 'No';
  String alcohol = 'Occasionally';
  String activityLevel = 'Moderate (sports 3-5 days a week)';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF7F6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: GoogleFonts.poppins(
              color: const Color(0xFF12B8A6),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        title: Text(
          'Lifestyle',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1F2937),
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Save',
              style: GoogleFonts.poppins(
                color: const Color(0xFF12B8A6),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSelectionGroup(
              label: 'Sleep (h)',
              options: ['<7', '7-8', '8+'],
              selectedValue: sleepHours,
              onSelected: (val) => setState(() => sleepHours = val),
            ),
            const SizedBox(height: 32),
            _buildSelectionGroup(
              label: 'Water intake (L)',
              options: ['<1', '1-1.5', '>1.5'],
              selectedValue: waterIntake,
              onSelected: (val) => setState(() => waterIntake = val),
            ),
            const SizedBox(height: 32),
            _buildSelectionGroup(
              label: 'Smoking',
              options: ['Yes', 'No', 'Occasionally'],
              selectedValue: smoking,
              onSelected: (val) => setState(() => smoking = val),
            ),
            const SizedBox(height: 32),
            _buildSelectionGroup(
              label: 'Alcohol',
              options: ['Yes', 'No', 'Occasionally'],
              selectedValue: alcohol,
              onSelected: (val) => setState(() => alcohol = val),
            ),
            const SizedBox(height: 32),
            Text(
              'Activity Level',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF4B5563),
              ),
            ),
            const SizedBox(height: 12),
            _buildActivityButton('Light (sports 1-3 days a week)'),
            const SizedBox(height: 12),
            _buildActivityButton('Moderate (sports 3-5 days a week)'),
            const SizedBox(height: 12),
            _buildActivityButton('Very Active (sports 6-7 days a week)'),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionGroup({
    required String label,
    required List<String> options,
    required String selectedValue,
    required Function(String) onSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF4B5563),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: options.map((opt) {
            bool isSelected = selectedValue == opt;
            return Expanded(
              child: GestureDetector(
                onTap: () => onSelected(opt),
                child: Container(
                  height: 54,
                  margin: EdgeInsets.only(
                    right: opt == options.last ? 0 : 8,
                    left: opt == options.first ? 0 : 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF12B8A6) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    opt,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : const Color(0xFF4B5563),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildActivityButton(String level) {
    bool isSelected = activityLevel == level;
    return GestureDetector(
      onTap: () => setState(() => activityLevel = level),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF12B8A6) : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(
          level,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF4B5563),
          ),
        ),
      ),
    );
  }
}
