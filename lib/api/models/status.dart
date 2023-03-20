class Status {
  final bool? status;
  final String? token;

  final String? error;
  final String? message;

  Status({this.token, this.status, this.error, this.message,});
  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
        status: json['status'] ?? false,
        token: json['access_token'] ?? '',
        error: json['error'] ?? '',
        message: json['message'] ?? '');
  }
}
