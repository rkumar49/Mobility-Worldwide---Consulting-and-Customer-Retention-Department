import pandas as pd
import re

file_path = 'UpdatedBusinessTripsSummaryNew.csv'
df = pd.read_csv(file_path)

df['OriginCoordinates'] = list(zip(df['OriginCityCoordinatesLatitude'], df['OriginCityCoordinatesLongitude']))

df.drop(columns=['OriginCityCoordinatesLatitude', 'OriginCityCoordinatesLongitude'], inplace=True)

columns = list(df.columns)
origin_city_index = columns.index('OriginCity')
columns.insert(origin_city_index + 1, columns.pop(columns.index('OriginCoordinates')))
df = df[columns]

output_file_path = 'FinalBusinessTripsSummaryNotCleaned.csv'
df.to_csv(output_file_path, index=False)

print(f"Updated file saved to {output_file_path}")
