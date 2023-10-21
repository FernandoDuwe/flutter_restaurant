import 'package:flutter/material.dart';
import 'package:flutter_restaurant/utils/consts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class MarkRespositories {
  static Future<Set<Marker>> getMarkers(
      Position userLocation, List<String> customMarkers) async {
    Set<Marker> vrMarkers = {};

    vrMarkers.add(MarkRespositories.getProwayMarker());
    vrMarkers.add(MarkRespositories.getFurbArquiteturaMarker());
    vrMarkers.add(MarkRespositories.getUserMarker(
        LatLng(userLocation.latitude, userLocation.longitude)));

    GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: GOOGLE_MAPS_API_KEY);

    for (String markerType in customMarkers)
      vrMarkers.addAll(await MarkRespositories.getNearbyItens(
          markerType,
          places,
          Location(lat: userLocation.latitude, lng: userLocation.longitude)));

    return vrMarkers;
  }

  // Componente de marcação exibido no mapa, apontando para a Proway
  static Marker getFurbArquiteturaMarker() {
    return Marker(
        markerId: MarkerId("Furb: Pavilhão de arquitetura"),
        position: LatLng(-26.9046089, -49.0777393),
        infoWindow: InfoWindow(
          title: "FURB: Pavilhão de arquitetura",
          snippet:
              "Localização do pavilhão de arquitetura da FURB, onde temos aulas as vezes",
          onTap: () {
            print("Pressionou aqui");
          },
        ));
  }

  // Componente de marcação exibido no mapa, apontando para a Proway
  static Marker getProwayMarker() {
    return Marker(
        markerId: MarkerId("Proway"),
        position: LatLng(-26.9171942, -49.0708482),
        infoWindow: InfoWindow(
          title: "Proway Informática",
          snippet: "Localização da Proway Informática",
          onTap: () {
            print("Pressionou aqui");
          },
        ));
  }

  static Marker getUserMarker(LatLng latLng) {
    return Marker(
        markerId: MarkerId("Você"),
        position: latLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(
          title: "Você está aqui",
        ));
  }

  static Future<Set<Marker>> getNearbyItens(
      String type, GoogleMapsPlaces places, Location userLocation) async {
    PlacesSearchResponse vrResponse =
        await places.searchNearbyWithRadius(userLocation, 10000, type: type);

    Set<Marker> vrMarkers = vrResponse.results
        .map((result) => Marker(
            markerId: MarkerId(result.name),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure),
            infoWindow: InfoWindow(
                title: result.name,
                snippet: "Nota: " + (result.rating?.toString() ?? "Sem nota")),
            position: LatLng(
                result.geometry!.location.lat, result.geometry!.location.lng)))
        .toSet();

    return vrMarkers;
  }
}
