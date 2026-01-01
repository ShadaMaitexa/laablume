import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'lab_tests_screen.dart';

class BookTestScreen extends StatefulWidget {
  final LabTest test;

  const BookTestScreen({super.key, required this.test});

  @override
  State<BookTestScreen> createState() => _BookTestScreenState();
}

class _BookTestScreenState extends State<BookTestScreen> {
  String _collectionType = 'home'; // 'home' or 'lab'
  DateTime? _selectedDate;
  String? _selectedTimeSlot;
  String? _selectedLab;

  final List<String> _timeSlots = [
    '6:00 AM - 7:00 AM',
    '7:00 AM - 8:00 AM',
    '8:00 AM - 9:00 AM',
    '9:00 AM - 10:00 AM',
    '10:00 AM - 11:00 AM',
  ];

  // API READY - Fetch nearby labs
  Future<List<LabLocation>> fetchNearbyLabs() async {
    // TODO: Replace with actual API call
    await Future.delayed(const Duration(milliseconds: 500));
    
    return [
      LabLocation(
        id: '1',
        name: 'LabLume Diagnostics - Kochi',
        address: 'MG Road, Kochi, Kerala',
        distance: 2.5,
        rating: 4.8,
      ),
      LabLocation(
        id: '2',
        name: 'LabLume Diagnostics - Ernakulam',
        address: 'Palarivattom, Ernakulam, Kerala',
        distance: 5.2,
        rating: 4.6,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF7F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFF7F6),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Book Test',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Test Summary Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF12B8A6).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.science,
                          color: Color(0xFF12B8A6),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.test.name,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '₹${widget.test.price}',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF12B8A6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Collection Type
                _sectionTitle('Collection Type'),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _collectionTypeCard(
                        icon: Icons.home_outlined,
                        title: 'Home Collection',
                        subtitle: 'Free',
                        value: 'home',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _collectionTypeCard(
                        icon: Icons.location_on_outlined,
                        title: 'Visit Lab',
                        subtitle: 'Walk-in',
                        value: 'lab',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Lab Selection (if visit lab is selected)
                if (_collectionType == 'lab') ...[
                  _sectionTitle('Select Lab'),
                  const SizedBox(height: 12),
                  FutureBuilder<List<LabLocation>>(
                    future: fetchNearbyLabs(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text('No labs available');
                      }

                      final labs = snapshot.data!;
                      return Column(
                        children: labs.map((lab) => _labCard(lab)).toList(),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                ],

                // Date Selection
                _sectionTitle('Select Date'),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _selectedDate != null
                            ? const Color(0xFF12B8A6)
                            : const Color(0xFFE5E7EB),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          color: Color(0xFF12B8A6),
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          _selectedDate != null
                              ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                              : 'Select date',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: _selectedDate != null
                                ? Colors.black
                                : const Color(0xFF9CA3AF),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Time Slot Selection
                _sectionTitle('Select Time Slot'),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _timeSlots.map((slot) => _timeSlotChip(slot)).toList(),
                ),

                const SizedBox(height: 24),

                // Address (if home collection)
                if (_collectionType == 'home') ...[
                  _sectionTitle('Collection Address'),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Color(0xFF12B8A6),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Home',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'MG Road, Kochi, Kerala - 682001',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: const Color(0xFF6B7280),
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Change',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color(0xFF12B8A6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 100),
              ],
            ),
          ),

          // Bottom Confirm Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _confirmBooking,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF12B8A6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Confirm Booking',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _collectionTypeCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String value,
  }) {
    final isSelected = _collectionType == value;
    
    return GestureDetector(
      onTap: () {
        setState(() => _collectionType = value);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF12B8A6)
                : const Color(0xFFE5E7EB),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected
                  ? const Color(0xFF12B8A6)
                  : const Color(0xFF6B7280),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isSelected ? const Color(0xFF12B8A6) : Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: const Color(0xFF9CA3AF),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _labCard(LabLocation lab) {
    final isSelected = _selectedLab == lab.id;
    
    return GestureDetector(
      onTap: () {
        setState(() => _selectedLab = lab.id);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF12B8A6)
                : const Color(0xFFE5E7EB),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF12B8A6).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.local_hospital,
                color: Color(0xFF12B8A6),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lab.name,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    lab.address,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 14,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        lab.rating.toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(
                        Icons.location_on,
                        size: 14,
                        color: Color(0xFF6B7280),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${lab.distance} km',
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
      ),
    );
  }

  Widget _timeSlotChip(String slot) {
    final isSelected = _selectedTimeSlot == slot;
    
    return GestureDetector(
      onTap: () {
        setState(() => _selectedTimeSlot = slot);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF12B8A6) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF12B8A6)
                : const Color(0xFFE5E7EB),
          ),
        ),
        child: Text(
          slot,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xFF6B7280),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF12B8A6),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  void _confirmBooking() {
    if (_selectedDate == null) {
      _showSnackBar('Please select a date');
      return;
    }

    if (_selectedTimeSlot == null) {
      _showSnackBar('Please select a time slot');
      return;
    }

    if (_collectionType == 'lab' && _selectedLab == null) {
      _showSnackBar('Please select a lab');
      return;
    }

    // TODO: API call to confirm booking
    _showSnackBar('Booking confirmed successfully!');
    
    // Navigate back to home or show confirmation screen
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF12B8A6),
      ),
    );
  }
}

// =================================================
// MODEL (API READY)
// =================================================
class LabLocation {
  final String id;
  final String name;
  final String address;
  final double distance;
  final double rating;

  LabLocation({
    required this.id,
    required this.name,
    required this.address,
    required this.distance,
    required this.rating,
  });

  factory LabLocation.fromJson(Map<String, dynamic> json) {
    return LabLocation(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      distance: json['distance'].toDouble(),
      rating: json['rating'].toDouble(),
    );
  }
}
