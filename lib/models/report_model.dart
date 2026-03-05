class Report {
  final String id;
  final String bookingId;
  final String patientId;
  final String labId;
  final String testName;
  final DateTime date;
  final String status; // pending, validated, delivered
  final String? reportUrl;
  final bool? verifiedByDoctor;
  final String? validatedBy;
  final DateTime? validatedAt;
  final Map<String, dynamic>? results;

  Report({
    required this.id,
    required this.bookingId,
    required this.patientId,
    required this.labId,
    required this.testName,
    required this.date,
    required this.status,
    this.reportUrl,
    this.verifiedByDoctor,
    this.validatedBy,
    this.validatedAt,
    this.results,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['_id'] ?? json['id'] ?? '',
      bookingId: json['bookingId'] ?? '',
      patientId: json['patientId'] ?? '',
      labId: json['labId'] ?? '',
      testName: json['testName'] ?? '',
      date: DateTime.parse(
        json['date'] ?? json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
      status: json['status'] ?? 'pending',
      reportUrl: json['reportUrl'] ?? json['fileUrl'] ?? json['url'],
      verifiedByDoctor: json['verifiedByDoctor'] ?? json['isValidated'] ?? false,
      validatedBy: json['validatedBy'],
      validatedAt: json['validatedAt'] != null
          ? DateTime.parse(json['validatedAt'])
          : null,
      results: json['results'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookingId': bookingId,
      'patientId': patientId,
      'labId': labId,
      'testName': testName,
      'date': date.toIso8601String(),
      'status': status,
      'reportUrl': reportUrl,
      'verifiedByDoctor': verifiedByDoctor,
      'validatedBy': validatedBy,
      'validatedAt': validatedAt?.toIso8601String(),
      'results': results,
    };
  }

  // Helper method for Report visibility rules
  bool get shouldShowReport => verifiedByDoctor ?? false;
  bool get shouldShowUnderReview => (reportUrl != null && (verifiedByDoctor == false || verifiedByDoctor == null));
  bool get shouldShowNothing => reportUrl == null;
}
