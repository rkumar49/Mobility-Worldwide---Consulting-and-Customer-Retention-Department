import pandas as pd
import googlemaps
import requests

gmaps_client = googlemaps.Client(key='2f424c5ac9d2de3dbf565c9f3db57957b8dd28c5eec')

df = pd.read_csv('inputformaps.csv')
garbsen_coordinates = (42.392908618435023, 7.55142128527852)
base_url = "https://maps.googleapis.com/maps/api/staticmap?"
params = {
    "size": "800x600",
    "key": 'AIzaSyBymKny0pV9H3AN253jw6ksnotK7QfKQ1g'
}
garbsen_marker = f"color:red|size:mid|label:C|{garbsen_coordinates[0]},{garbsen_coordinates[1]}"

city_markers = [garbsen_marker]
for idx, row in df.iterrows():
    # Extract latitude and longitude from the formatted string
    coordinates = row['FormattedDestinationCoordinates'].replace("{", "").replace("}", "").split(", ")
    lat, lng = float(coordinates[0]), float(coordinates[1])
    city_marker = f"size:mid|color:blue|{lat},{lng}"
    city_markers.append(city_marker)

markers_param = '&'.join([f"markers={marker}" for marker in city_markers])
map_url = f"{base_url}{markers_param}&key={params['key']}&size={params['size']}"

print("Generated Map URL:", map_url)

response = requests.get(map_url)
if response.status_code == 200:
    with open('mapNew.png', 'wb') as f:
        f.write(response.content)
    print("Map image saved as mapNew.png")
else:
    print("Failed to retrieve the map image")
