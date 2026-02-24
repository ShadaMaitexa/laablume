import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/patient_provider.dart';
import '../../models/health_metric_model.dart';
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PatientProvider>().loadHealthMetrics();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: Color(0xFF111827),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Health Metrics',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF111827),
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<PatientProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.healthMetrics.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF12B8A6)),
            );
          }

          final metrics = provider.healthMetrics;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              children: [
                _buildSection(
                  title: 'Body Parameters',
                  icon: Icons.monitor_weight_outlined,
                  onAdd: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BodyParametersScreen(),
                    ),
                  ),
                  content: _buildBodyParamsContent(metrics),
                ),
                const SizedBox(height: 24),
                _buildSection(
                  title: 'Lifestyle',
                  icon: Icons.wb_sunny_outlined,
                  onAdd: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LifestyleScreen(),
                    ),
                  ),
                  content: _buildLifestyleContent(metrics),
                ),
                const SizedBox(height: 24),
                _buildSection(
                  title: 'Anamnesis',
                  icon: Icons.history_edu_outlined,
                  onAdd: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AnamnesisScreen(),
                    ),
                  ),
                  content: _buildAnamnesisContent(metrics),
                ),
                const SizedBox(height: 24),
                _buildSection(
                  title: 'Notes',
                  icon: Icons.sticky_note_2_outlined,
                  onAdd: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotesScreen(),
                    ),
                  ),
                  content: _buildNotesContent(metrics),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required VoidCallback onAdd,
    required Widget content,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF12B8A6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: const Color(0xFF12B8A6), size: 20),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF111827),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: onAdd,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 18,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(color: Color(0xFFF3F4F6), height: 1),
          const SizedBox(height: 20),
          content,
        ],
      ),
    );
  }

  String? _getMetricValue(List<HealthMetric> metrics, String type) {
    try {
      final m = metrics
          .where((m) => m.type.toLowerCase() == type.toLowerCase())
          .toList();
      if (m.isEmpty) return null;
      m.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      return m.first.value;
    } catch (e) {
      return null;
    }
  }

  Widget _buildBodyParamsContent(List<HealthMetric> metrics) {
    final height = _getMetricValue(metrics, 'height');
    final weight = _getMetricValue(metrics, 'weight');
    final bmi = _getMetricValue(metrics, 'bmi');
    final oxygen = _getMetricValue(metrics, 'oxygen');
    final bp = _getMetricValue(metrics, 'blood_pressure');
    final hr = _getMetricValue(metrics, 'heart_rate');
    final bt = _getMetricValue(metrics, 'blood_type');

    if (height == null && weight == null && oxygen == null)
      return _emptyState();

    return Column(
      children: [
        _buildMetricRow('Height', height != null ? '$height cm' : '--'),
        _buildMetricRow('Weight', weight != null ? '$weight kg' : '--'),
        _buildMetricRow('BMI', bmi ?? '--'),
        _buildMetricRow('Oxygen', oxygen != null ? '$oxygen %' : '--'),
        _buildMetricRow('Blood pressure', bp ?? '--'),
        _buildMetricRow('Heart rate', hr != null ? '$hr bpm' : '--'),
        _buildMetricRow('Blood type', bt ?? '--'),
      ],
    );
  }

  Widget _buildLifestyleContent(List<HealthMetric> metrics) {
    final sleep = _getMetricValue(metrics, 'sleep');
    final water = _getMetricValue(metrics, 'water');
    final smoking = _getMetricValue(metrics, 'smoking');
    final alcohol = _getMetricValue(metrics, 'alcohol');
    final activity = _getMetricValue(metrics, 'activity');

    if (sleep == null && water == null && smoking == null) return _emptyState();

    return Column(
      children: [
        _buildMetricRow('Sleep', sleep != null ? '$sleep h' : '--'),
        _buildMetricRow('Water intake', water != null ? '$water L' : '--'),
        _buildMetricRow('Smoking', smoking ?? '--'),
        _buildMetricRow('Alcohol', alcohol ?? '--'),
        _buildMetricRow('Activity Level', activity ?? '--'),
      ],
    );
  }

  Widget _buildAnamnesisContent(List<HealthMetric> metrics) {
    final chronic = _getMetricValue(metrics, 'chronic');
    final allergies = _getMetricValue(metrics, 'allergies');

    if (chronic == null && allergies == null) return _emptyState();

    return Column(
      children: [
        _buildMetricRow('Chronic conditions', chronic ?? '--'),
        _buildMetricRow('Allergies', allergies ?? '--'),
      ],
    );
  }

  Widget _buildNotesContent(List<HealthMetric> metrics) {
    final notes = _getMetricValue(metrics, 'notes');
    if (notes == null || notes.isEmpty) return _emptyState();
    return Text(
      notes,
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: const Color(0xFF6B7280),
        height: 1.6,
      ),
    );
  }

  Widget _emptyState() {
    return Text(
      'No data added yet',
      style: GoogleFonts.poppins(
        fontSize: 13,
        color: const Color(0xFF9CA3AF),
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Widget _buildMetricRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF6B7280),
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
