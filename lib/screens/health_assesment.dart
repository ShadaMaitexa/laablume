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

              _ovalField('Allergies', 'Peanuts'),
              _ovalField('Chronic conditions', 'Migraines'),

              Row(
                children: [
                  Expanded(
                      child:
                          _ovalField('Your height (cm)', '172 cm')),
                  const SizedBox(width: 12),
                  Expanded(
                      child:
                          _ovalField('Your weight (kg)', '85 kg')),
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
                  Expanded(child: _ovalBox('120')),
                  const SizedBox(width: 12),
                  Expanded(child: _ovalBox('80')),
                ],
              ),

              const SizedBox(height: 24),

              // Next button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const LifestyleInformationScreen(),));},
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

  // ---------------- BLOOD CARD ----------------
  Widget _bloodCard(String label, String roman) {
    final isSelected = selectedBlood == label;

    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF12B8A6) : Colors.white,
        borderRadius: BorderRadius.circular(16),
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
    );
  }

  // ---------------- RH PILL ----------------
  Widget _rhPill(String rh) {
    final isSelected = selectedRh == rh;

    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF12B8A6) : Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        'Rh $rh',
        style: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  // ---------------- OVAL FIELD ----------------
  Widget _ovalField(String label, String value) {
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
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              value,
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

  // ---------------- BP BOX ----------------
  Widget _ovalBox(String value) {
    return Container(
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        value,
        style: GoogleFonts.poppins(
          fontSize: 13,
          color: Colors.black,
        ),
      ),
    );
  }
}
