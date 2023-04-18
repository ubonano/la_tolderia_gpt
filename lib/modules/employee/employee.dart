class Employee {
  final String id;
  final String identificationNumber;
  final String firstName;
  final String lastName;
  final String branchName;
  final String branchId;
  final String phone;
  final String email;
  final String address;
  final bool isActive;

  Employee({
    this.id = '',
    required this.identificationNumber,
    required this.firstName,
    required this.lastName,
    required this.branchName,
    required this.branchId,
    required this.phone,
    required this.email,
    required this.address,
    required this.isActive,
  });

  factory Employee.fromDocument(Map<String, dynamic> map, String id) {
    return Employee(
      id: id,
      identificationNumber: map['identificationNumber'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      branchName: map['branchName'],
      branchId: map['branchId'],
      phone: map['phone'],
      email: map['email'],
      address: map['address'],
      isActive: map['isActive'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'identificationNumber': identificationNumber,
      'firstName': firstName,
      'lastName': lastName,
      'branchName': branchName,
      'branchId': branchId,
      'phone': phone,
      'email': email,
      'address': address,
      'isActive': isActive,
    };
  }
}
