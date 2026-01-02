import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'doctor_detail_screen.dart';

class FindDoctorsScreen extends StatefulWidget {
  const FindDoctorsScreen({super.key});

  @override
  State<FindDoctorsScreen> createState() => _FindDoctorsScreenState();
}

class _FindDoctorsScreenState extends State<FindDoctorsScreen> {
  String _selectedSpecialty = 'All';
  String _searchQuery = '';

  final List<String> _specialties = [
    'All',
    'General Physician',
    'Cardiologist',
    'Dermatologist',
    'Pediatrician',
    'Orthopedic',
    'Gynecologist',
  ];

  // API READY - Fetch doctors
  Future<List<Doctor>> fetchDoctors() async {
    // TODO: Replace with actual API call
    await Future.delayed(const Duration(milliseconds: 500));
    
    return [
      Doctor(
        id: '1',
        name: 'Dr. Sarah Wilson',
        specialty: 'Cardiologist',
        experience: 15,
        rating: 4.8,
        reviewCount: 245,
        consultationFee: 500,
        nextAvailable: DateTime.now().add(const Duration(hours: 2)),
        isOnline: true,
        languages: ['English', 'Malayalam'],
        education: 'MBBS, MD (Cardiology)',
        hospital: 'LabLume Medical Center, Kochi',
      ),
      Doctor(
        id: '2',
        name: 'Dr. Rajesh Kumar',
        specialty: 'General Physician',
        experience: 12,
        rating: 4.6,
        reviewCount: 189,
        consultationFee: 400,
        nextAvailable: DateTime.now().add(const Duration(hours: 4)),
        isOnline: true,
        languages: ['English', 'Malayalam', 'Hindi'],
        education: 'MBBS, MD',
        hospital: 'LabLume Clinic, Ernakulam',
      ),
      Doctor(
        id: '3',
        name: 'Dr. Priya Menon',
        specialty: 'Dermatologist',
        experience: 10,
        rating: 4.9,
        reviewCount: 312,
        consultationFee: 600,
        nextAvailable: DateTime.now().add(const Duration(days: 1)),
        isOnline: false,
        languages: ['English', 'Malayalam'],
        education: 'MBBS, MD (Dermatology)',
        hospital: 'LabLume Skin Clinic, Kochi',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FAFB),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Color(0xFF111827)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Find Doctors',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF111827),
          ),
        ),
        centerTitle: true,
        actions: [
          _iconButton(Icons.tune_rounded),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF111827).withOpacity(0.04),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.search_rounded, color: Color(0xFF9CA3AF), size: 22),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() => _searchQuery = value);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search for doctors...',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 14,
                          color: const Color(0xFF9CA3AF),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Specialty Filter
          SizedBox(
            height: 44,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              scrollDirection: Axis.horizontal,
              itemCount: _specialties.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                return _specialtyChip(_specialties[index]);
              },
            ),
          ),

          const SizedBox(height: 20),

          // Doctors List
          Expanded(
            child: FutureBuilder<List<Doctor>>(
              future: fetchDoctors(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF12B8A6),
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return _emptyState();
                }

                final doctors = snapshot.data!;
                final filteredDoctors = doctors.where((doctor) {
                  final matchesSpecialty = _selectedSpecialty == 'All' ||
                      doctor.specialty == _selectedSpecialty;
                  final matchesSearch = _searchQuery.isEmpty ||
                      doctor.name.toLowerCase().contains(_searchQuery.toLowerCase());
                  return matchesSpecialty && matchesSearch;
                }).toList();

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  itemCount: filteredDoctors.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return _doctorCard(filteredDoctors[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(icon, size: 20, color: const Color(0xFF111827)),
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget _specialtyChip(String specialty) {
    final isSelected = _selectedSpecialty == specialty;
    
    return GestureDetector(
      onTap: () {
        setState(() => _selectedSpecialty = specialty);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF12B8A6) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF12B8A6)
                : const Color(0xFFE5E7EB),
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: const Color(0xFF12B8A6).withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ] : null,
        ),
        child: Text(
          specialty,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xFF6B7280),
          ),
        ),
      ),
    );
  }

  Widget _doctorCard(Doctor doctor) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorDetailScreen(doctor: doctor),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF111827).withOpacity(0.03),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                // Doctor Avatar
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: const Color(0xFF12B8A6).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    size: 32,
                    color: Color(0xFF12B8A6),
                  ),
                ),
                const SizedBox(width: 16),
                // Doctor Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              doctor.name,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF111827),
                              ),
                            ),
                          ),
                          if (doctor.isOnline)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFD1FAE5),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 5,
                                    height: 5,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF059669),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Online',
                                    style: GoogleFonts.poppins(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF059669),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        doctor.specialty,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: const Color(0xFF12B8A6),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            size: 16,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${doctor.rating}',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '(${doctor.reviewCount} reviews)',
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: const Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Experience',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF9CA3AF),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${doctor.experience} years',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF111827),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 24,
                    color: const Color(0xFFE5E7EB),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Fee',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF9CA3AF),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '₹${doctor.consultationFee.toInt()}',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF12B8A6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 24,
                    color: const Color(0xFFE5E7EB),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // Action to book
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Book Now',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF12B8A6),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.person_search_rounded, size: 48, color: Colors.grey.shade400),
          ),
          const SizedBox(height: 20),
          Text(
            'No doctors found',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your filters',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: const Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }
}

// =================================================
// MODEL (API READY)
// =================================================
class Doctor {
  final String id;
  final String name;
  final String specialty;
  final int experience;
  final double rating;
  final int reviewCount;
  final double consultationFee;
  final DateTime nextAvailable;
  final bool isOnline;
  final List<String> languages;
  final String education;
  final String hospital;

  Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.experience,
    required this.rating,
    required this.reviewCount,
    required this.consultationFee,
    required this.nextAvailable,
    required this.isOnline,
    required this.languages,
    required this.education,
    required this.hospital,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      name: json['name'],
      specialty: json['specialty'],
      experience: json['experience'],
      rating: json['rating'].toDouble(),
      reviewCount: json['review_count'],
      consultationFee: json['consultation_fee'].toDouble(),
      nextAvailable: DateTime.parse(json['next_available']),
      isOnline: json['is_online'],
      languages: List<String>.from(json['languages']),
      education: json['education'],
      hospital: json['hospital'],
    );
  }
}
