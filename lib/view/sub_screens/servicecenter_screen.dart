import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:symphone_app/model/map_static_model.dart';
import 'package:symphone_app/provider/DarkAndLightTheme/theme_provider.dart';
import 'package:symphone_app/res/color.dart';
import 'package:symphone_app/responsive/responsive_ui.dart';
import 'package:symphone_app/view/navigation_bar.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  int _currentIndex = 1;
  final List<String> _labels = ['Website', 'Home', 'Social'];
  final List<String> _svgPaths = [
    'assets/images/navImages/web.svg',
    'assets/images/navImages/home.svg',
    'assets/images/navImages/social.svg',
  ];

  late GoogleMapController mapController;
  final LatLng _initialPosition = LatLng(23.8759, 90.3795);
  LatLng? _currentLocation;

  final Location _location = Location();
  Set<Marker> _markers = {};

  Polyline _polyline = Polyline(
    polylineId: PolylineId("route"),
    color: Colors.blue,
    width: 5,
  );

  @override
  void initState() {
    super.initState();
    _fetchUserLocation();
  }

  Future<void> _fetchUserLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) return;
    }

    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    LocationData locationData = await _location.getLocation();
    setState(() {
      _currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
    });

    /// Listen for location updates and update the heading (direction)
    _location.onLocationChanged.listen((LocationData newLocation) {
      setState(() {
        _currentLocation = LatLng(newLocation.latitude!, newLocation.longitude!);
      });

      /// Only update the position, not the heading
      if (mapController != null && _currentLocation != null) {
        mapController.animateCamera(
          CameraUpdate.newLatLng(_currentLocation!),
        );
      }
    });
  }

  Future<void> _getDirections(LatLng destination) async {
    if (_currentLocation == null) return;

    final origin = "${_currentLocation!.latitude},${_currentLocation!.longitude}";
    final dest = "${destination.latitude},${destination.longitude}";

    final url = 'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$dest&key=AIzaSyDNvq6_p6fyrz06aFXl4nt3eOkbKF3s2Hg';

    final response = await http.get(Uri.parse(url));
    print("API Response: ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final routes = data['routes'];

      if (routes.isNotEmpty) {
        final polylinePoints = routes[0]['overview_polyline']['points'];
        List<LatLng> polylineCoordinates = _decodePoly(polylinePoints);

        if (polylineCoordinates.isNotEmpty) {
          setState(() {
            _polyline = Polyline(
              polylineId: PolylineId("route"),
              color: Colors.blue,
              width: 5,
              points: polylineCoordinates,
            );
          });
        }
      } else {
        print("No routes found.");
      }
    } else {
      print("Failed to get directions. Status code: ${response.statusCode}");
    }
  }

  /// Decode polyline points
  List<LatLng> _decodePoly(String poly) {
    List<LatLng> polylineCoordinates = [];
    int index = 0, len = poly.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int shift = 0, result = 0;
      while (true) {
        int c = poly.codeUnitAt(index) - 63;
        index++;
        result |= (c & 0x1f) << shift;
        shift += 5;
        if (c < 0x20) break;
      }
      int dlat = (result & 0x1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;
      while (true) {
        int c = poly.codeUnitAt(index) - 63;
        index++;
        result |= (c & 0x1f) << shift;
        shift += 5;
        if (c < 0x20) break;
      }
      int dlng = (result & 0x1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      polylineCoordinates.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return polylineCoordinates;
  }


/// Method to create markers
  Set<Marker> _createMarkers() {
    Set<Marker> markers = {};
    for (var marker in markersList) {
      markers.add(
        Marker(
          markerId: MarkerId(marker.id.toString()),
          position: LatLng(marker.latitude, marker.longitude),
          infoWindow: InfoWindow(title: marker.name),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    }

    return markers;
  }

/// Method to calculate distance between two LatLng points
  double _calculateDistance(LatLng start, LatLng end) {
    double distanceInMeters = Geolocator.distanceBetween(
        start.latitude, start.longitude, end.latitude, end.longitude);
    return distanceInMeters / 1000; // Convert to kilometers
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ResPonsiveUi(
          mobile: body(),
          desktop: body(),
          tablet: body(),
        ),
      ),
    );
  }

  Widget body() {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Container(
      height: screenHeight,
      decoration: BoxDecoration(
        // color: isDarkMode ? Colors.black : null,
        gradient: isDarkMode
            ? null
            : const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF1F7FF),
            Color(0xFFF6F6F6),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: screenWidth,
            decoration: BoxDecoration(
              color: isDarkMode ? AppColors.blackColor :  Color(0xFFF1F7FF),
            ),
            child: Column(
              children: [
                SizedBox(height: screenHeight*0.02,),
                Container(
                  width: screenWidth * 0.90,
                  child: Row(
                    children: [
                      InkWell(
                          onTap:(){
                            Navigator.pop(context);
                          },
                          child: Container(
                              width: screenWidth*0.08,
                              color: Colors.transparent,
                              alignment: Alignment.centerLeft,
                              child: Icon(Icons.arrow_back_ios, color: Colors.red,))),
                      // SizedBox(width: screenWidth*0.02,),
                      Text("Service Center",
                          style: GoogleFonts.urbanist(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: themeProvider.isDarkMode ? AppColors.whiteColor: AppColors.blackColor,
                            letterSpacing: 0.8,
                          )
                      )
                    ],
                  ),
                ),
                SizedBox(height: screenHeight*0.02,),
              ],
            ),
          ),

          Container(
            height: screenHeight*0.45,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _currentLocation ?? _initialPosition,
                zoom: 14,
              ),
              markers: _createMarkers()..addAll(_markers),
              polylines: {_polyline},
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.blackColor:AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                border: Border(
                  top: BorderSide(width: 1, color: isDarkMode ? AppColors.blackColor : AppColors.redColor.withOpacity(0.2)),
                  left: BorderSide(width: 1, color: isDarkMode ? AppColors.blackColor : AppColors.redColor.withOpacity(0.2)),
                  right: BorderSide(width: 1, color: isDarkMode ? AppColors.blackColor :AppColors.redColor.withOpacity(0.2)),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: screenHeight*0.02,),
                  Container(
                    height: screenHeight * 0.006,
                    width: screenWidth * 0.2,
                    decoration: BoxDecoration(
                      color:  isDarkMode ?Color(0xff414243):AppColors.shadeGreyColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  SizedBox(height: screenHeight*0.01,),
                  Expanded(
                    child: Container(
                      width: screenWidth,
                      child: ListView.builder(
                        itemCount: markersList.length,
                        itemBuilder: (context, index) {
                          final marker = markersList[index];

                          // Calculate the distance for each marker
                          double distance = _calculateDistance(
                            _currentLocation ?? _initialPosition,
                            LatLng(marker.latitude, marker.longitude),
                          );

                          return Column(
                            children: [
                              Center(
                                child: Container(
                                  width: screenWidth*0.90,
                                  // color: Colors.yellow,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                    Text(marker.name,
                                        style: GoogleFonts.urbanist(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: isDarkMode ? AppColors.whiteColor : AppColors.blackColor,
                                          letterSpacing: 0.4,
                                          height: 2,
                                        ) ),
                                      Text(
                                        marker.details,
                                          style: GoogleFonts.urbanist(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: isDarkMode ? AppColors.whiteColor : AppColors.blackColor,
                                            letterSpacing: 0.2,
                                            height: 1.5,
                                          )),
                                      Text("${distance.toStringAsFixed(2)} km",
                                          style: GoogleFonts.urbanist(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.redColor,
                                            letterSpacing: 0.8,
                                          )),
                                      SizedBox(height: screenHeight*0.01,),
                                  Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [

                                          GestureDetector(
                                            onTap: (){
                                              _getDirections(LatLng(marker.latitude, marker.longitude));
                                              print("Index: $index, Latitude: ${marker.latitude}, Longitude: ${marker.longitude}");

                                            },
                                            child: Container(
                                              height: screenHeight*0.048,
                                              width: screenWidth*0.3,
                                              decoration: BoxDecoration(
                                                  color:AppColors.redColor,
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                              child:Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.directions, color: Colors.white),
                                                  SizedBox(width: screenWidth*0.01,),
                                                  AutoSizeText("Direction" ,
                                                          style: GoogleFonts.urbanist(
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w500,
                                                            color: isDarkMode ? AppColors.whiteColor : AppColors.whiteColor,
                                                            letterSpacing: 0.8,),
                                                                                          ),
                                                ],
                                              ),),
                                          ),
                                          SizedBox(width: screenWidth*0.05,),
                                          GestureDetector(
                                            onTap: (){
                                              String shareContent = "Check out this location: ${marker.name}, Distance: ${distance.toStringAsFixed(2)} km";
                                              Share.share(shareContent);
                                            },
                                            child: Container(
                                              height: screenHeight*0.048,
                                              width: screenWidth*0.3,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: AppColors.borderColor,
                                                  width: 1
                                                )
                                              ),
                                              child:Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.share, color:isDarkMode ? AppColors.whiteColor : AppColors.redColor, ),
                                                  SizedBox(width: screenWidth*0.01,),
                                                  AutoSizeText("Share" ,
                                                    style: GoogleFonts.urbanist(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w500,
                                                      color:isDarkMode ? AppColors.whiteColor : AppColors.redColor,
                                                      letterSpacing: 0.8,),
                                                  ),
                                                ],
                                              ),),
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: screenHeight*0.02,),
                              Container(
                                width: screenWidth*0.90,
                                child: Divider(height: 1,
                                ),
                              ),
                              SizedBox(height: screenHeight*0.02,),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
           color: isDarkMode ? AppColors.blackColor : AppColors.whiteColor,
            child: Container(
              height: screenHeight * 0.09,
              decoration: BoxDecoration(
                color: isDarkMode ? Color(0xff181818) : AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
                boxShadow: [
                  BoxShadow(
                    color: isDarkMode ? AppColors.blackColor : Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
                border: Border(
                  top: BorderSide(width: 2, color: isDarkMode ? AppColors.blackOpColor : AppColors.borderColor),
                  left: BorderSide(width: 2, color: isDarkMode ? AppColors.blackOpColor : AppColors.borderColor),
                  right: BorderSide(width: 2, color: isDarkMode ? AppColors.blackOpColor : AppColors.borderColor),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(_labels.length, (index) {
                  bool isSelected = _currentIndex == index;
                  return InkWell(
                    onTap: () async {
                      setState(() {
                        _currentIndex = index;
                      });
                      await Future.delayed(Duration(milliseconds: 300));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavigationScreen(initialIndex: index),
                        ),
                      );
                      print(index);
                      setState(() {
                        _currentIndex = -1;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: screenWidth * 0.14,
                            child: SvgPicture.asset(
                              _svgPaths[index],
                              height: 24,
                              width: 24,
                              colorFilter: ColorFilter.mode(
                                isSelected ? AppColors.redColor : (isDarkMode ? AppColors.whiteColor : Colors.black),
                                // AppColors.greyColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            _labels[index],
                            style: TextStyle(
                              color: isSelected ? AppColors.redColor : (isDarkMode ? AppColors.whiteColor : Colors.black), // Adjust text color based on mode
                              fontSize: isSelected ? 14 : 12,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
