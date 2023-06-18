# -*- coding: utf-8 -*-
"""
Created on Sat Jun 17 14:16:03 2023

@author: Norah Lu
"""


def state_density(file, target_state):
    with open(file, 'r') as f:

        for line in f:
            element = line.split(',')
            state = element[0]
            if state == target_state:
                area = float(element[2])
                population = float(element[3])
                density = population/area
                return density
