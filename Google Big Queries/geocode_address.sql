CREATE OR REPLACE FUNCTION `my-project-scenario2-vlba2.branches.geocode_address`(
  city STRING, postal_code STRING
)
RETURNS STRUCT<latitude FLOAT64, longitude FLOAT64>
LANGUAGE js AS """
  const apiKey = 'AIzaSyAE0xEqG2K4-UgIPGR9J1OvuRTeu0IpfBo';
  const address = encodeURIComponent(city + ' ' + postal_code);
  const url = 'https://maps.googleapis.com/maps/api/geocode/json?address=' + address + '&key=' + apiKey;
  const response = UrlFetchApp.fetch(url);
  const data = JSON.parse(response.getContentText());

  if (data.status !== 'OK') {
    throw new Error('Geocoding API error: ' + data.status);
  }

  const location = data.results[0].geometry.location;
  return {
    latitude: location.lat,
    longitude: location.lng
  };
""";
