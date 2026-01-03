import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnamnesisScreen extends StatefulWidget {
  const AnamnesisScreen({super.key});

  @override
  State<AnamnesisScreen> createState() => _AnamnesisScreenState();
}

class _AnamnesisScreenState extends State<AnamnesisScreen> {
  final TextEditingController chronicController = TextEditingController(text: 'Migraines, Mild Asthma');
  final TextEditingController allergiesController = TextEditingController(text: 'Peanuts, Penicillin');
  final TextEditingController surgeriesController = TextEditingController();
  final TextEditingController familyHistoryController = TextEditingController();

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
          'Anamnesis',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF111827),
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Medical history updated!')),
              );
              Navigator.pop(context);
            },
            child: Text(
              'Save',
              style: GoogleFonts.poppins(
                color: const Color(0xFF12B8A6),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('Chronic Conditions', Icons.medical_services_outlined),
                _buildInputField(
                  controller: chronicController,
                  hint: 'List your long-term conditions...',
                ),
                const SizedBox(height: 32),
                _buildSectionHeader('Allergies', Icons.warning_amber_rounded),
                _buildInputField(
                  controller: allergiesController,
                  hint: 'List drug or food allergies...',
                ),
                const SizedBox(height: 32),
                 _buildSectionHeader('Past Surgeries', Icons.healing_outlined),
                _buildInputField(
                  controller: surgeriesController,
                  hint: 'Any major surgical procedures...',
                ),
                const SizedBox(height: 32),
                _buildSectionHeader('Family History', Icons.people_outline_rounded),
                _buildInputField(
                  controller: familyHistoryController,
                  hint: 'Significant conditions in your family...',
                ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF12B8A6).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF12B8A6).withOpacity(0.2)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline_rounded, color: Color(0xFF12B8A6)),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'This information helps our AI and doctors give you more personalized health advice.',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF0D9488),
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF12B8A6)),
          const SizedBox(width: 10),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1F2937),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({required TextEditingController controller, required String hint}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: 3,
        style: GoogleFonts.poppins(fontSize: 14, color: const Color(0xFF1F2937)),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.poppins(color: const Color(0xFF9CA3AF), fontSize: 13),
          contentPadding: const EdgeInsets.all(20),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
