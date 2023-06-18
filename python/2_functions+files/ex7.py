# -*- coding: utf-8 -*-
"""
Created on Sat Jun 17 14:34:26 2023

@author: Norah Lu
"""


def appointed_by(file, target_president):

    file = open(file, 'r')

    year = []  # initialize

    for line in file:
        element = line.split(',')
        # fst_name = element[0].lower()
        # lst_name = element[1].lower()
        president = element[2].lower()
        # birth_state = element[3]
        app_year = int(element[4])
        # death_year = int(element[5])

        if target_president.lower() in president:  # support partial searches
            year.append(app_year)

    return (min(year), max(year))
