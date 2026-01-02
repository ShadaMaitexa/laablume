import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PatientReportView extends StatelessWidget {
  const PatientReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(width: 8),
              Text(
                'Report Analysis - Alice Brown',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Report Visualization
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _reportParameter('Hemoglobin', '12.5 g/dL', '13.0 - 17.0', Colors.red),
                    _reportParameter('WBC Count', '7,500 /uL', '4,000 - 11,000', Colors.green),
                    _reportParameter('Platelets', '2.5 L/uL', '1.5 - 4.5', Colors.green),
                    _reportParameter('RBC Count', '4.2 M/uL', '4.5 - 5.5', Colors.orange),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              // AI Summary & Doctor Notes
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    _aiSummary(),
                    const SizedBox(height: 20),
                    _doctorNotesSection(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _reportParameter(String name, String value, String range, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
              Text('Normal: $range', style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF6B7280))),
            ],
          ),
          Text(value, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _aiSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF12B8A6).withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF12B8A6).withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: Color(0xFF12B8A6), size: 20),
              const SizedBox(width: 8),
              Text(
                'AI Analysis Summary',
                style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFF12B8A6)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'The patient shows a slightly lower than average Hemoglobin count (12.5 g/dL). This could indicate mild anemia. All other parameters are within the normal range.',
            style: GoogleFonts.poppins(fontSize: 13, height: 1.5, color: const Color(0xFF1F2937)),
          ),
        ],
      ),
    );
  }

  Widget _doctorNotesSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Doctor Observations', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          const TextField(
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Enter your findings and prescriptions...',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(12),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Report saved and transmitted to patient successfully!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF12B8A6),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Save & Send to Patient'),
            ),
          ),
        ],
      ),
    );
  }
}
