# -*- coding: utf-8 -*-
"""
Created on Wed Jun 28 10:09:02 2023

@author: Norah Lu
"""

# database explaination:
# https://openweathermap.org/current

import json
from statistics import mean

file = open('minneapolis.json')
data = json.load(file)['list']
# get cloud cover data
cloud = [data[i]['clouds']['all'] for i in range(len(data))]
# get temp data
temp_kelvin = [data[i]['main']['temp'] for i in range(len(data))]
temp_celsius = [t-273.15 for t in temp_kelvin]
temp_fahrenheit = [(t * 9/5) + 32 for t in temp_celsius]


def avg_temp(cloud_cover):

    try:
        indices = [i for i, x in enumerate(cloud) if x == cloud_cover]
        avg_celsius = mean([temp_celsius[i] for i in indices])
        avg_fahrenheit = mean([temp_fahrenheit[i] for i in indices])
        result = (avg_celsius, avg_fahrenheit)
    except:
        result = None

    return result
