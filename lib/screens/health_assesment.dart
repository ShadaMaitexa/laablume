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
      backgroundColor: const Color(0xFFEFF7F6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              // Green tab
              Center(
                child: Row(mainAxisAlignment: 
                    MainAxisAlignment.center  ,
                  children: [
                    Container(
                      width: 32,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFF12B8A6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 32,
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0xFF12B8A6),
                          borderRadius: BorderRadius.circular(4),
                        ),),
                    ),  Container(
                      width: 32,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFF12B8A6),
                        borderRadius: BorderRadius.circular(4),
                      ),),  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                        width: 32,
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 185, 231, 224),
                          borderRadius: BorderRadius.circular(4),
                        ),),
                      ),  Container(
                      width: 32,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 185, 231, 224),
                        borderRadius: BorderRadius.circular(4),
                      ),),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              Text(
                'Health Assessment',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                'Provide the health data to enhance\nyour medical experience',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: const Color(0xFF6B7280),
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 24),

              // Blood type
              Text(
                'Blood type',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _bloodCard('O', 'I'),
                  _bloodCard('A', 'II'),
                  _bloodCard('B', 'III'),
                  _bloodCard('AB', 'IV'),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(child: _rhPill('+')),
                  const SizedBox(width: 12),
                  Expanded(child: _rhPill('-')),
                ],
              ),

              const SizedBox(height: 20),

              // Allergies Input Field
              _buildInputField(
                label: 'Allergies',
                controller: allergiesController,
                hint: 'Enter any allergies (e.g., Peanuts, Pollen)',
              ),

              // Chronic Conditions Input Field
              _buildInputField(
                label: 'Chronic conditions',
                controller: chronicConditionsController,
                hint: 'Enter any chronic conditions (e.g., Migraines, Diabetes)',
              ),

              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      label: 'Your height (cm)',
                      controller: heightController,
                      hint: '172',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildInputField(
                      label: 'Your weight (kg)',
                      controller: weightController,
                      hint: '85',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              Text(
                'Blood pressure (mmHg)',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 6),

              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      label: 'Systolic',
                      controller: systolicBPController,
                      hint: '120',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildInputField(
                      label: 'Diastolic',
                      controller: diastolicBPController,
                      hint: '80',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Next button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _validateAndProceed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF12B8A6),
                    shape: const StadiumBorder(),
                    elevation: 0,
                  ),
                  child: Text(
                    'Next',
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
      ),
    );
  }

  // Generic Input Field Widget
  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: GoogleFonts.poppins(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 13,
                ),
                border: InputBorder.none,
              ),
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.black,
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
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF12B8A6) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: isSelected 
              ? null 
              : Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.water_drop_outlined,
              color: isSelected
                  ? Colors.white
                  : const Color(0xFF12B8A6),
            ),
            const SizedBox(height: 6),
            Text(
              '$label ($roman)',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : Colors.black,
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
          'Rh $rh',
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
