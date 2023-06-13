# -*- coding: utf-8 -*-
"""
Created on Mon Jun 12 16:41:07 2023

@author: Norah Lu
"""


def is_sorted(filename):
    with open(filename, 'r') as f:

        # This is the first line
        previous_line = next(f)

        for line in f:

            if previous_line <= line:
                previous_line = line

            else:
                return False

        # All the lines are in sorted order
        return True
