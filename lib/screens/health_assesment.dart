import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laablume/screens/_cycle_assesment.dart';

class HealthAssessmentScreen extends StatefulWidget {
  const HealthAssessmentScreen({super.key});

  @override
  State<HealthAssessmentScreen> createState() =>
      _HealthAssessmentScreenState();
}

class _HealthAssessmentScreenState extends State<HealthAssessmentScreen> {
  String selectedBlood = 'B';
  String selectedRh = '+';
  
  // Text editing controllers for input fields
  final TextEditingController allergiesController = TextEditingController();
  final TextEditingController chronicConditionsController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController systolicBPController = TextEditingController();
  final TextEditingController diastolicBPController = TextEditingController();

  @override
  void dispose() {
    allergiesController.dispose();
    chronicConditionsController.dispose();
    heightController.dispose();
    weightController.dispose();
    systolicBPController.dispose();
    diastolicBPController.dispose();
    super.dispose();
  }

  void _validateAndProceed() {
    if (heightController.text.trim().isEmpty) {
      _showSnackBar('Please enter your height');
      return;
    }

    if (weightController.text.trim().isEmpty) {
      _showSnackBar('Please enter your weight');
      return;
    }

    if (systolicBPController.text.trim().isEmpty) {
      _showSnackBar('Please enter systolic blood pressure');
      return;
    }

    if (diastolicBPController.text.trim().isEmpty) {
      _showSnackBar('Please enter diastolic blood pressure');
      return;
    }

    // All validations passed, proceed to next screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LifestyleInformationScreen(),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

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
        title: _buildProgressBar(3, 5),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LifestyleInformationScreen()),
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
                'Health Assessment',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Provide the health data to enhance your medical experience.',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  height: 1.5,
                  color: const Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 32),

              // Blood type
              Text(
                'Blood type',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _bloodCard('O', 'I'),
                  _bloodCard('A', 'II'),
                  _bloodCard('B', 'III'),
                  _bloodCard('AB', 'IV'),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _rhPill('+')),
                  const SizedBox(width: 12),
                  Expanded(child: _rhPill('-')),
                ],
              ),
              const SizedBox(height: 32),

              // Form Fields
              _buildModernInputField(
                label: 'Allergies',
                controller: allergiesController,
                hint: 'e.g. Peanuts, Pollen (optional)',
              ),
              _buildModernInputField(
                label: 'Chronic conditions',
                controller: chronicConditionsController,
                hint: 'e.g. Migraines, Diabetes (optional)',
              ),

              Row(
                children: [
                  Expanded(
                    child: _buildModernInputField(
                      label: 'Height (cm)',
                      controller: heightController,
                      hint: '172',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildModernInputField(
                      label: 'Weight (kg)',
                      controller: weightController,
                      hint: '85',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),

              Text(
                'Blood pressure (mmHg)',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildModernInputField(
                      label: 'Systolic',
                      controller: systolicBPController,
                      hint: '120',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildModernInputField(
                      label: 'Diastolic',
                      controller: diastolicBPController,
                      hint: '80',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Next Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _validateAndProceed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF12B8A6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Next',
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

  Widget _buildModernInputField({
    required String label,
    required TextEditingController controller,
    required String hint,
    Widget? prefix,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              maxLines: maxLines,
              style: GoogleFonts.poppins(fontSize: 14),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: GoogleFonts.poppins(color: const Color(0xFF9CA3AF), fontSize: 14),
                prefixIcon: prefix != null ? Padding(padding: const EdgeInsets.only(left: 16), child: prefix) : null,
                prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- BLOOD CARD ----------------
  Widget _bloodCard(String label, String roman) {
    final isSelected = selectedBlood == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedBlood = label;
        });
      },
      child: Container(
        width: 76,
        height: 76,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF12B8A6) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isSelected ? [
            BoxShadow(
              color: const Color(0xFF12B8A6).withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ] : [],
          border: isSelected 
              ? null 
              : Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.water_drop_rounded,
              size: 20,
              color: isSelected ? Colors.white : const Color(0xFF12B8A6),
            ),
            const SizedBox(height: 8),
            Text(
              '$label ($roman)',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? Colors.white : const Color(0xFF111827),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- RH PILL ----------------
  Widget _rhPill(String rh) {
    final isSelected = selectedRh == rh;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRh = rh;
        });
      },
      child: Container(
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1F2937) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: isSelected 
              ? null 
              : Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Text(
          'Rh $rh',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xFF111827),
          ),
        ),
      ),
    );
  }
}
