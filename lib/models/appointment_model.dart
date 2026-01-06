class AppointmentModel {
  final String id;
  final String userID;
  final String doctorID;
  final DateTime appointmentDateTime;
  final String reasonForVisit;
  final String status;

  AppointmentModel({
    required this.id,
    required this.userID,
    required this.doctorID,
    required this.appointmentDateTime,
    required this.reasonForVisit,
    required this.status,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['_id'] ?? '',
      userID: json['userID'] ?? '',
      doctorID: json['doctorID'] ?? '',
      appointmentDateTime: DateTime.parse(json['appointmentDateTime']),
      reasonForVisit: json['reasonForVisit'] ?? '',
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userID': userID,
      'doctorID': doctorID,
      'appointmentDateTime': appointmentDateTime.toIso8601String(),
      'reasonForVisit': reasonForVisit,
      'status': status,
    };
  }
}
