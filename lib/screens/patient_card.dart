import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/patient_provider.dart';
import 'package:laablume/screens/emergency_contact.dart';

class PersonalDataScreen extends StatefulWidget {
  const PersonalDataScreen({super.key});

  @override
  State<PersonalDataScreen> createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  String dob = 'DD / MM / YYYY';

  DateTime? selectedDate;


  // Text editing controllers for input fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    cityController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF8F6),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFEAF8F6),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: _buildProgressBar(1, 5),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'Personal data',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Provide your personal data to book visits in just a few clicks.',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      height: 1.5,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Form Fields
                  _buildModernInputField(
                    label: 'First name',
                    controller: firstNameController,
                    hint: 'Enter your name',
                  ),
                  _buildModernInputField(
                    label: 'Last name',
                    controller: lastNameController,
                    hint: 'Enter your last name',
                  ),
                  _buildModernSelectField(
                    label: 'Date of birth',
                    value: dob,
                    onTap: _selectDate,
                    icon: Icons.calendar_today_outlined,
                  ),
                  _buildModernInputField(
                    label: 'Phone number',
                    controller: phoneController,
                    hint: 'Enter 10-digit phone number',
                    keyboardType: TextInputType.phone,
                    digitsOnly: true,
                  ),
                  _buildModernInputField(
                    label: 'Email',
                    controller: emailController,
                    hint: 'your.email@example.com',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  _buildModernInputField(
                    label: 'City',
                    controller: cityController,
                    hint: 'Enter your city',
                  ),
                  _buildModernInputField(
                    label: 'Address',
                    controller: addressController,
                    hint: 'Street Name, Building, Apartment',
                    maxLines: 2,
                  ),

                  const SizedBox(height: 40),

                  // Next Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _validateAndProceed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF12B8A6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Next',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar(int step, int total) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(total, (index) {
        return Container(
          width: 36,
          height: 4,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: index < step
                ? const Color(0xFF12B8A6)
                : const Color(0xFF12B8A6).withOpacity(0.2),
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }

  Widget _buildModernInputField({
    required String label,
    required TextEditingController controller,
    required String hint,
    Widget? prefix,
    TextInputType? keyboardType,
    int maxLines = 1,
    bool digitsOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1F2937),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              maxLines: maxLines,
              inputFormatters: digitsOnly
                  ? [FilteringTextInputFormatter.digitsOnly]
                  : null,
              style: GoogleFonts.poppins(fontSize: 14),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: GoogleFonts.poppins(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14,
                ),
                prefixIcon: prefix != null
                    ? Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: prefix,
                      )
                    : null,
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 0,
                  minHeight: 0,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernSelectField({
    required String label,
    required String value,
    required VoidCallback onTap,
    required IconData icon,
    bool isNumericOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      value,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: value.contains('choose') || value.contains('DD')
                            ? const Color(0xFF9CA3AF)
                            : Colors.black,
                      ),
                    ),
                  ),
                  Icon(icon, color: const Color(0xFF6B7280), size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- DATE PICKER ----------------
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF12B8A6),
              onPrimary: Colors.white,
              onSurface: Color(0xFF111827),
            ),
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

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        final months = [
          'January',
          'February',
          'March',
          'April',
          'May',
          'June',
          'July',
          'August',
          'September',
          'October',
          'November',
          'December',
        ];
        dob = '${picked.day} ${months[picked.month - 1]} ${picked.year}';
      });
    }
  }


  void _validateAndProceed() {
    if (firstNameController.text.trim().isEmpty) {
      _showSnackBar('Please enter your first name');
      return;
    }
    if (lastNameController.text.trim().isEmpty) {
      _showSnackBar('Please enter your last name');
      return;
    }
    if (dob == 'DD / MM / YYYY') {
      _showSnackBar('Please select your date of birth');
      return;
    }
    if (phoneController.text.trim().isEmpty) {
      _showSnackBar('Please enter your phone number');
      return;
    }
    final phoneDigits = phoneController.text.trim().replaceAll(RegExp(r'\D'), '');
    if (phoneDigits.length < 10) {
      _showSnackBar('Please enter a valid 10-digit phone number');
      return;
    }
    if (emailController.text.trim().isNotEmpty) {
      final emailRegex = RegExp(r'^[\w.-]+@[\w.-]+\.[a-zA-Z]{2,4}$');
      if (!emailRegex.hasMatch(emailController.text.trim())) {
        _showSnackBar('Please enter a valid email address');
        return;
      }
    }
    if (cityController.text.trim().isEmpty) {
      _showSnackBar('Please enter your city');
      return;
    }

    // Accumulate data
    context.read<PatientProvider>().updateOnboardingData({
      'personalData': {
        'firstName': firstNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
        'dob': selectedDate != null
            ? "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}"
            : dob,
        'phone': phoneController.text.trim(),
        'city': cityController.text.trim(),
        'address': addressController.text.trim(),
      },
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EmergencyContactScreen()),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }
}
