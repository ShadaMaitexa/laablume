import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/patient_provider.dart';
import 'doctor_detail_screen.dart';

class SearchDoctorsScreen extends StatefulWidget {
  const SearchDoctorsScreen({super.key});

  @override
  State<SearchDoctorsScreen> createState() => _SearchDoctorsScreenState();
}

class _SearchDoctorsScreenState extends State<SearchDoctorsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedSpecialty = 'All';
  List<dynamic> _doctors = [];
  bool _isLoading = true;

  final List<String> _specialties = [
    'All',
    'General Physician',
    'Cardiologist',
    'Dermatologist',
    'Pediatrician',
    'Gynecologist',
    'Neurologist',
    'Orthopedic',
  ];

  @override
  void initState() {
    super.initState();
    _fetchDoctors();
  }

  Future<void> _fetchDoctors() async {
    setState(() => _isLoading = true);
    final provider = context.read<PatientProvider>();
    final results = await provider.searchDoctors(
      search: _searchController.text.isEmpty ? null : _searchController.text,
      specialty: _selectedSpecialty == 'All' ? null : _selectedSpecialty,
    );
    setState(() {
      _doctors = results;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: Text(
          'Find Doctors',
          style: GoogleFonts.poppins(
            color: const Color(0xFF111827),
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                _buildSearchField(),
                const SizedBox(height: 20),
                _buildSpecialtyFilter(),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator(color: Color(0xFF12B8A6)))
                : _doctors.isEmpty
                    ? _buildEmptyState()
                    : _buildDoctorsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onSubmitted: (_) => _fetchDoctors(),
        decoration: InputDecoration(
          hintText: 'Search doctors...',
          hintStyle: GoogleFonts.poppins(color: const Color(0xFF9CA3AF)),
          prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF9CA3AF)),
          suffixIcon: IconButton(
            icon: const Icon(Icons.tune_rounded, color: Color(0xFF12B8A6)),
            onPressed: _fetchDoctors,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }

  Widget _buildSpecialtyFilter() {
    return SizedBox(
      height: 45,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _specialties.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final specialty = _specialties[index];
          final isSelected = _selectedSpecialty == specialty;
          return GestureDetector(
            onTap: () {
              setState(() => _selectedSpecialty = specialty);
              _fetchDoctors();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF12B8A6) : Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: isSelected ? const Color(0xFF12B8A6) : const Color(0xFFE5E7EB),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                specialty,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? Colors.white : const Color(0xFF6B7280),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_search_rounded, size: 80, color: const Color(0xFFD1D5DB)),
          const SizedBox(height: 16),
          Text(
            'No doctors found',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF4B5563),
            ),
          ),
          Text(
            'Try adjusting your filters',
            style: GoogleFonts.poppins(
              color: const Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: _doctors.length,
      itemBuilder: (context, index) {
        final doctor = _doctors[index];
        return _doctorCard(doctor);
      },
    );
  }

  Widget _doctorCard(Map<String, dynamic> doctor) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DoctorDetailScreen(doctor: doctor),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF111827).withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor: const Color(0xFFEAF8F6),
              child: const Icon(Icons.person_rounded, size: 35, color: Color(0xFF12B8A6)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor['name'] ?? 'Doctor Name',
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF111827),
                    ),
                  ),
                  Text(
                    doctor['specialty'] ?? 'Specialty',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 18),
                      const SizedBox(width: 4),
                      Text(
                        (doctor['rating'] ?? 4.8).toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.work_outline_rounded, color: Color(0xFF12B8A6), size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${doctor['experience'] ?? 5}+ Yrs',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DoctorDetailScreen(doctor: doctor),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF12B8A6),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: Text(
                'Book Now',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
