class TopUpResponse {
  final int status;
  final String message;
  final Map<String, dynamic> data;

  TopUpResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TopUpResponse.fromJson(Map<String, dynamic> json) {
    return TopUpResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'],
    );
  }
}
