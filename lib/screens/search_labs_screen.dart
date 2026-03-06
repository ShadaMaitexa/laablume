import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/patient_provider.dart';
import 'lab_detail_screen.dart';

class SearchLabsScreen extends StatefulWidget {
  const SearchLabsScreen({super.key});

  @override
  State<SearchLabsScreen> createState() => _SearchLabsScreenState();
}

class _SearchLabsScreenState extends State<SearchLabsScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _labs = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchLabs();
  }

  Future<void> _fetchLabs() async {
    setState(() => _isLoading = true);
    final provider = context.read<PatientProvider>();
    final results = await provider.searchLabs();
    
    // Filter locally since searchLabs doesn't take keyword in service yet
    if (_searchController.text.isNotEmpty) {
      final query = _searchController.text.toLowerCase();
      setState(() {
        _labs = results.where((lab) {
          final name = (lab['name'] ?? '').toString().toLowerCase();
          final city = (lab['city'] ?? '').toString().toLowerCase();
          return name.contains(query) || city.contains(query);
        }).toList();
        _isLoading = false;
      });
    } else {
      setState(() {
        _labs = results;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: Text(
          'Find Diagnostic Labs',
          style: GoogleFonts.poppins(
            color: const Color(0xFF111827),
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: _buildSearchField(),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator(color: Color(0xFF12B8A6)))
                : _labs.isEmpty
                    ? _buildEmptyState()
                    : _buildLabsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (_) => _fetchLabs(),
        decoration: InputDecoration(
          hintText: 'Search labs by name or city...',
          hintStyle: GoogleFonts.poppins(color: const Color(0xFF9CA3AF)),
          prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF9CA3AF)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.biotech_outlined, size: 80, color: const Color(0xFFD1D5DB)),
          const SizedBox(height: 16),
          Text(
            'No labs found',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF4B5563),
            ),
          ),
          Text(
            'Try a different search term',
            style: GoogleFonts.poppins(
              color: const Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: _labs.length,
      itemBuilder: (context, index) {
        final lab = _labs[index];
        return _labCard(lab);
      },
    );
  }

  Widget _labCard(Map<String, dynamic> lab) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LabDetailScreen(lab: lab),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF111827).withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
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
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.science_rounded, color: Color(0xFF12B8A6), size: 30),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lab['name'] ?? 'Lab Name',
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF111827),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.location_on_rounded, color: Color(0xFF9CA3AF), size: 14),
                      const SizedBox(width: 4),
                      Text(
                        lab['city'] ?? 'Location',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 18),
                      const SizedBox(width: 4),
                      Text(
                        (lab['rating'] ?? 4.7).toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.biotech_outlined, color: Color(0xFF12B8A6), size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${lab['testsCount'] ?? '150+'} Tests',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LabDetailScreen(lab: lab),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF12B8A6),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: Text(
                'View Tests',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
