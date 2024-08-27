class Variables {
  static const String baseUrl = "http://192.168.100.29:8000";
  static const String baseUrlImage = '$baseUrl/storage/products/';

  static const String _rajaOngkirStarterKey = '';
  static const String _rajaOngkirProKey = 'f774d2c9f8e361a935ba992a1fca0efa';
  
  static const String _rajaOngkirStarterBaseUrl = 'https://api.rajaongkir.com/starter';
  static const String _rajaOngkirProBaseUrl = 'https://pro.rajaongkir.com/api';
  
  static const usingPro = true;

  static String get rajaOngkierBaseUrl =>
      usingPro ? _rajaOngkirProBaseUrl : _rajaOngkirStarterBaseUrl;


  static String get rajaOngkirKey =>
      Variables.usingPro ? _rajaOngkirProKey : _rajaOngkirStarterKey;
}
