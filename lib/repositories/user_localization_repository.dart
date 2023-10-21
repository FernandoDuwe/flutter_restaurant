import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserLocalizationRepository {
  static Future<Position> getCurrentPosition() async {
    // Verifica primeiro se a localização está habilitada
    if (!await Geolocator.isLocationServiceEnabled())
      throw "O seu serviço de localização está desabilitado";

    // Verifica agora se o aplicativo possuí permissão de acesso
    LocationPermission locationPermission = await Geolocator.checkPermission();

    // Se as permissões estão negadas, solicita a permissão
    if (locationPermission == LocationPermission.denied) {
      LocationPermission requestedPermission =
          await Geolocator.requestPermission();

      // Verifica se foram dadas permissões de acesso as configurações
      if (requestedPermission == LocationPermission.denied)
        throw "As permissões de acesso a sua localização atual foram negadas";
    }

    // Se as permissões estão permanentemente negadas, gera uma exceção
    if (locationPermission == LocationPermission.deniedForever)
      throw "As permissões de acesso a localização pelo aplicativo estão permanentemente revogadas, não é possível continuar.";

    return await Geolocator.getCurrentPosition();
  }

  static Future<LatLng> getLatLngCurrentPosition() async {
    Position position = await UserLocalizationRepository.getCurrentPosition();

    return LatLng(position.latitude, position.longitude);
  }
}
