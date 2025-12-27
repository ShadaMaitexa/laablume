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

                ovalField(label: 'First name', hint: 'Enter your first name'),
                ovalField(label: 'Last name', hint: 'Enter your last name'),

                ovalField(
                  label: 'Date of birth',
                  hint: dob,
                  onTap: _showDobDialog,
                ),

                ovalField(
                  label: 'Phone number',
                  hint: '800 000 0000',
                  prefix: const Text('🇮🇳 +91'),
                ),

                ovalField(label: 'Email', hint: 'example@email.com'),

                ovalField(
                  label: 'City',
                  hint: city,
                  onTap: _showCityBottomSheet,
                ),

                ovalField(
                  label: 'Address',
                  hint: 'Street name, building, apartment',
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton(
                    onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const EmergencyContactScreen(),));},
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

  // ---------------- OVAL FIELD ----------------
  Widget ovalField({
    required String label,
    required String hint,
    Widget? prefix,
    VoidCallback? onTap,
  }) {
    final isPlaceholder =
        hint.contains('Enter') || hint.contains('DD');

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
          GestureDetector(
            onTap: onTap,
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
                  if (prefix != null) ...[
                    prefix,
                    const SizedBox(width: 8),
                  ],
                  Expanded(
                    child: Text(
                      hint,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color:
                            isPlaceholder ? const Color(0xFF9CA3AF) : Colors.black,
                      ),
                    ),
                  ),
                  if (onTap != null)
                    const Icon(Icons.keyboard_arrow_down),
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
