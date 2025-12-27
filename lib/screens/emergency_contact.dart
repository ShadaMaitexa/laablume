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
        leading: const Icon(
          Icons.arrow_back_ios,
          size: 18,
          color: Colors.black,
        ),
        actions: [
          TextButton(
            onPressed: () {
              _showSnackBar('Emergency contact information skipped');
            },
            child: Text(
              'Skip',
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: const Color(0xFF12B8A6),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            // Green tab indicator
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 32,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFF12B8A6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  Container(
                    width: 32,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFF12B8A6),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 32,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 185, 231, 224),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  Container(
                    width: 32,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 185, 231, 224),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 32,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 185, 231, 224),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Title
            Text(
              'Emergency contact',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 6),

            // Subtitle
            Text(
              'Provide emergency contact to ensure swift\ncommunication with your close relatives in case\nof an urgent situation.',
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: const Color(0xFF6B7280),
                height: 1.4,
              ),
            ),

            const SizedBox(height: 24),

            // First Name Input Field
            _buildInputField(
              label: 'First name',
              controller: firstNameController,
              hint: 'Enter emergency contact\'s first name',
            ),

            // Last Name Input Field
            _buildInputField(
              label: 'Last name',
              controller: lastNameController,
              hint: 'Enter emergency contact\'s last name',
            ),

            // Relationship Field (with bottom sheet)
            _buildRelationshipField(),

            // Phone Number Input Field
            _buildInputField(
              label: 'Phone number',
              controller: phoneController,
              hint: 'Enter emergency contact\'s phone number',
              prefix: const Text('🇮🇳 +91'),
              keyboardType: TextInputType.phone,
            ),

            // Email Input Field
            _buildInputField(
              label: 'Email',
              controller: emailController,
              hint: 'Enter the email (optional)',
              keyboardType: TextInputType.emailAddress,
            ),

            // City Input Field (now a simple textfield)
            _buildInputField(
              label: 'City',
              controller: cityController,
              hint: 'Enter city name',
            ),

            // Address Input Field
            _buildInputField(
              label: 'Address',
              controller: addressController,
              hint: 'Enter street name, building, apartment',
              maxLines: 3,
            ),

            const SizedBox(height: 24),

            // Next button
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton(
                onPressed: _validateAndProceed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF12B8A6),
                  shape: const StadiumBorder(),
                  elevation: 0,
                ),
                child: Text(
                  'Next',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Generic Input Field Widget
  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hint,
    Widget? prefix,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: maxLines > 1 ? null : 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              maxLines: maxLines,
              decoration: InputDecoration(
                prefix: prefix != null 
                    ? Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: prefix,
                      )
                    : null,
                hintText: hint,
                hintStyle: GoogleFonts.poppins(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 13,
                ),
                border: InputBorder.none,
              ),
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Relationship Field with Bottom Sheet
  Widget _buildRelationshipField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Relationship',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: _showRelationshipSheet,
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      relationship,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: relationship == 'Select relationship' 
                            ? const Color(0xFF9CA3AF) 
                            : Colors.black,
                      ),
                    ),
                  ),
                  const Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- RELATIONSHIP BOTTOM SHEET ----------------
  void _showRelationshipSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            _relationTile('Spouse'),
            _relationTile('Parent'),
            _relationTile('Child'),
            _relationTile('Friend'),
            _relationTile('Sibling'),
            _relationTile('Other'),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF12B8A6),
                    foregroundColor: Colors.white,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text('Save'),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  Widget _relationTile(String value) {
    return ListTile(
      title: Text(value, style: GoogleFonts.poppins(fontSize: 14)),
      trailing: relationship == value
          ? const Icon(Icons.check, color: Color(0xFF12B8A6))
          : null,
      onTap: () {
        setState(() => relationship = value);
      },
    );
  }
}
