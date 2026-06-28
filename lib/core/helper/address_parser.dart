import 'package:flowers_app/core/location_data/egypt_location_loader.dart';

class ParsedAddress {
  final String? cityName;
  final String? areaName;
  final String street;

  const ParsedAddress({this.cityName, this.areaName, required this.street});
}

ParsedAddress? parseAddressString(String address) {
  final parts = address
      .split(',')
      .map((p) => p.trim())
      .where((p) => p.isNotEmpty)
      .toList();

  if (parts.length < 2) return null;

  final country = parts.last;
  if (country != 'Egypt' && !country.contains('مصر')) return null;

  String? cityName;
  String? areaName;

  if (parts.length >= 3) {
    cityName = parts[parts.length - 2];
    areaName = parts[parts.length - 3];
  } else if (parts.length == 2) {
    cityName = parts[0];
  }

  final streetParts = parts.sublist(0, parts.length - 1);
  if (areaName != null) streetParts.remove(areaName);
  if (cityName != null) streetParts.remove(cityName);
  streetParts.remove(country);
  final street = streetParts.join(', ');

  return ParsedAddress(cityName: cityName, areaName: areaName, street: street);
}

class MatchedAddress {
  final GovernorateItem? city;
  final AreaItem? area;
  final String street;

  const MatchedAddress({this.city, this.area, required this.street});
}

/// Finds the governorate whose English or Arabic name matches [name].
/// Lives in the data/helper layer so UI never loads or matches location data.
Future<GovernorateItem?> matchGovernorateByName(String name) async {
  if (name.trim().isEmpty) return null;
  final governorates = await EgyptLocationLoader.loadGovernorates();
  for (final g in governorates) {
    if (g.nameEn.toLowerCase() == name.toLowerCase() || g.nameAr == name) {
      return g;
    }
  }
  return null;
}

Future<MatchedAddress?> matchAddressFromParsed(ParsedAddress parsed) async {
  GovernorateItem? matchedCity;
  AreaItem? matchedArea;

  if (parsed.cityName != null && parsed.cityName!.isNotEmpty) {
    final cities = await EgyptLocationLoader.loadGovernorates();
    final citiesMatches = cities
        .where(
          (c) =>
              c.nameEn.toLowerCase().contains(parsed.cityName!.toLowerCase()) ||
              parsed.cityName!.toLowerCase().contains(c.nameEn.toLowerCase()),
        )
        .toList();
    if (citiesMatches.isNotEmpty) matchedCity = citiesMatches.first;
  }

  if (parsed.areaName != null &&
      parsed.areaName!.isNotEmpty &&
      matchedCity != null) {
    final areas = await EgyptLocationLoader.loadAreas();
    final cityAreas = areas
        .where((a) => a.governorateId == matchedCity?.id)
        .toList();
    final areasMatches = cityAreas
        .where(
          (a) =>
              a.nameEn.toLowerCase().contains(parsed.areaName!.toLowerCase()) ||
              parsed.areaName!.toLowerCase().contains(a.nameEn.toLowerCase()),
        )
        .toList();
    if (areasMatches.isNotEmpty) matchedArea = areasMatches.first;
  }

  return MatchedAddress(
    city: matchedCity,
    area: matchedArea,
    street: parsed.street,
  );
}
