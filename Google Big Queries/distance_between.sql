CREATE OR REPLACE FUNCTION `my-project-scenario2-vlba2.branches.distance_between`(
  origin_lat FLOAT64, origin_lng FLOAT64,
  destination_lat FLOAT64, destination_lng FLOAT64
)
RETURNS STRUCT<distance FLOAT64, duration STRING>
LANGUAGE js AS """
  const apiKey = 'AIzaSyBymKny0pV9H3AN253jw6ksnotK7QfKQ1g';
  const url = 'https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=' +
    origin_lat + ',' + origin_lng + '&destinations=' +
    destination_lat + ',' + destination_lng + '&mode=driving&key=' + apiKey;

  const response = UrlFetchApp.fetch(url);
  const data = JSON.parse(response.getContentText());

  if (data.rows[0].elements[0].status !== 'OK') {
    throw new Error('Distance Matrix API error: ' + data.rows[0].elements[0].status);
  }

  const distance = data.rows[0].elements[0].distance.value / 1000; // Convert meters to kilometers
  const duration = data.rows[0].elements[0].duration.text;

  return {
    distance: distance,
    duration: duration
  };
""";

