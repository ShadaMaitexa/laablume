import 'report_model.dart';

class AppointmentModel {
  final String id;
  final String userID;
  final String doctorID;
  final String? doctorName;
  final String? doctorSpecialty;
  final DateTime appointmentDateTime;
  final String reasonForVisit;
  final String status;
  final Report? labReport; // Added for guide requirements

  AppointmentModel({
    required this.id,
    required this.userID,
    required this.doctorID,
    this.doctorName,
    this.doctorSpecialty,
    required this.appointmentDateTime,
    required this.reasonForVisit,
    required this.status,
    this.labReport,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['_id'] ?? '',
      userID: json['userID'] ?? '',
      doctorID: json['doctorID'] ?? '',
      doctorName: json['doctorName'] ?? json['doctor']?['name'],
      doctorSpecialty: json['doctorSpecialty'] ?? json['doctor']?['specialty'],
      appointmentDateTime: DateTime.parse(
        json['appointmentDateTime'] ?? DateTime.now().toIso8601String(),
      ),
      reasonForVisit: json['reasonForVisit'] ?? '',
      status: json['status'] ?? '',
      labReport: json['labReport'] != null
          ? Report.fromJson(json['labReport'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userID': userID,
      'doctorID': doctorID,
      'doctorName': doctorName,
      'doctorSpecialty': doctorSpecialty,
      'appointmentDateTime': appointmentDateTime.toIso8601String(),
      'reasonForVisit': reasonForVisit,
      'status': status,
      'labReport': labReport?.toJson(),
    };
  }
}
