import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LabBookingsScreen extends StatelessWidget {
  const LabBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Test Bookings',
                style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937)),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text('Add Offline Booking'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF12B8A6),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  Row(
                    children: [
                      _statusChip('All Bookings (245)', true),
                      _statusChip('Pending (18)', false),
                      _statusChip('In-Progress (12)', false),
                      _statusChip('Completed (215)', false),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView.separated(
                      itemCount: 10,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) => _bookingListItem(index),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusChip(String text, bool active) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: active ? const Color(0xFF12B8A6) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: active ? null : Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: active ? FontWeight.bold : FontWeight.w500,
          color: active ? Colors.white : const Color(0xFF6B7280),
        ),
      ),
    );
  }

  Widget _bookingListItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.receipt_long_rounded, color: Color(0xFF12B8A6)),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Booking #LB-220$index', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                Text('01 Jan 2026, 10:00 AM', style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF9CA3AF))),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text('Patient Name ${index + 1}', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
          ),
          Expanded(
            flex: 2,
            child: Text('Full Body Checkup', style: GoogleFonts.poppins(color: const Color(0xFF12B8A6))),
          ),
          const Expanded(child: Text('₹2,499')),
          _actionButton('Process'),
        ],
      ),
    );
  }

  Widget _actionButton(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF12B8A6)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF12B8A6)),
      ),
    );
  }
}

class LabInventoryScreen extends StatelessWidget {
  const LabInventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Inventory & Supplies',
            style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937)),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: 1.5,
              ),
              itemCount: 8,
              itemBuilder: (context, index) => _inventoryCard(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inventoryCard(int index) {
    bool isLow = index == 2 || index == 5;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isLow ? Border.all(color: Colors.red.withOpacity(0.3)) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Item Name ${index + 1}', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('In Stock: ${100 - (index * 10)} units', style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF6B7280))),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: (100 - (index * 10)) / 100,
            backgroundColor: const Color(0xFFF3F4F6),
            valueColor: AlwaysStoppedAnimation<Color>(isLow ? Colors.red : const Color(0xFF12B8A6)),
          ),
          if (isLow) ...[
            const SizedBox(height: 8),
            Text('Low Stock!', style: GoogleFonts.poppins(fontSize: 11, color: Colors.red, fontWeight: FontWeight.bold)),
          ],
        ],
      ),
    );
  }
}

class LabResultsApprovalScreen extends StatelessWidget {
  const LabResultsApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Results Validation', style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: ListView.separated(
                itemCount: 6,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) => ListTile(
                  title: Text('Sample #SAM-88${index + 10} - Alice Brown', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                  subtitle: Text('Sugar Level Test - Ready for Approval', style: GoogleFonts.poppins(fontSize: 12)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(onPressed: () {}, child: const Text('Review', style: TextStyle(color: Color(0xFF12B8A6)))),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF12B8A6)),
                        child: const Text('Approve'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LabTechniciansScreen extends StatelessWidget {
  const LabTechniciansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Lab Staff', style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: 3,
              ),
              itemCount: 6,
              itemBuilder: (context, index) => Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                child: Row(
                  children: [
                    const CircleAvatar(backgroundColor: Color(0xFF12B8A6), child: Icon(Icons.person, color: Colors.white)),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Technician ${index + 1}', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                        Text('Active on Line B', style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF6B7280))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LabSettingsScreen extends StatelessWidget {
  const LabSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.settings_outlined, size: 80, color: Color(0xFF12B8A6)),
          const SizedBox(height: 24),
          Text('Lab Configuration', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 48),
          _labSettingItem('Diagnostic Equipment Setup'),
          _labSettingItem('Report Templates'),
          _labSettingItem('Data Export Preferences'),
        ],
      ),
    );
  }

  Widget _labSettingItem(String title) {
    return Container(
      width: 500,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
          const Icon(Icons.chevron_right, color: Color(0xFFE5E7EB)),
        ],
      ),
    );
  }
}
