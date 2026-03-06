import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/patient_provider.dart';
import 'hospital_detail_screen.dart';

class SearchHospitalsScreen extends StatefulWidget {
  const SearchHospitalsScreen({super.key});

  @override
  State<SearchHospitalsScreen> createState() => _SearchHospitalsScreenState();
}

class _SearchHospitalsScreenState extends State<SearchHospitalsScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _hospitals = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchHospitals();
  }

  Future<void> _fetchHospitals() async {
    setState(() => _isLoading = true);
    final provider = context.read<PatientProvider>();
    final results = await provider.searchHospitals(search: _searchController.text);
    setState(() {
      _hospitals = results;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: Text(
          'Find Hospitals',
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
                : _hospitals.isEmpty
                    ? _buildEmptyState()
                    : _buildHospitalsList(),
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
        onSubmitted: (value) => _fetchHospitals(),
        decoration: InputDecoration(
          hintText: 'Search hospitals by name or city...',
          hintStyle: GoogleFonts.poppins(color: const Color(0xFF9CA3AF)),
          prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF9CA3AF)),
          suffixIcon: IconButton(
            icon: const Icon(Icons.arrow_forward_rounded, color: Color(0xFF12B8A6)),
            onPressed: _fetchHospitals,
          ),
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
          Icon(Icons.business_outlined, size: 80, color: const Color(0xFFD1D5DB)),
          const SizedBox(height: 16),
          Text(
            'No hospitals found',
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

  Widget _buildHospitalsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: _hospitals.length,
      itemBuilder: (context, index) {
        final hospital = _hospitals[index];
        return _hospitalCard(hospital);
      },
    );
  }

  Widget _hospitalCard(Map<String, dynamic> hospital) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HospitalDetailScreen(hospitalId: hospital['id'] ?? hospital['_id']),
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
              child: const Icon(Icons.business_rounded, color: Color(0xFF12B8A6), size: 30),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hospital['name'] ?? 'Hospital Name',
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
                      Expanded(
                        child: Text(
                          hospital['address'] ?? 'Location',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: const Color(0xFF6B7280),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
                        (hospital['rating'] ?? 4.5).toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.category_outlined, color: Color(0xFF12B8A6), size: 16),
                      const SizedBox(width: 4),
                      Text(
                        hospital['type'] ?? 'General',
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
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF12B8A6).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFF12B8A6), size: 16),
            ),
          ],
        ),
      ),
    );
  }
}
