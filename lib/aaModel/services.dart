class Service {
  String serviceCode;
  String serviceName;
  String serviceIcon;
  int serviceTariff;

  Service({
    required this.serviceCode,
    required this.serviceName,
    required this.serviceIcon,
    required this.serviceTariff,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        serviceCode: json["service_code"],
        serviceName: json["service_name"],
        serviceIcon: json["service_icon"],
        serviceTariff: json["service_tariff"],
      );
}
