class ContactUsModel {
  final String name;
  final String email;
  final String message;

  ContactUsModel({
    required this.name,
    required this.email,
    required this.message,
  });

  factory ContactUsModel.fromJson(Map<String, dynamic> json) {
    return ContactUsModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      message: json['message'] ?? '',
    );
  }
}
