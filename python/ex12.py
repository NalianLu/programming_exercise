#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Jun 10 16:21:57 2023

@author: Norah Lu
"""

cloud_cover = int(input('Enter percentage cloud cover: '))
if cloud_cover <= 30:
    print('Clear')
elif cloud_cover <= 70:
    print('Partly cloudy')
elif cloud_cover <= 99:
    print('Mostly cloudy')
elif cloud_cover == 100:
    print('Overcast')
else:
    print('% cloud cover out of range')
