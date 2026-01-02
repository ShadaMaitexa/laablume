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
                onTap: _showDobDialog,
                icon: Icons.calendar_today_outlined,
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
                hint: 'your.email@example.com',
                keyboardType: TextInputType.emailAddress,
              ),
              _buildModernSelectField(
                label: 'City',
                value: city,
                onTap: _showCityBottomSheet,
                icon: Icons.keyboard_arrow_down,
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
  // ---------------- DOB DIALOG WITH PICKER ----------------
  void _showDobDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Choose your birth date',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Provide your personal data to book visits in just a few clicks.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: const Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  height: 160,
                  child: Row(
                    children: [
                      _pickerColumn(
                        values: List.generate(31, (i) => i + 1),
                        initialItem: selectedDay - 1,
                        onSelected: (v) => selectedDay = v,
                      ),
                      _pickerColumn(
                        values: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
                        initialItem: selectedMonth - 1,
                        onSelected: (v) {
                          final months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
                          selectedMonth = months.indexOf(v as String) + 1;
                        },
                      ),
                      _pickerColumn(
                        values: List.generate(100, (i) => 1925 + i),
                        initialItem: selectedYear - 1925,
                        onSelected: (v) => selectedYear = v,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        final months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
                        dob = '$selectedDay ${months[selectedMonth - 1]} $selectedYear';
                      });
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF12B8A6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                      elevation: 0,
                    ),
                    child: Text(
                      'Save date',
                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF12B8A6),
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

  Widget _pickerColumn({
    required List<dynamic> values,
    required int initialItem,
    required Function(dynamic) onSelected,
  }) {
    return Expanded(
      child: ListWheelScrollView.useDelegate(
        itemExtent: 40,
        physics: const FixedExtentScrollPhysics(),
        controller: FixedExtentScrollController(initialItem: initialItem),
        onSelectedItemChanged: (index) => onSelected(values[index]),
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (_, i) => Center(
            child: Text(
              values[i].toString(),
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF111827),
              ),
            ),
          ),
          childCount: values.length,
        ),
      ),
    );
  }

  void _showCityBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
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
              'City',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                decoration: InputDecoration(
                  icon: const Icon(Icons.search, color: Color(0xFF9CA3AF)),
                  hintText: 'Search',
                  hintStyle: GoogleFonts.poppins(color: const Color(0xFF9CA3AF)),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.my_location, color: Color(0xFF12B8A6)),
              title: Text('Use current location', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
              onTap: () {
                setState(() => city = 'Boston, MA');
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: ListView(
                children: [
                  _cityOption('Boston, MA'),
                  _cityOption('Bowling Green, KY'),
                  _cityOption('Bozeman, MT'),
                  _cityOption('Bonita Springs, FL'),
                  _cityOption('Boise, ID'),
                  _cityOption('Bossier City, LA'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cityOption(String name) {
    return ListTile(
      title: Text(name, style: GoogleFonts.poppins(fontSize: 15)),
      onTap: () {
        setState(() => city = name);
        Navigator.pop(context);
      },
    );
  }

  void _validateAndProceed() {
    if (firstNameController.text.trim().isEmpty) {
      _showSnackBar('Please enter your first name');
      return;
    }
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
 