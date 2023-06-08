class Constants {
  // development server
  static const String borlaGoBaseUrl = "http://10.0.2.2:8000/api/v1";


  static const String supabaseProjectUrl = "https://jdztvuuclwiungvdvrie.supabase.co";
  static const String supabasePublicKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpkenR2dXVjbHdpdW5ndmR2cmllIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODI3MTUyMjAsImV4cCI6MTk5ODI5MTIyMH0.fnWb-2xbHQCgFkLiWRmyQIJd54b5ZQHlCv5eMAbOHpE";
  static const int userType = 2;
  static const List<String> wasteTypes = ["General", "Organic", "Hazardous"];
  static const List<String> languages = ["English", "Français"];

  static  Map<String, String> currencies = {
    "Benin": "XOF",
    "Burkina Faso": "XOF",
    "Cape Verde": "CVE",
    "Côte d'Ivoire": "XOF",
    "Gambia": "GMD",
    "Ghana": "GHS",
    "Guinea": "GNF",
    "Guinea-Bissau": "XOF",
    "Liberia": "LRD",
    "Mali": "XOF",
    "Mauritania": "MRU",
    "Niger": "XOF",
    "Nigeria": "NGN",
    "Senegal": "XOF",
    "Sierra Leone": "SLL",
    "Togo": "XOF"
  };

  static const countries = [
    "Benin",
    "Burkina Faso",
    "Cape Verde",
    "Côte d'Ivoire",
    "Gambia",
    "Ghana",
    "Guinea",
    "Guinea-Bissau",
    "Liberia",
    "Mali",
    "Mauritania",
    "Niger",
    "Nigeria",
    "Senegal",
    "Sierra Leone",
    "Togo"
  ];
}