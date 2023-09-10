class BalanceModel {
  final int status;
  final String message;
  final BalanceData data;

  BalanceModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BalanceModel.fromJson(Map<String, dynamic> json) {
    return BalanceModel(
      status: json['status'] as int,
      message: json['message'] as String,
      data: BalanceData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class BalanceData {
  final int balance;

  BalanceData({
    required this.balance,
  });

  factory BalanceData.fromJson(Map<String, dynamic> json) {
    return BalanceData(
      balance: json['balance'] as int,
    );
  }
}
