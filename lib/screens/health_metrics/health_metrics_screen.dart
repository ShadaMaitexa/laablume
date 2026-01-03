import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'body_parameters_screen.dart';
import 'lifestyle_screen.dart';
import 'anamnesis_screen.dart';
import 'notes_screen.dart';

class HealthMetricsScreen extends StatefulWidget {
  const HealthMetricsScreen({super.key});

  @override
  State<HealthMetricsScreen> createState() => _HealthMetricsScreenState();
}

class _HealthMetricsScreenState extends State<HealthMetricsScreen> {
  // Mock data - in a real app, this would come from a provider or database
  Map<String, dynamic> metrics = {
    'body_parameters': {
      'height': '172',
      'weight': '72',
      'bmi': '24.3',
      'oxygen': '91',
      'blood_pressure': '120/80',
      'heart_rate': '71',
      'blood_type': 'B+',
    },
    'lifestyle': {
      'sleep': '7-8',
      'water': '1-1.5',
      'smoking': 'No',
      'alcohol': 'Occasionally',
      'activity': 'Moderate',
    },
    'anamnesis': {
      'chronic': 'Migraines',
      'allergies': 'Peanuts',
    },
    'notes': 'I\'ve been having headaches almost every day, mostly in the afternoon. They are mild to moderate and usually go away after I take some painkillers.',
  };

  bool get hasData => true; // For demonstration

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
          'Health metrics',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1F2937),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, size: 22, color: Color(0xFF1F2937)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildSection(
              title: 'Body parameters',
              onAdd: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const BodyParametersScreen())),
              content: _buildBodyParamsContent(),
            ),
            const SizedBox(height: 16),
            _buildSection(
              title: 'Lifestyle',
              onAdd: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LifestyleScreen())),
              content: _buildLifestyleContent(),
            ),
            const SizedBox(height: 16),
            _buildSection(
              title: 'Anamnesis',
              onAdd: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AnamnesisScreen())),
              content: _buildAnamnesisContent(),
            ),
            const SizedBox(height: 16),
            _buildSection(
              title: 'Notes',
              onAdd: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NotesScreen())),
              content: _buildNotesContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required VoidCallback onAdd, required Widget content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF6B7280),
              ),
            ),
            TextButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add, size: 16, color: Color(0xFF12B8A6)),
              label: Text(
                'Add',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF12B8A6),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: content,
        ),
      ],
    );
  }

  Widget _buildBodyParamsContent() {
    final params = metrics['body_parameters'];
    return Column(
      children: [
        _buildMetricRow('Your height (cm)', params['height']),
        _buildMetricRow('Your weight (kg)', params['weight']),
        _buildMetricRow('Body mass index', params['bmi']),
        _buildMetricRow('Oxygen Saturation (%)', params['oxygen']),
        _buildMetricRow('Blood pressure (mmHg)', params['blood_pressure']),
        _buildMetricRow('Heart rate (bpm)', params['heart_rate']),
        _buildMetricRow('Blood type', params['blood_type']),
      ],
    );
  }

  Widget _buildLifestyleContent() {
    final lifestyle = metrics['lifestyle'];
    return Column(
      children: [
        _buildMetricRow('Sleep (h)', lifestyle['sleep']),
        _buildMetricRow('Water intake (L)', lifestyle['water']),
        _buildMetricRow('Smoking', lifestyle['smoking']),
        _buildMetricRow('Alcohol', lifestyle['alcohol']),
        _buildMetricRow('Activity Level', lifestyle['activity']),
      ],
    );
  }

  Widget _buildAnamnesisContent() {
    final anamnesis = metrics['anamnesis'];
    return Column(
      children: [
        _buildMetricRow('Chronic conditions', anamnesis['chronic']),
        _buildMetricRow('Allergies', anamnesis['allergies']),
      ],
    );
  }

  Widget _buildNotesContent() {
    return Text(
      metrics['notes'],
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: const Color(0xFF4B5563),
        height: 1.6,
      ),
    );
  }

  Widget _buildMetricRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: const Color(0xFF9CA3AF),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF111827),
            ),
          ),
        ],
      ),
    );
  }
}
