class TransactionHistoryResponse {
  int status;
  String message;
  TransactionHistoryData data;

  TransactionHistoryResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TransactionHistoryResponse.fromJson(Map<String, dynamic> json) =>
      TransactionHistoryResponse(
        status: json["status"],
        message: json["message"],
        data: TransactionHistoryData.fromJson(json["data"]),
      );
}

class TransactionHistoryData {
  int offset;
  int limit;
  List<TransactionRecord> records;

  TransactionHistoryData({
    required this.offset,
    required this.limit,
    required this.records,
  });

  factory TransactionHistoryData.fromJson(Map<String, dynamic> json) =>
      TransactionHistoryData(
        offset: json["offset"],
        limit: json["limit"],
        records: List<TransactionRecord>.from(
            json["records"].map((x) => TransactionRecord.fromJson(x))),
      );
}

class TransactionRecord {
  String invoiceNumber;
  String transactionType;
  String description;
  int totalAmount;
  DateTime createdOn;

  TransactionRecord({
    required this.invoiceNumber,
    required this.transactionType,
    required this.description,
    required this.totalAmount,
    required this.createdOn,
  });

  factory TransactionRecord.fromJson(Map<String, dynamic> json) =>
      TransactionRecord(
        invoiceNumber: json["invoice_number"],
        transactionType: json["transaction_type"],
        description: json["description"],
        totalAmount: json["total_amount"],
        createdOn: DateTime.parse(json["created_on"]),
      );
}
