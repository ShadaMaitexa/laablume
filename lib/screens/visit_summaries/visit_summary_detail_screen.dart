import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VisitSummaryDetailScreen extends StatelessWidget {
  const VisitSummaryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF7F6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Color(0xFF1F2937)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Visit summaries',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1F2937),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.print_outlined, size: 22, color: Color(0xFF1F2937)),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined, size: 22, color: Color(0xFF1F2937)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Appointment Details Section
            _buildSectionHeader('Appointment details'),
            const SizedBox(height: 16),
            _buildAppointmentCard(),
            
            const SizedBox(height: 32),
            
            // Visit Reason Section
            _buildSectionHeader('Visit Reason'),
            const SizedBox(height: 16),
            _buildReasonSection(),
            
            const SizedBox(height: 32),
            
            // Examination Section
            _buildSectionHeader('Examination'),
            const SizedBox(height: 16),
            _buildExaminationItem('Complete Blood Count (CBC)', 'Not examined', isPending: true),
            const SizedBox(height: 16),
            _buildExaminationItem('Complete Blood Count (CBC)', '30 Jan 2024 - Results within normal low', hasDate: true),
            const SizedBox(height: 16),
            _buildExaminationItemWithActions('Complete Blood Count (CBC)', '30 Jan 2024 - Normal results'),
            const SizedBox(height: 16),
            _buildExaminationItemWithActions('Thyroid Function Test', '30 Jan 2024 - Follow-up needed', isAlert: true),
            
            const SizedBox(height: 32),
            
            // Prescriptions Section
            _buildSectionHeader('Prescriptions'),
            const SizedBox(height: 16),
            _buildPrescriptionItem('Pumoxin 500mg', 'Antibiotic for bacterial infections', '14 capsules', '14 - 30 May, 2014'),
            const SizedBox(height: 16),
            _buildPrescriptionItem('Lisinopril 10mg', 'ACE Inhibitor', '10 tablets', '12 - 30 April, 2014'),
            
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF1F2937),
      ),
    );
  }

  Widget _buildAppointmentCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF12B8A6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.person_rounded, color: Color(0xFF12B8A6), size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. Charlotte Elizabeth Montgomery',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1F2937),
                      ),
                    ),
                    Text(
                      'Cardiologist',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildInfoRow(Icons.calendar_today_outlined, 'Date:', '17 Nov 2023'),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.access_time_outlined, 'Time:', '11:00 - 11:45 PM'),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.location_on_outlined, 'Type:', 'In-person'),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.medical_services_outlined, 'Location:', 'Mercy Heart Institute', isLink: true),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, {bool isLink = false}) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF9CA3AF)),
        const SizedBox(width: 12),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF9CA3AF),
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isLink ? const Color(0xFF12B8A6) : const Color(0xFF1F2937),
            decoration: isLink ? TextDecoration.underline : null,
          ),
        ),
      ],
    );
  }

  Widget _buildReasonSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.description_outlined, size: 18, color: Color(0xFF12B8A6)),
              const SizedBox(width: 8),
              Text(
                'Anamnesis',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1F2937),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'History of hypertension for 12 years, improved with medications. Diagnosed with type 2 diabetes 5 years ago.',
            style: GoogleFonts.poppins(
              fontSize: 13,
              height: 1.6,
              color: const Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Icon(Icons.sick_outlined, size: 18, color: Color(0xFF12B8A6)),
              const SizedBox(width: 8),
              Text(
                'Symptoms',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1F2937),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildSymptomChip('Shortness of breath'),
              _buildSymptomChip('Blue-tinged lips'),
              _buildSymptomChip('Pain in the back'),
              _buildSymptomChip('Pressure in the chest'),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Icon(Icons.assignment_turned_in_outlined, size: 18, color: Color(0xFF12B8A6)),
              const SizedBox(width: 8),
              Text(
                'Diagnosis',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1F2937),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Atrial fibrillation',
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF4B5563),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSymptomChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF7F6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF12B8A6).withOpacity(0.2)),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF4B5563),
        ),
      ),
    );
  }

  Widget _buildExaminationItem(String title, String subtitle, {bool isPending = false, bool hasDate = false}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1F2937),
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isPending ? const Color(0xFF9CA3AF) : const Color(0xFF12B8A6),
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.more_vert_rounded, color: Color(0xFF9CA3AF)),
        ],
      ),
    );
  }

  Widget _buildExaminationItemWithActions(String title, String subtitle, {bool isAlert = false}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1F2937),
                      ),
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isAlert ? Colors.red : const Color(0xFF12B8A6),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.more_vert_rounded, color: Color(0xFF9CA3AF)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(Icons.visibility_outlined, 'View report', true),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionButton(Icons.file_download_outlined, 'Download', false),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, bool isPrimary) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: isPrimary ? const Color(0xFF12B8A6) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isPrimary ? null : Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: isPrimary ? Colors.white : const Color(0xFF4B5563)),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isPrimary ? Colors.white : const Color(0xFF4B5563),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrescriptionItem(String name, String desc, String count, String dates) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF12B8A6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.medication_outlined, color: Color(0xFF12B8A6), size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1F2937),
                      ),
                    ),
                    Text(
                      desc,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.more_vert_rounded, color: Color(0xFF9CA3AF)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                count,
                style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFF4B5563)),
              ),
              Text(
                dates,
                style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFF9CA3AF)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
