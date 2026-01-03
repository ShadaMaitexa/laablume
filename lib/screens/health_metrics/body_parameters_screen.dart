import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BodyParametersScreen extends StatefulWidget {
  const BodyParametersScreen({super.key});

  @override
  State<BodyParametersScreen> createState() => _BodyParametersScreenState();
}

class _BodyParametersScreenState extends State<BodyParametersScreen> {
  final TextEditingController heightController = TextEditingController(text: '172');
  final TextEditingController weightController = TextEditingController(text: '72');
  final TextEditingController oxygenController = TextEditingController(text: '91');
  final TextEditingController heartRateController = TextEditingController(text: '71');
  final TextEditingController sysController = TextEditingController(text: '120');
  final TextEditingController diaController = TextEditingController(text: '80');
  
  String selectedBloodType = 'B (III)';
  bool isPositiveRh = true;

  final List<String> bloodTypes = ['0 (I)', 'A (II)', 'B (III)', 'AB (IV)'];

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
          'Body parameters',
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
            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    label: 'Your height (cm)',
                    controller: heightController,
                    hint: '170',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildInputField(
                    label: 'Your weight (kg)',
                    controller: weightController,
                    hint: '70',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildInputField(
              label: 'Oxygen Saturation (%)',
              controller: oxygenController,
              hint: '98',
            ),
            const SizedBox(height: 24),
            _buildInputField(
              label: 'Heart rate (bpm)',
              controller: heartRateController,
              hint: '72',
            ),
            const SizedBox(height: 24),
            Text(
              'Blood pressure (mmHg)',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF4B5563),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextField(
                      controller: sysController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '120',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    '/',
                    style: GoogleFonts.poppins(fontSize: 20, color: const Color(0xFF9CA3AF)),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextField(
                      controller: diaController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '80',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              'Blood type',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF4B5563),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: bloodTypes.map((type) => _buildBloodTypeButton(type)).toList(),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildRhButton(true),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildRhButton(false),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({required String label, required TextEditingController controller, required String hint}) {
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
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: GoogleFonts.poppins(color: const Color(0xFF9CA3AF)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBloodTypeButton(String type) {
    bool isSelected = selectedBloodType == type;
    return GestureDetector(
      onTap: () => setState(() => selectedBloodType = type),
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF12B8A6) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? null : Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.water_drop_outlined,
              color: isSelected ? Colors.white : const Color(0xFF12B8A6),
              size: 20,
            ),
            const SizedBox(height: 4),
            Text(
              type,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : const Color(0xFF4B5563),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRhButton(bool positive) {
    bool isSelected = isPositiveRh == positive;
    return GestureDetector(
      onTap: () => setState(() => isPositiveRh = positive),
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF12B8A6) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: isSelected ? null : Border.all(color: const Color(0xFFE5E7EB)),
        ),
        alignment: Alignment.center,
        child: Text(
          positive ? 'Rh +' : 'Rh -',
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF4B5563),
          ),
        ),
      ),
    );
  }
}
