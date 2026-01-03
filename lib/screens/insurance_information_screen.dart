import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InsuranceInformationScreen extends StatefulWidget {
  const InsuranceInformationScreen({super.key});

  @override
  State<InsuranceInformationScreen> createState() => _InsuranceInformationScreenState();
}

class _InsuranceInformationScreenState extends State<InsuranceInformationScreen> {
  final TextEditingController insuranceNameController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController relationshipController = TextEditingController();
  final TextEditingController policyNumberController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void dispose() {
    insuranceNameController.dispose();
    cardNumberController.dispose();
    expiryDateController.dispose();
    relationshipController.dispose();
    policyNumberController.dispose();
    phoneController.dispose();
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
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Insurance Information',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF111827),
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Edit',
              style: GoogleFonts.poppins(
                color: const Color(0xFF12B8A6),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildField('Insurance Name', insuranceNameController, hint: 'e.g. Blue Cross'),
            _buildField('Card Number', cardNumberController, hint: '1234 5678 9012'),
            _buildField('Expiry Date', expiryDateController, hint: 'MM/YY', icon: Icons.calendar_today_rounded),
            _buildField('Relationship with Primary Cardholder', relationshipController, hint: 'Self', icon: Icons.keyboard_arrow_down_rounded),
            _buildField('Policy Number', policyNumberController, hint: 'POL12345678'),
            _buildField('Phone Number', phoneController, hint: '000 000 0000', isPhone: true),
            _buildField('City', cityController, hint: 'Enter city'),
            _buildField('Address', addressController, hint: 'Street, Building, Apt', maxLines: 2),
            
            const SizedBox(height: 32),
            
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF12B8A6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                  elevation: 0,
                ),
                child: Text(
                  'Save Changes',
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller, {String? hint, IconData? icon, bool isPhone = false, int maxLines = 1}) {
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
              maxLines: maxLines,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: GoogleFonts.poppins(color: const Color(0xFF9CA3AF), fontSize: 14),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                border: InputBorder.none,
                prefixIcon: isPhone ? _buildPhonePrefix() : null,
                suffixIcon: icon != null ? Icon(icon, color: const Color(0xFF6B7280), size: 20) : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhonePrefix() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(width: 16),
        const Text('🇺🇸', style: TextStyle(fontSize: 18)),
        const SizedBox(width: 4),
        const Icon(Icons.keyboard_arrow_down, size: 16, color: Color(0xFF6B7280)),
        const SizedBox(width: 8),
        Text('+1', style: GoogleFonts.poppins(fontSize: 14, color: Colors.black)),
        const SizedBox(width: 8),
        Container(width: 1, height: 24, color: const Color(0xFFE5E7EB)),
        const SizedBox(width: 12),
      ],
    );
  }
}
