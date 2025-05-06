import pandas as pd

df = pd.read_csv('FinalBusinessTripsSummaryNotCleaned.csv')

df['LatitudeOrigin'] = '{' + df['OriginCoordinates'].str.extract(r'\((.*?),')[0] + '}'
df['LongitudeOrigin'] = '{' + df['OriginCoordinates'].str.extract(r', (.*?)\)')[0] + '}'

df['LatitudeDestination'] = '{' + df['DestinationCoordinates'].str.extract(r'\((.*?),')[0] + '}'
df['LongitudeDestination'] = '{' + df['DestinationCoordinates'].str.extract(r', (.*?)\)')[0] + '}'

df['FormattedOriginCoordinates'] = df.apply(lambda row: f"{row['LatitudeOrigin']}, {row['LongitudeOrigin']}", axis=1)
df['FormattedDestinationCoordinates'] = df.apply(lambda row: f"{row['LatitudeDestination']}, {row['LongitudeDestination']}", axis=1)


df.drop(['LatitudeOrigin', 'LongitudeOrigin'], axis=1, inplace=True)

df = df[['TripId', 'EmployeeId', 'OriginBranchId', 'OriginCity', 'FormattedOriginCoordinates',
         'DestinationCity', 'DestinationPostalCode', 'HotelCosts', 'TravelCosts',
         'TravelTimeMinutes', 'DistanceKm', 'FormattedDestinationCoordinates']]

df.to_csv('FinalBusinessTripsSummaryWithNewCoordinates.csv', index=False)

print(f"Coordination are reformated")