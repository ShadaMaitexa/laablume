class BookingModel {
  final String id;
  final String userID;
  final String labID;
  final String testID;
  final DateTime bookingDate;
  final String status;
  final String reportURL;

  BookingModel({
    required this.id,
    required this.userID,
    required this.labID,
    required this.testID,
    required this.bookingDate,
    required this.status,
    required this.reportURL,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['_id'] ?? '',
      userID: json['userID'] ?? '',
      labID: json['labID'] ?? '',
      testID: json['testID'] ?? '',
      bookingDate: DateTime.parse(json['bookingDate']),
      status: json['status'] ?? '',
      reportURL: json['reportURL'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userID': userID,
      'labID': labID,
      'testID': testID,
      'bookingDate': bookingDate.toIso8601String(),
      'status': status,
      'reportURL': reportURL,
    };
  }
}
