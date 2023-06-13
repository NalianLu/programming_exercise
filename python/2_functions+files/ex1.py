# -*- coding: utf-8 -*-
"""
Created on Mon Jun 12 16:07:48 2023

@author: Norah Lu
"""

# nums = [47, 36, 71, 63, 12, 80, 90, 42, 25, 92, 45, 42, 5, 74, 77, 25, 0, 30, 91, 71]


def largest_even(nums):
    result = -1
    for n in nums:
        if n % 2 == 0 and n > result:
            result = n
    return result


def num_two_digits(nums):
    result = 0
    for n in nums:
        if n >= 10 and n <= 99:
            result += 1
    return result


def num_odd(nums):
    result = 0
    for n in nums:
        if n % 2 == 1:
            result += 1
    return result
