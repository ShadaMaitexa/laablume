import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/patient_provider.dart';
import '../providers/user_provider.dart';
import 'main_navigation_screen.dart';

class InsuranceOnboardingScreen extends StatefulWidget {
  const InsuranceOnboardingScreen({super.key});

  @override
  State<InsuranceOnboardingScreen> createState() =>
      _InsuranceOnboardingScreenState();
}

class _InsuranceOnboardingScreenState extends State<InsuranceOnboardingScreen> {
  final TextEditingController providerNameController = TextEditingController();
  final TextEditingController policyNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    final patientProvider = context.read<PatientProvider>();
    final userProvider = context.read<UserProvider>();

    final localInsurance =
        patientProvider.onboardingData['insurance'] as Map<String, dynamic>?;
    final userInsurance =
        patientProvider.user?.insurance ?? userProvider.currentUser?.insurance;

    if (localInsurance != null) {
      providerNameController.text = localInsurance['provider'] ?? '';
      policyNumberController.text = localInsurance['policyNumber'] ?? '';
      expiryDateController.text = localInsurance['policyExpiryDate'] ?? '';
      contactController.text = localInsurance['providerContact'] ?? '';
    } else if (userInsurance != null) {
      providerNameController.text = userInsurance.provider ?? '';
      policyNumberController.text = userInsurance.policyNumber ?? '';
      expiryDateController.text = userInsurance.policyExpiryDate ?? '';
      contactController.text = userInsurance.providerContact ?? '';
    }
  }

  @override
  void dispose() {
    providerNameController.dispose();
    policyNumberController.dispose();
    expiryDateController.dispose();
    contactController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          selectedDate ?? DateTime.now().add(const Duration(days: 365)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 3650)), // 10 years
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF12B8A6),
              onPrimary: Colors.white,
              onSurface: Color(0xFF111827),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        expiryDateController.text =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _completeOnboarding() async {
    final provider = context.read<PatientProvider>();

    // Accumulate insurance data
    provider.updateOnboardingData({
      'insurance': {
        'provider': providerNameController.text.trim(),
        'policyNumber': policyNumberController.text.trim(),
        'policyExpiryDate': expiryDateController.text.trim(),
        'providerContact': contactController.text.trim(),
      },
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(color: Color(0xFF12B8A6)),
      ),
    );

    final Map<String, dynamic> finalData = Map.from(provider.onboardingData);
    if (finalData.containsKey('personalData')) {
      final Map<String, dynamic> personalData = Map.from(
        finalData['personalData'],
      );

      String? currentMobile =
          provider.user?.mobileNumber ??
          context.read<UserProvider>().currentUser?.mobileNumber;
      String? currentEmail =
          provider.user?.email ??
          context.read<UserProvider>().currentUser?.email;

      String submittedPhone = personalData['phone']?.toString() ?? '';
      bool isPhoneDuplicate =
          submittedPhone.isNotEmpty &&
          (currentMobile == submittedPhone ||
              currentMobile == '+91$submittedPhone' ||
              (currentMobile?.startsWith('+91') == true &&
                  currentMobile?.substring(3) == submittedPhone));

      if (isPhoneDuplicate) {
        personalData.remove('phone');
      }

      if (currentEmail != null && personalData['email'] == currentEmail) {
        personalData.remove('email');
      }

      finalData['personalData'] = personalData;
    }

    final success = await provider.completeOnboarding(finalData);

    if (!mounted) return;
    Navigator.pop(context); // Remove loading

    if (success) {
      provider.clearOnboardingData();
      final user = provider.user;
      if (user != null) {
        context.read<UserProvider>().setCurrentUser(user);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Onboarding complete! Welcome 🎉'),
          backgroundColor: Color(0xFF12B8A6),
        ),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Submission failed. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF8F6),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: _buildProgressBar(5, 5),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _completeOnboarding,
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
                'Insurance Information',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Provide your insurance details to simplify the payment and claim process.',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  height: 1.5,
                  color: const Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 32),

              _buildModernInputField(
                label: 'Insurance Provider',
                controller: providerNameController,
                hint: 'e.g. Blue Cross, Aetna (optional)',
              ),
              _buildModernInputField(
                label: 'Policy Number',
                controller: policyNumberController,
                hint: 'e.g. POL12345678 (optional)',
              ),
              _buildModernSelectField(
                label: 'Expiry Date',
                value: expiryDateController.text.isEmpty
                    ? 'Select Date'
                    : expiryDateController.text,
                onTap: _selectDate,
                icon: Icons.calendar_today_outlined,
              ),
              _buildModernInputField(
                label: 'Provider Contact',
                controller: contactController,
                hint: 'Phone number or email (optional)',
              ),

              const SizedBox(height: 48),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _completeOnboarding,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF12B8A6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Complete Onboarding',
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
                        color: value == 'Select Date'
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
}
