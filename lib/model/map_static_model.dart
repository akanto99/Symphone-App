class MapMarker {
  final int id;
  final String name;
  final String details;
  final double latitude;
  final double longitude;

  MapMarker({
    required this.id,
    required this.name,
    required this.details,
    required this.latitude,
    required this.longitude,
  });
}

final List<MapMarker> markersList = [
  MapMarker(id: 1, name: "Uttara Sector 3 Park",details:"Service Touch Point, Configure Bepari Shopping\nComplex, Uttara, Dhaka - 1212",latitude: 23.8759, longitude: 90.3795),
  MapMarker(id: 2, name: "Uttara Lake Park",details:"Service Touch Point, Configure Bepari Shopping\nComplex, Uttara, Dhaka - 1212", latitude: 23.8798, longitude: 90.3852),
  MapMarker(id: 3, name: "Rajlokkhi Complex",details:"Service Touch Point, Configure Bepari Shopping\nComplex, Uttara, Dhaka - 1212", latitude: 23.8723, longitude: 90.3829),
  MapMarker(id: 4, name: "North Tower Shopping Mall", details:"Service Touch Point, Configure Bepari Shopping\nComplex, Uttara, Dhaka - 1212",latitude: 23.8705, longitude: 90.3941),
  MapMarker(id: 5, name: "Diabari Lake View",details:"Service Touch Point, Configure Bepari Shopping\nComplex, Uttara, Dhaka - 1212", latitude: 23.8912, longitude: 90.3778),
  MapMarker(id: 6, name: "Fantasy Island Park",details:"Service Touch Point, Configure Bepari Shopping\nComplex, Uttara, Dhaka - 1212", latitude: 23.8935, longitude: 90.3742),
  MapMarker(id: 7, name: "Shanta Western Tower",details:"Service Touch Point, Configure Bepari Shopping\nComplex, Uttara, Dhaka - 1212", latitude: 23.8639, longitude: 90.4001),
  MapMarker(id: 8, name: "Dhaka Airport Railway Station",details:"Service Touch Point, Configure Bepari Shopping\nComplex, Uttara, Dhaka - 1212", latitude: 23.8514, longitude: 90.4055),
  MapMarker(id: 9, name: "Jashim Uddin Avenue", details:"Service Touch Point, Configure Bepari Shopping\nComplex, Uttara, Dhaka - 1212",latitude: 23.8680, longitude: 90.3812),
  MapMarker(id: 10, name: "BNS Center",details:"Service Touch Point, Configure Bepari Shopping\nComplex, Uttara, Dhaka - 1212", latitude: 23.8654, longitude: 90.3803),
];
