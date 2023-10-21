import "package:flutter/material.dart";
import "package:flutter_restaurant/repositories/mark_repositories.dart";
import "package:flutter_restaurant/repositories/user_localization_repository.dart";
import "package:flutter_restaurant/widgets/error_detail_widget.dart";
import "package:flutter_restaurant/widgets/google_map_markers.dart";
import "package:flutter_restaurant/widgets/nav_drawer.dart";
import "package:flutter_restaurant/widgets/wait_location_widget.dart";
import "package:geolocator/geolocator.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.purple,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
      ),
      drawer: NavDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {},
        child: Icon(Icons.search),
      ),
      body: FutureBuilder(
        future: UserLocalizationRepository.getCurrentPosition(),
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return ErrorDetailWidget(
              errorMessage: snapshot.error.toString(),
            );

          if (!snapshot.hasData)
            return WaitLocationWidget(
              message: "Buscando sua localização atual...",
            );

          Position currentPosition = snapshot.data!;

          return GoogleMapMarkers(
              userPosition: currentPosition, markers: ["restaurant"]);
        },
      ),
    );
  }
}
