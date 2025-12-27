import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laablume/screens/emergency_contact.dart';

class PersonalDataScreen extends StatefulWidget {
  const PersonalDataScreen({super.key});

  @override
  State<PersonalDataScreen> createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  String dob = 'DD / MM / YYYY';
  String city = 'Enter or choose your city';

  int selectedDay = 1;
  int selectedMonth = 1;
  int selectedYear = 1998;

  // Text editing controllers for input fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFEAF8F6),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFEAF8F6),
        leading:
            const Icon(Icons.arrow_back_ios, size: 18, color: Colors.black),
            title:  Row(
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
      color: const Color.fromARGB(255, 185, 231, 224),
      borderRadius: BorderRadius.circular(4),
    ),
  ), Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: 32,
      height: 4,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 185, 231, 224),
        borderRadius: BorderRadius.circular(4),
      ),
    ),
  ), Container(
    width: 32,
    height: 4,
    decoration: BoxDecoration(
      color:  const Color.fromARGB(255, 185, 231, 224),
      borderRadius: BorderRadius.circular(4),
    ),
  ), Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: 32,
      height: 4,
      decoration: BoxDecoration(
        color:  const Color.fromARGB(255, 185, 231, 224),
        borderRadius: BorderRadius.circular(4),
      ),
    ),
  ),
              ],
            ),centerTitle: true,
      ),
      body: Stack(
        children: [
        
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                // Top title
                Text(
                  'Personal data',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Provide your personal data to track health status',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: const Color(0xFF6B7280),
                  ),
                ),

                const SizedBox(height: 24),

                // First Name Input Field
                _buildInputField(
                  label: 'First name',
                  controller: firstNameController,
                  hint: 'Enter your first name',
                ),

                // Last Name Input Field
                _buildInputField(
                  label: 'Last name',
                  controller: lastNameController,
                  hint: 'Enter your last name',
                ),

                // Date of Birth Field (with dialog)
                _buildDateOfBirthField(),

                // Phone Number Input Field
                _buildInputField(
                  label: 'Phone number',
                  controller: phoneController,
                  hint: '800 000 0000',
                  prefix: const Text('🇮🇳 +91'),
                  keyboardType: TextInputType.phone,
                ),

                // Email Input Field
                _buildInputField(
                  label: 'Email',
                  controller: emailController,
                  hint: 'example@email.com',
                  keyboardType: TextInputType.emailAddress,
                ),

                // City Field (with bottom sheet)
                _buildCityField(),

                // Address Input Field
                _buildInputField(
                  label: 'Address',
                  controller: addressController,
                  hint: 'Street name, building, apartment',
                  maxLines: 3,
                ),

                const SizedBox(height: 24),

                // Next Button
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
        ],
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

  // Date of Birth Field with Dialog
  Widget _buildDateOfBirthField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Date of birth',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: _showDobDialog,
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
                      dob,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: dob.contains('DD') ? const Color(0xFF9CA3AF) : Colors.black,
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

  // City Field with Bottom Sheet
  Widget _buildCityField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'City',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: _showCityBottomSheet,
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
                      city,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: city.contains('Enter') ? const Color(0xFF9CA3AF) : Colors.black,
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

  // Validate form and proceed
  void _validateAndProceed() {
    if (firstNameController.text.trim().isEmpty) {
      _showSnackBar('Please enter your first name');
      return;
    }
    
    if (lastNameController.text.trim().isEmpty) {
      _showSnackBar('Please enter your last name');
      return;
    }

    if (phoneController.text.trim().isEmpty) {
      _showSnackBar('Please enter your phone number');
      return;
    }

    if (emailController.text.trim().isEmpty) {
      _showSnackBar('Please enter your email');
      return;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailController.text.trim())) {
      _showSnackBar('Please enter a valid email address');
      return;
    }

    if (addressController.text.trim().isEmpty) {
      _showSnackBar('Please enter your address');
      return;
    }

    if (dob.contains('DD')) {
      _showSnackBar('Please select your date of birth');
      return;
    }

    if (city.contains('Enter')) {
      _showSnackBar('Please select your city');
      return;
    }

    // All validations passed, proceed to next screen
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => const EmergencyContactScreen(),
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

  // ---------------- DOB DIALOG WITH PICKER ----------------
  void _showDobDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          backgroundColor: const Color(0xFFF4EFF6),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Choose your birth date',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  height: 140,
                  child: Row(
                    children: [
                      pickerColumn(
                        values: List.generate(31, (i) => i + 1),
                        onSelected: (v) => selectedDay = v,
                      ),
                      pickerColumn(
                        values: List.generate(12, (i) => i + 1),
                        onSelected: (v) => selectedMonth = v,
                      ),
                      pickerColumn(
                        values: List.generate(70, (i) => 1955 + i),
                        onSelected: (v) => selectedYear = v,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        dob =
                            '$selectedDay / $selectedMonth / $selectedYear';
                      });
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF12B8A6),
                      shape: const StadiumBorder(),
                      elevation: 0,
                    ),
                    child: const Text('Save date'),
                  ),
                ),

                const SizedBox(height: 10),

                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: const Color(0xFF6B5AED),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget pickerColumn({
    required List<int> values,
    required Function(int) onSelected,
  }) {
    return Expanded(
      child: ListWheelScrollView.useDelegate(
        itemExtent: 32,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (index) => onSelected(values[index]),
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (_, i) => Center(
            child: Text(
              values[i].toString(),
              style: GoogleFonts.poppins(fontSize: 14),
            ),
          ),
          childCount: values.length,
        ),
      ),
    );
  }

  // ---------------- CITY BOTTOM SHEET ----------------
  void _showCityBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search city',
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              cityTile('Use current location'),
              cityTile('Boston, MA'),
              cityTile('Bloomington, KY'),
              cityTile('Bozeman, MT'),
            ],
          ),
        );
      },
    );
  }

  Widget cityTile(String name) {
    return ListTile(
      title: Text(name, style: GoogleFonts.poppins(fontSize: 14)),
      onTap: () {
        setState(() => city = name);
        Navigator.pop(context);
      },
    );
  }
}
