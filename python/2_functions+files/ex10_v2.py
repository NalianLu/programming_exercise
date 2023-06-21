# -*- coding: utf-8 -*-
"""
Created on Tue Jun 20 11:31:31 2023

@author: Norah Lu
"""

import numpy as np


def correl(file, input1, input2):

    array1 = []
    array2 = []

    with open(file, 'r', encoding="utf8") as f:

        firstline = next(f).strip()
        header = firstline.split(',')
        print(header)
        index1 = header.index(input1)
        index2 = header.index(input2)

        for line in f:

            element = line.split(',')
            blank = ''

            if blank not in element:
                array1.append(float(element[index1]))
                array2.append(float(element[index2]))

            c = np.corrcoef(array1, array2)[0, 1]

        return c
