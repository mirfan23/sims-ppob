class TransactionResponse {
  final int status;
  final String message;
  final TransactionData data;

  TransactionResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    return TransactionResponse(
      status: json['status'],
      message: json['message'],
      data: TransactionData.fromJson(json['data']),
    );
  }
}

class TransactionData {
  final String invoiceNumber;
  final String serviceCode;
  final String serviceName;
  final String transactionType;
  final int totalAmount;
  final DateTime createdOn;

  TransactionData({
    required this.invoiceNumber,
    required this.serviceCode,
    required this.serviceName,
    required this.transactionType,
    required this.totalAmount,
    required this.createdOn,
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
      invoiceNumber: json['invoice_number'],
      serviceCode: json['service_code'],
      serviceName: json['service_name'],
      transactionType: json['transaction_type'],
      totalAmount: json['total_amount'],
      createdOn: DateTime.parse(json['created_on']),
    );
  }
}
