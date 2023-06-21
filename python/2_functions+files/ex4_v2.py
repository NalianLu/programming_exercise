# -*- coding: utf-8 -*-
"""
Created on Tue Jun 20 11:27:31 2023

@author: Norah Lu
"""


def is_sorted(filename):
    with open(filename, 'r') as f:

        flag = True

        # This is the first line
        previous_line = next(f)

        for line in f:

            if previous_line <= line:
                previous_line = line

            else:
                flag = False

        # All the lines are in sorted order
        return flag
