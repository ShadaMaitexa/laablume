# LabLume - Comprehensive Healthcare Platform

## Project Overview

LabLume is an innovative comprehensive healthcare platform that revolutionizes the way patients interact with medical laboratory services in Kerala. The system integrates three core functionalities:

1. **Intelligent Lab Test Booking** - GPS-based lab discovery, test browsing, and appointment scheduling
2. **AI-Powered Report Analysis** - Automatic parsing and analysis of lab reports with patient-friendly explanations
3. **Integrated Doctor Consultation** - Online and offline doctor consultations with AI-driven recommendations

## Features Implemented

### 🏠 Patient Dashboard
- Quick stats showing appointments, reports, and health score
- Quick action cards for:
  - Book Lab Test
  - Upload Report (AI Analysis)
  - Find Doctors
  - My Reports
- AI-powered features highlight
- Health tips section

### 🧪 Lab Test Booking System
**Screens:**
- `lab_tests_screen.dart` - Browse all available lab tests
- `test_details_screen.dart` - Detailed test information
- `book_test_screen.dart` - Complete booking flow

**Features:**
- Search and filter tests
- Popular tests highlighting
- Test categories (All, Popular, Packages)
- Detailed test information (price, preparation, description)
- Home sample collection option
- Lab visit option with nearby lab discovery
- Date and time slot selection
- Payment integration ready

### 📊 AI-Powered Report Analysis
**Screens:**
- `lab_reports_screen.dart` - View all lab reports
- `upload_report_screen.dart` - Upload new reports for AI analysis
- `report_detail_screen.dart` - Detailed AI analysis view

**Features:**
- Upload reports via camera, gallery, or PDF
- AI-powered analysis simulation (ready for backend integration)
- Color-coded health indicators (Normal, Attention, Critical)
- Test parameter breakdown with normal ranges
- Personalized health recommendations
- Historical report tracking
- Share and download reports

### 👨‍⚕️ Doctor Consultation System
**Screens:**
- `find_doctors_screen.dart` - Discover doctors by specialty
- `doctor_detail_screen.dart` - Doctor profile and reviews
- `book_consultation_screen.dart` - Book consultation appointments

**Features:**
- Search doctors by name or specialty
- Filter by specialty (General Physician, Cardiologist, etc.)
- Doctor ratings and reviews
- Online video consultation option
- Offline clinic visit option
- View doctor education, experience, and hospital
- Date and time slot selection
- Symptoms/reason input
- Consultation fee summary
- Payment integration ready

### 📱 Additional Screens
- `main_navigation_screen.dart` - Bottom navigation with 4 tabs
- `patient_homescreen.dart` - Enhanced home screen with all features
- `medical_records_screen.dart` - Access to all medical records
- `chat_screen.dart` - Doctor messaging
- `profile_screen.dart` - User profile management

## Technology Stack

### Frontend
- **Framework:** Flutter 3.9.2
- **Language:** Dart
- **UI/UX:** Material Design with custom theming
- **Fonts:** Google Fonts (Poppins)
- **State Management:** StatefulWidget (ready for Provider/Riverpod)

### Design System
- **Primary Color:** #12B8A6 (Teal)
- **Background:** #EFF7F6 (Light Teal)
- **Typography:** Poppins font family
- **Components:** Consistent card-based design with shadows and rounded corners

## Project Structure

```
lib/
├── main.dart
├── screens/
│   ├── auth/
│   │   ├── login.dart
│   │   ├── register.dart
│   │   └── otp_screen.dart
│   ├── common/
│   │   ├── splash_screen.dart
│   │   ├── welcome1.dart
│   │   ├── welcome2.dart
│   │   └── welcome3.dart
│   ├── lab_tests/
│   │   ├── lab_tests_screen.dart
│   │   ├── test_details_screen.dart
│   │   └── book_test_screen.dart
│   ├── reports/
│   │   ├── lab_reports_screen.dart
│   │   ├── upload_report_screen.dart
│   │   └── report_detail_screen.dart
│   ├── doctors/
│   │   ├── find_doctors_screen.dart
│   │   ├── doctor_detail_screen.dart
│   │   └── book_consultation_screen.dart
│   ├── main_navigation_screen.dart
│   ├── patient_homescreen.dart
│   ├── medical_records_screen.dart
│   ├── chat_screen.dart
│   ├── profile_screen.dart
│   ├── emergency_contact.dart
│   ├── health_assesment.dart
│   └── patient_card.dart
└── services/
```

