import googlemaps
from datetime import datetime
import pandas as pd
import logging
import re

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

def calculate_travel_time_and_distance(destination):
    try:
        now = datetime.now()
        direction_result = gmaps_client.directions(
            (52.392908618435023, 9.55142128527852), destination, mode="driving", departure_time=now
        )
        if direction_result:
            leg = direction_result[0]['legs'][0]
            distance_km = leg['distance']['value'] / 1000
            duration_mins = leg['duration']['value'] / 60

            return duration_mins, distance_km
        else:
            logging.warning(f"No route found from {source} to {destination}")
            return None, None
    except googlemaps.exceptions.ApiError as e:
        logging.error(f"Error with Google Maps API: {e}")
        return None

business_trips = pd.read_csv('formatted_file.csv')


business_trips['DestinationCoordinates'] = business_trips['DestinationCoordinates']

business_trips[['TravelTimeMinutes', 'DistanceKm']] = business_trips.apply(
    lambda row: pd.Series(calculate_travel_time_and_distance(row['DestinationCoordinates'])), axis=1
)



#business_trips.drop(['TripId', 'EmployeeId','FormattedOriginCoordinates','HotelCosts','TravelCosts',], axis=1, inplace=True)

business_trips.to_csv('gg2.csv', index=False)

print("Travel times and distances updated successfully")