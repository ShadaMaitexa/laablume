class UserModel {
  final String id;
  final String name;
  final String email;
  final String? profileImageUrl;
  final String mobileNumber;
  final String role; // 'patient', 'doctor', 'lab', 'hospital', 'admin'
  final bool isApproved;
  final String? hospitalId;
  final String? hospitalName;
  final bool isOnboarded;
  final String? dob;
  final String? city;
  final String? address;
  final String? firstName;
  final String? lastName;

  final EmergencyContact? emergencyContact;
  final HealthProfile? healthProfile;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobileNumber,
    required this.role,
    this.isApproved = true,
    this.profileImageUrl,
    this.hospitalId,
    this.hospitalName,
    this.isOnboarded = false,
    this.dob,
    this.city,
    this.address,
    this.firstName,
    this.lastName,
    this.emergencyContact,
    this.healthProfile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // If the response is wrapped in 'user' or 'data', unwrap it
    final Map<String, dynamic> userData = json['user'] ?? json['data'] ?? json;

    return UserModel(
      id: userData['id']?.toString() ?? userData['_id']?.toString() ?? '',
      name:
          (userData['name'] ??
                  userData['userName'] ??
                  userData['fullName'] ??
                  '')
              .toString(),
      email: userData['email']?.toString() ?? '',
      mobileNumber:
          userData['phone']?.toString() ??
          userData['mobileNumber']?.toString() ??
          '',
      role: userData['role']?.toString() ?? 'patient',
      isApproved:
          userData['privacyPolicyAccepted'] ?? userData['isApproved'] ?? true,
      profileImageUrl: userData['profileImageUrl']?.toString(),
      hospitalId: userData['hospitalId']?.toString(),
      hospitalName: userData['hospitalName']?.toString(),
      isOnboarded: userData['isHealthProfileComplete'] == true ||
          userData['onboardingCompleted'] == true ||
          userData['isOnboarded'] == true ||
          (userData['role'] != null && userData['role'] != 'patient') ||
          (userData['dob'] != null &&
              userData['dob'].toString().isNotEmpty &&
              userData['dob'].toString() != 'DD / MM / YYYY') ||
          (userData['bloodType'] != null),
      dob: userData['dob'],
      city: userData['city'],
      address: userData['address'],
      firstName: userData['firstName'],
      lastName: userData['lastName'],
      emergencyContact: userData['emergencyContact'] != null
          ? EmergencyContact.fromJson(userData['emergencyContact'])
          : null,
      healthProfile: userData['healthProfile'] != null
          ? HealthProfile.fromJson(userData['healthProfile'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'mobileNumber': mobileNumber,
      'role': role,
      'isApproved': isApproved,
      'profileImageUrl': profileImageUrl,
      'hospitalId': hospitalId,
      'hospitalName': hospitalName,
      'isOnboarded': isOnboarded,
      'dob': dob,
      'city': city,
      'address': address,
      'firstName': firstName,
      'lastName': lastName,
      'emergencyContact': emergencyContact?.toJson(),
      'healthProfile': healthProfile?.toJson(),
    };
  }
}

class EmergencyContact {
  final String? firstName;
  final String? lastName;
  final String? relationship;
  final String? phone;
  final String? email;
  final String? city;
  final String? address;

  EmergencyContact({
    this.firstName,
    this.lastName,
    this.relationship,
    this.phone,
    this.email,
    this.city,
    this.address,
  });

  factory EmergencyContact.fromJson(Map<String, dynamic> json) {
    return EmergencyContact(
      firstName: json['firstName'],
      lastName: json['lastName'],
      relationship: json['relationship'],
      phone: json['phone'],
      email: json['email'],
      city: json['city'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'relationship': relationship,
      'phone': phone,
      'email': email,
      'city': city,
      'address': address,
    };
  }
}

class HealthProfile {
  final String? bloodType;
  final String? rhFactor;
  final String? allergies;
  final String? chronicConditions;
  final double? height;
  final double? weight;
  final BloodPressure? bloodPressure;
  final double? oxygenSaturation;
  final String? notes;

  HealthProfile({
    this.bloodType,
    this.rhFactor,
    this.allergies,
    this.chronicConditions,
    this.height,
    this.weight,
    this.bloodPressure,
    this.oxygenSaturation,
    this.notes,
  });

  factory HealthProfile.fromJson(Map<String, dynamic> json) {
    return HealthProfile(
      bloodType: json['bloodType'],
      rhFactor: json['rhFactor'],
      allergies: json['allergies'],
      chronicConditions: json['chronicConditions'],
      height: (json['height'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      bloodPressure: json['bloodPressure'] != null
          ? BloodPressure.fromJson(json['bloodPressure'])
          : null,
      oxygenSaturation: (json['oxygenSaturation'] as num?)?.toDouble(),
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bloodType': bloodType,
      'rhFactor': rhFactor,
      'allergies': allergies,
      'chronicConditions': chronicConditions,
      'height': height,
      'weight': weight,
      'bloodPressure': bloodPressure?.toJson(),
      'oxygenSaturation': oxygenSaturation,
      'notes': notes,
    };
  }
}

class BloodPressure {
  final int? systolic;
  final int? diastolic;

  BloodPressure({this.systolic, this.diastolic});

  factory BloodPressure.fromJson(Map<String, dynamic> json) {
    return BloodPressure(
      systolic: json['systolic'] as int?,
      diastolic: json['diastolic'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'systolic': systolic,
      'diastolic': diastolic,
    };
  }
}

class HospitalModel {
  final String id;
  final String hospitalName;
  final String location;
  final String email;
  final String mobileNumber;
  final bool isApproved;
  final List<String> doctorIds;

  HospitalModel({
    required this.id,
    required this.hospitalName,
    required this.location,
    required this.email,
    required this.mobileNumber,
    this.isApproved = false,
    this.doctorIds = const [],
  });

  factory HospitalModel.fromJson(Map<String, dynamic> json) {
    return HospitalModel(
      id: json['id'] ?? json['_id'] ?? '',
      hospitalName:
          json['hospitalName'] ?? json['name'] ?? json['userName'] ?? '',
      location: json['location'] ?? '',
      email: json['email'] ?? '',
      mobileNumber: json['phone'] ?? json['mobileNumber'] ?? '',
      isApproved: json['isApproved'] ?? false,
      doctorIds: List<String>.from(json['doctorIds'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hospitalName': hospitalName,
      'location': location,
      'email': email,
      'mobileNumber': mobileNumber,
      'isApproved': isApproved,
      'doctorIds': doctorIds,
    };
  }
}

class DashboardData {
  final int upcomingAppointments;
  final int pendingReports;
  final int healthScore;
  final String? summary;

  DashboardData({
    required this.upcomingAppointments,
    required this.pendingReports,
    required this.healthScore,
    this.summary,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      upcomingAppointments:
          json['upcomingAppointments'] ?? json['upcoming_appointments'] ?? 0,
      pendingReports: json['labReports'] ?? json['pending_reports'] ?? 0,
      healthScore: json['healthScore'] ?? json['health_score'] ?? 0,
      summary: json['summary'],
    );
  }
}