## Backend Integration Points

All screens are designed to be **API-ready**. Here are the key integration points:

### 1. Lab Tests API
```dart
// GET /api/lab-tests
Future<List<LabTest>> fetchLabTests()

// GET /api/lab-tests/{id}
Future<LabTest> getTestDetails(String id)

// POST /api/bookings
Future<Booking> bookTest(BookingData data)

// GET /api/labs/nearby
Future<List<LabLocation>> fetchNearbyLabs()
```

### 2. Reports & AI Analysis API
```dart
// GET /api/reports
Future<List<LabReport>> fetchLabReports()

// POST /api/reports/upload
Future<String> uploadReport(File file)

// POST /api/reports/analyze
Future<AIAnalysis> analyzeReport(String reportId)

// GET /api/reports/{id}
Future<ReportDetail> getReportDetail(String id)
```

### 3. Doctor Consultation API
```dart
// GET /api/doctors
Future<List<Doctor>> fetchDoctors()

// GET /api/doctors/{id}
Future<Doctor> getDoctorDetail(String id)

// POST /api/consultations/book
Future<Consultation> bookConsultation(ConsultationData data)

// GET /api/doctors/specialties
Future<List<String>> getSpecialties()
```

### 4. Dashboard API
```dart
// GET /api/dashboard
Future<Map<String, dynamic>> fetchDashboardData()
```

## Data Models

All models include `fromJson` factory constructors for easy API integration:

### LabTest Model
```dart
class LabTest {
  final String id;
  final String name;
  final String description;
  final double price;
  final String preparationTime;
  final String category;
  final bool isPopular;
  
  factory LabTest.fromJson(Map<String, dynamic> json)
}
```

### LabReport Model
```dart
class LabReport {
  final String id;
  final String testName;
  final DateTime date;
  final String status;
  final String labName;
  final bool hasAbnormalities;
  
  factory LabReport.fromJson(Map<String, dynamic> json)
}
```

### Doctor Model
```dart
class Doctor {
  final String id;
  final String name;
  final String specialty;
  final int experience;
  final double rating;
  final int reviewCount;
  final double consultationFee;
  final DateTime nextAvailable;
  final bool isOnline;
  final List<String> languages;
  final String education;
  final String hospital;
  
  factory Doctor.fromJson(Map<String, dynamic> json)
}
```

## AI Analysis Feature

The AI analysis feature is implemented with a simulation that demonstrates the expected functionality:

1. **Upload Flow:**
   - User selects file (camera/gallery/PDF)
   - File is uploaded to backend
   - AI service processes the report
   - Analysis is returned and displayed

2. **Analysis Components:**
   - Overall health status
   - Key findings with color coding
   - Test parameters with normal ranges
   - Personalized recommendations
   - Critical value detection

3. **Backend Requirements:**
   - OCR service for PDF/image parsing
   - ML model for abnormality detection
   - NLP for generating patient-friendly explanations

## Running the Project

1. **Install Dependencies:**
```bash
flutter pub get
```

2. **Run the App:**
```bash
flutter run
```

3. **Build APK:**
```bash
flutter build apk --release
```

## Next Steps for Backend Integration

1. **Create API Service Layer:**
   - Create `lib/services/api_service.dart`
   - Implement HTTP client (dio/http package)
   - Add authentication headers
   - Handle error responses

2. **Implement State Management:**
   - Add Provider or Riverpod
   - Create state classes for each feature
   - Implement loading and error states

3. **Add Real File Upload:**
   - Integrate `image_picker` package
   - Implement `file_picker` for PDFs
   - Add multipart file upload

4. **Payment Integration:**
   - Integrate Razorpay/Stripe
   - Implement payment confirmation flow
   - Add payment history

5. **Video Consultation:**
   - Integrate WebRTC or Agora SDK
   - Implement video call UI
   - Add chat functionality

6. **Notifications:**
   - Implement Firebase Cloud Messaging
   - Add local notifications
   - Handle notification navigation

## Design Highlights

- **Modern UI:** Clean, professional design with smooth animations
- **Color Coding:** Intuitive health status indicators
- **Accessibility:** Large touch targets, readable fonts
- **Responsive:** Adapts to different screen sizes
- **Consistent:** Unified design language across all screens

## Notes

- All TODO comments mark backend integration points
- Mock data is used for demonstration
- All screens are fully functional with navigation
- Ready for production with backend APIs

## Contact

For questions or support regarding the UI implementation, please refer to the code comments and model structures.
