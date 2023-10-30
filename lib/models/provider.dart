import 'dart:convert';

class Provider {
  Provider({
    required this.list
  });

  List<ProviderList> list;

  factory Provider.fromJson(String str) => Provider.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Provider.fromMap(Map<String, dynamic> json) => Provider(
    list: List<ProviderList>.from(json["Proveedores Listado"].map((x) => ProviderList.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "Proveedores Listado": List<dynamic>.from(list.map((x) => x.toMap())),
  };
}

class ProviderList {
  ProviderList({
    required this.providerId,
    required this.providerName,
    required this.providerLastName,
    required this.providerEmail,
    required this.providerState,
  });

  int providerId;
  String providerName;
  String providerLastName;
  String providerEmail;
  String providerState;

  factory ProviderList.fromJson(String str) => ProviderList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProviderList.fromMap(Map<String, dynamic> json) => ProviderList(
    providerId: json["providerid"],
    providerName: json["provider_name"],
    providerLastName: json["provider_last_name"],
    providerEmail: json["provider_mail"],
    providerState: json["provider_state"],
  );

  Map<String, dynamic> toMap() => {
    "providerid": providerId,
    "provider_name": providerName,
    "provider_last_name": providerLastName,
    "provider_mail": providerEmail,
    "provider_state": providerState
  };

  ProviderList copy() => ProviderList(
    providerId: providerId,
    providerName: providerName,
    providerLastName: providerLastName,
    providerEmail: providerEmail,
    providerState: providerState
  );
}