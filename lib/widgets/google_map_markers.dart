import "package:flutter/material.dart";
import "package:flutter_restaurant/repositories/mark_repositories.dart";
import "package:flutter_restaurant/widgets/error_detail_widget.dart";
import "package:flutter_restaurant/widgets/wait_location_widget.dart";
import "package:geolocator/geolocator.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";

class GoogleMapMarkers extends StatelessWidget {
  final Position userPosition;
  final List<String> markers;

  const GoogleMapMarkers(
      {required this.userPosition, required this.markers, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MarkRespositories.getMarkers(this.userPosition, this.markers),
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return ErrorDetailWidget(
            errorMessage: snapshot.error.toString(),
          );

        if (!snapshot.hasData)
          return WaitLocationWidget(
            message: "Encontrando pontos de interesse",
          );

        return GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(
                  this.userPosition.latitude, this.userPosition.longitude),
              zoom: 14),
          markers: snapshot.data!,
        );
      },
    );
  }
}
