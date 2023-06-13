# -*- coding: utf-8 -*-
"""
Created on Mon Jun 12 16:20:03 2023

@author: Norah Lu
"""


def double_or_1(target_amount):
    current_amount = 1  # start with $1
    step = 0  # initialize the step
    while target_amount > current_amount:
        if target_amount % 2 == 0:
            target_amount /= 2
            step += 1
        else:
            target_amount -= 1
            step += 1

    return step
