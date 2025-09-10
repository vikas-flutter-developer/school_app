// Example structure for data/admin_profile_data.dart
class AdminProfileData {
  final String name;
  final String designation; // e.g., "Delhi Public School"
  final String? profileImageUrl; // Make nullable for placeholder
  final String status;
  final String dob;
  final String email;
  final String mobile;
  final String bloodGroup;
  final String gender;
  final String address;

  AdminProfileData({
    required this.name,
    required this.designation,
    this.profileImageUrl,
    required this.status,
    required this.dob,
    required this.email,
    required this.mobile,
    required this.bloodGroup,
    required this.gender,
    required this.address,
  });
}

// Example Dummy Data
final dummyAdminProfileData = AdminProfileData(
  name: 'NAVEEN NAVEEN',
  designation: 'Delhi Public School',
  profileImageUrl: 'assets/images/img_1.png', // <-- USE YOUR LOCAL ASSET PATH or null
  status: 'Admin',
  dob: '05/11/1998',
  email: 'naveen1234@gmail.com',
  mobile: '9090909090',
  bloodGroup: 'O +ve',
  gender: 'Male',
  address: 'C/o 342, D.P Nagar,\nBengaluru, KA-560000',
);