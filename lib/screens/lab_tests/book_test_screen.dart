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
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FAFB),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Color(0xFF111827)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Confirm Booking',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF111827),
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Test Summary Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF111827).withOpacity(0.04),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF12B8A6).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.biotech_rounded,
                          color: Color(0xFF12B8A6),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.test.name,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF111827),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '₹${widget.test.price.toInt()}',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF12B8A6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Collection Type
                _sectionTitle('Collection Method'),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _collectionTypeCard(
                        icon: Icons.home_rounded,
                        title: 'Home Sample',
                        subtitle: 'Preferred',
                        value: 'home',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _collectionTypeCard(
                        icon: Icons.local_hospital_rounded,
                        title: 'Visit Lab',
                        subtitle: 'Direct Walk-in',
                        value: 'lab',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Lab Selection (if visit lab is selected)
                if (_collectionType == 'lab') ...[
                  _sectionTitle('Choose Laboratory'),
                  const SizedBox(height: 16),
                  FutureBuilder<List<LabLocation>>(
                    future: fetchNearbyLabs(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator(color: Color(0xFF12B8A6)));
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return _emptyLabsState();
                      }

                      final labs = snapshot.data!;
                      return Column(
                        children: labs.map((lab) => _labCard(lab)).toList(),
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                ],

                // Date Selection
                _sectionTitle('Appointment Date'),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _selectedDate != null
                            ? const Color(0xFF12B8A6)
                            : const Color(0xFFE5E7EB),
                        width: _selectedDate != null ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_month_rounded,
                          color: _selectedDate != null ? const Color(0xFF12B8A6) : const Color(0xFF9CA3AF),
                          size: 22,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          _selectedDate != null
                              ? '${_selectedDate!.day} ${_getMonthName(_selectedDate!.month)}, ${_selectedDate!.year}'
                              : 'Pick a Date',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: _selectedDate != null ? FontWeight.w700 : FontWeight.w500,
                            color: _selectedDate != null ? const Color(0xFF111827) : const Color(0xFF9CA3AF),
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFFD1D5DB)),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Time Slot Selection
                _sectionTitle('Preferred Time Slot'),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: _timeSlots.map((slot) => _timeSlotChip(slot)).toList(),
                ),

                const SizedBox(height: 32),

                // Address (if home collection)
                if (_collectionType == 'home') ...[
                  _sectionTitle('Collection Address'),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF111827).withOpacity(0.04),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.location_on_rounded,
                            color: Color(0xFF12B8A6),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Residencial Home',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF111827),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'MG Road, Kochi, Kerala - 682001',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF6B7280),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right_rounded, color: Color(0xFFD1D5DB)),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 120),
              ],
            ),
          ),

          // Bottom Confirm Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF111827).withOpacity(0.08),
                    blurRadius: 30,
                    offset: const Offset(0, -10),
                  ),
                ],
              ),
              child: SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _confirmBooking,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF12B8A6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Confirm Appointment',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
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
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: const Color(0xFF111827),
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF111827) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? const Color(0xFF111827) : const Color(0xFFE5E7EB),
            width: 2,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: const Color(0xFF111827).withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 8),
            )
          ] : [],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected ? const Color(0xFF12B8A6) : const Color(0xFF9CA3AF),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : const Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white54 : const Color(0xFF9CA3AF),
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? const Color(0xFF12B8A6) : const Color(0xFFE5E7EB),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: const Color(0xFF111827).withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ] : [],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                Icons.local_hospital_rounded,
                color: isSelected ? const Color(0xFF12B8A6) : const Color(0xFF9CA3AF),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lab.name,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    lab.address,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _labInfoTag(Icons.star_rounded, lab.rating.toString(), Colors.amber),
                      const SizedBox(width: 12),
                      _labInfoTag(Icons.location_on_rounded, '${lab.distance} km', const Color(0xFF9CA3AF)),
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

  Widget _labInfoTag(IconData icon, String label, Color color) {
    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF6B7280),
          ),
        ),
      ],
    );
  }

  Widget _timeSlotChip(String slot) {
    final isSelected = _selectedTimeSlot == slot;
    
    return GestureDetector(
      onTap: () {
        setState(() => _selectedTimeSlot = slot);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF12B8A6) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF12B8A6) : const Color(0xFFE5E7EB),
            width: 1.5,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: const Color(0xFF12B8A6).withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ] : [],
        ),
        child: Text(
          slot,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: isSelected ? Colors.white : const Color(0xFF6B7280),
          ),
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  Widget _emptyLabsState() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Text(
          'No nearby labs found',
          style: GoogleFonts.poppins(fontSize: 14, color: const Color(0xFF6B7280)),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF111827),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xFF111827),
            ),
            dialogBackgroundColor: Colors.white,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF12B8A6),
              ),
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
       _showSnackBar('Please select a preferred date');
      return;
    }

    if (_selectedTimeSlot == null) {
      _showSnackBar('Please choose a time slot');
      return;
    }

    if (_collectionType == 'lab' && _selectedLab == null) {
      _showSnackBar('Please select a nearby lab');
      return;
    }

    // TODO: API call to confirm booking
    _showSnackBar('Appointment booked successfully!');
    
    // Navigate back to home or show confirmation screen
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: const Color(0xFF111827),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
