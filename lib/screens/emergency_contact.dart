import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laablume/screens/health_assesment.dart';

class EmergencyContactScreen extends StatefulWidget {
  const EmergencyContactScreen({super.key});

  @override
  State<EmergencyContactScreen> createState() => _EmergencyContactScreenState();
}

class _EmergencyContactScreenState extends State<EmergencyContactScreen> {
  String relationship = 'Select relationship';

  // Text editing controllers for input fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    cityController.dispose();
    super.dispose();
  }

  void _validateAndProceed() {
    if (firstNameController.text.trim().isEmpty) {
      _showSnackBar('Please enter emergency contact\'s first name');
      return;
    }

    if (lastNameController.text.trim().isEmpty) {
      _showSnackBar('Please enter emergency contact\'s last name');
      return;
    }

    if (relationship == 'Select relationship') {
      _showSnackBar('Please select relationship');
      return;
    }

    if (phoneController.text.trim().isEmpty) {
      _showSnackBar('Please enter emergency contact\'s phone number');
      return;
    }

    if (addressController.text.trim().isEmpty) {
      _showSnackBar('Please enter emergency contact\'s address');
      return;
    }

    // All validations passed, proceed to next screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HealthAssessmentScreen(),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
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
        title: _buildProgressBar(2, 5),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HealthAssessmentScreen()),
              );
            },
            child: Text(
              'Skip',
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF12B8A6),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                'Emergency contact',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Provide emergency contact to ensure swift communication with your close relatives in case of an urgent situation.',
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
                hint: 'Enter first name',
              ),
              _buildModernInputField(
                label: 'Last name',
                controller: lastNameController,
                hint: 'Enter last name',
              ),
              _buildModernSelectField(
                label: 'Relationship',
                value: relationship,
                onTap: _showRelationshipSheet,
                icon: Icons.keyboard_arrow_down,
              ),
              _buildModernInputField(
                label: 'Phone number',
                controller: phoneController,
                hint: '000 000 0000',
                prefix: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('🇺🇸', style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 4),
                    const Icon(Icons.keyboard_arrow_down, size: 16, color: Color(0xFF6B7280)),
                    const SizedBox(width: 8),
                    Text('+1', style: GoogleFonts.poppins(fontSize: 14, color: Colors.black)),
                    const SizedBox(width: 8),
                    Container(width: 1, height: 24, color: const Color(0xFFE5E7EB)),
                    const SizedBox(width: 12),
                  ],
                ),
                keyboardType: TextInputType.phone,
              ),
              _buildModernInputField(
                label: 'Email',
                controller: emailController,
                hint: 'email@example.com (optional)',
                keyboardType: TextInputType.emailAddress,
              ),
              _buildModernInputField(
                label: 'City',
                controller: cityController,
                hint: 'Enter city',
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
              style: GoogleFonts.poppins(fontSize: 14),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: GoogleFonts.poppins(color: const Color(0xFF9CA3AF), fontSize: 14),
                prefixIcon: prefix != null ? Padding(padding: const EdgeInsets.only(left: 16), child: prefix) : null,
                prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                        color: value == 'Select relationship'
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

  void _showRelationshipSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 5,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(2.5),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Relationship',
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                _relationTile('Spouse'),
                _relationTile('Parent'),
                _relationTile('Child'),
                _relationTile('Friend'),
                _relationTile('Sibling'),
                _relationTile('Other'),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _relationTile(String value) {
    bool isSelected = relationship == value;
    return ListTile(
      title: Text(
        value, 
        style: GoogleFonts.poppins(
          fontSize: 15,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          color: isSelected ? const Color(0xFF12B8A6) : Colors.black,
        )
      ),
      trailing: isSelected ? const Icon(Icons.check, color: Color(0xFF12B8A6)) : null,
      onTap: () {
        setState(() => relationship = value);
        Navigator.pop(context);
      },
    );
  }
}
