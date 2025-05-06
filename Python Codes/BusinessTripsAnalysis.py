import googlemaps
from datetime import datetime
import pandas as pd
import logging

gmaps_client = googlemaps.Client(key='AIzaSyBymKny0pV9H3AN253jw6ksnotK7QfKQ1g')

logging.basicConfig(level=logging.INFO)

def geocode_location(location):
    try:
        geocode_result = gmaps_client.geocode(location)
        if geocode_result:
            return geocode_result[0]['formatted_address']
        else:
            logging.warning(f"Location not found: {location}")
            return None
    except googlemaps.exceptions.ApiError as e:
        logging.error(f"Geocoding error for {location}: {e}")
        return None

def calculate_travel_time_and_distance(source, destination):
    try:
        now = datetime.now()
        direction_result = gmaps_client.directions(
            source, destination, mode="driving", departure_time=now
        )
        if direction_result:
            leg = direction_result[0]['legs'][0]
            distance_km = leg['distance']['value'] / 1000
            duration_mins = leg['duration']['value'] / 60


            destination_lat = leg["end_location"]["lat"]
            destination_lng = leg["end_location"]["lng"]
            destination_coordinates = (destination_lat, destination_lng)

            return duration_mins, distance_km, destination_coordinates
        else:
            logging.warning(f"No route found from {source} to {destination}")
            return None, None
    except googlemaps.exceptions.ApiError as e:
        logging.error(f"Error with Google Maps API: {e}")
        return None, None

business_trips = pd.read_csv('BusinessTripsSummaryNew.csv')


business_trips['OriginCity'] = business_trips['OriginCity'] + ', Germany'
business_trips['DestinationCity'] = business_trips['DestinationCity'] + ', Germany'

business_trips['OriginCity'] = business_trips['OriginCity'].apply(geocode_location)
business_trips['DestinationCity'] = business_trips['DestinationCity'].apply(geocode_location)

business_trips = business_trips.dropna(subset=['OriginCity', 'DestinationCity'])

business_trips[['TravelTimeMinutes', 'DistanceKm', 'DestinationCoordinates']] = business_trips.apply(
    lambda row: pd.Series(calculate_travel_time_and_distance(row['OriginCity'], row['DestinationCity'])), axis=1)

business_trips['TravelTimeMinutes'] = business_trips['TravelTimeMinutes'].fillna(-1)
business_trips['DistanceKm'] = business_trips['DistanceKm'].fillna(-1)

business_trips.to_csv('UpdatedBusinessTripsSummaryNew.csv', index=False)

print("Travel times and distances updated successfully")
