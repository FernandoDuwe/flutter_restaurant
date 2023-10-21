# flutter_restaurant

Integração Flutter + GoogleMaps

## Iniciando

A integração com GoogleMaps funciona a partir de uma configuração. Para gerar essa configuração (API_KEY), acesse o site:

https://console.cloud.google.com/google/maps-apis/

Após gerar a API_KEY, altere-a nos seguintes arquivos:

**/lib/utils/consts.dart**

**/android/app/src/main/AndroidManifest.xml**

Procure pelo texto *SUA_API_KEY*