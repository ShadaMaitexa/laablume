import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'find_doctors_screen.dart';

class BookConsultationScreen extends StatefulWidget {
  final Doctor doctor;

  const BookConsultationScreen({super.key, required this.doctor});

  @override
  State<BookConsultationScreen> createState() => _BookConsultationScreenState();
}

class _BookConsultationScreenState extends State<BookConsultationScreen> {
  String _consultationType = 'online'; // 'online' or 'offline'
  DateTime? _selectedDate;
  String? _selectedTimeSlot;
  final TextEditingController _symptomsController = TextEditingController();

  final List<String> _timeSlots = [
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
  ];

  @override
  void dispose() {
    _symptomsController.dispose();
    super.dispose();
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
          'Book Appointment',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
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
                // Doctor Summary Card
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
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: const Color(0xFF12B8A6).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Icon(Icons.person_rounded, size: 36, color: Color(0xFF12B8A6)),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.doctor.name,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF111827),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.doctor.specialty,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF6B7280),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.star_rounded, size: 16, color: Colors.amber),
                                const SizedBox(width: 4),
                                Text(
                                  '${widget.doctor.rating}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF111827),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  width: 4,
                                  height: 4,
                                  decoration: const BoxDecoration(color: Color(0xFFE5E7EB), shape: BoxShape.circle),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${widget.doctor.experience} yrs exp',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
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

                const SizedBox(height: 32),

                // Consultation Type
                _sectionTitle('Consultation Mode'),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _consultationTypeCard(
                        icon: Icons.videocam_rounded,
                        title: 'Video Call',
                        subtitle: 'Online Session',
                        value: 'online',
                        isAvailable: widget.doctor.isOnline,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _consultationTypeCard(
                        icon: Icons.location_on_rounded,
                        title: 'In-Clinic',
                        subtitle: 'Physical Visit',
                        value: 'offline',
                        isAvailable: true,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Date Selection
                _sectionTitle('Schedule Day'),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Container(
                    padding: const EdgeInsets.all(20),
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
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF12B8A6).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.calendar_month_rounded, color: Color(0xFF12B8A6), size: 22),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          _selectedDate != null
                              ? '${_selectedDate!.day} ${_getMonthName(_selectedDate!.month)}, ${_selectedDate!.year}'
                              : 'Select available date',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: _selectedDate != null ? FontWeight.w700 : FontWeight.w500,
                            color: _selectedDate != null ? const Color(0xFF111827) : const Color(0xFF9CA3AF),
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF9CA3AF)),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Time Slot Selection
                _sectionTitle('Time Slots'),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _timeSlots.map((slot) => _timeSlotChip(slot)).toList(),
                ),

                const SizedBox(height: 32),

                // Symptoms/Reason
                _sectionTitle('Patient Notes'),
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
                  child: TextField(
                    controller: _symptomsController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Share current symptoms or health concerns...',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF9CA3AF),
                      ),
                      border: InputBorder.none,
                    ),
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF111827),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Fee Summary
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF111827),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF111827).withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _paymentRow('Consultation Fee', '₹${widget.doctor.consultationFee}'),
                      const SizedBox(height: 12),
                      _paymentRow('Service Fee', '₹50'),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Divider(color: Colors.white12, height: 1),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Payment',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                          Text(
                            '₹${widget.doctor.consultationFee + 50}',
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

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
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF111827).withOpacity(0.08),
                    blurRadius: 30,
                    offset: const Offset(0, -10),
                  ),
                ],
              ),
              child: Container(
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
                    'Confirm Booking',
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

  Widget _paymentRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.6),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  Widget _consultationTypeCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String value,
    required bool isAvailable,
  }) {
    final isSelected = _consultationType == value;
    
    return GestureDetector(
      onTap: isAvailable
          ? () {
              setState(() => _consultationType = value);
            }
          : null,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected && isAvailable ? Colors.white : (isAvailable ? Colors.white : const Color(0xFFF3F4F6)),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected && isAvailable
                ? const Color(0xFF12B8A6)
                : (isAvailable ? const Color(0xFFE5E7EB) : Colors.transparent),
            width: isSelected && isAvailable ? 2 : 1,
          ),
          boxShadow: isSelected && isAvailable ? [
            BoxShadow(
              color: const Color(0xFF12B8A6).withOpacity(0.1),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ] : null,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected && isAvailable
                  ? const Color(0xFF12B8A6)
                  : const Color(0xFF9CA3AF),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: isAvailable ? const Color(0xFF111827) : const Color(0xFF9CA3AF),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF9CA3AF),
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF12B8A6) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF12B8A6)
                : const Color(0xFFE5E7EB),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: const Color(0xFF12B8A6).withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ] : null,
        ),
        child: Text(
          slot,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
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
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF12B8A6),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xFF111827),
            ),
            dialogBackgroundColor: Colors.white,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF12B8A6),
                textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w700),
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
      _showSnackBar('Please select a date');
      return;
    }

    if (_selectedTimeSlot == null) {
      _showSnackBar('Please select a time slot');
      return;
    }

    if (_symptomsController.text.trim().isEmpty) {
      _showSnackBar('Please share your symptoms');
      return;
    }

    _showSnackBar('Booking successful!');
    
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
