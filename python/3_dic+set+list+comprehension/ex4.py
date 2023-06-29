# -*- coding: utf-8 -*-
"""
Created on Wed Jun 28 09:04:41 2023

@author: Norah Lu
"""

#grades = ['A-' , 'B' , 'C' , 'A' , 'C' , 'A' , 'B' , 'C-' , 'C+' , 'B-' , 'B-' , 'A-' , 'B' , 'B+' , 'C-' , 'C+' , 'C' , 'B-' , 'A' , 'C' ,'C' , 'B-' , 'A' , 'C-' , 'C']


def interpolated_median(grades):
    import statistics

    # initialte grade dic
    grade = {}
    grade['A'] = 4.0
    grade['A-'] = 3.67
    grade['B+'] = 3.33
    grade['B'] = 3.0
    grade['B-'] = 2.67
    grade['C+'] = 2.33
    grade['C'] = 2.0
    grade['C-'] = 1.67
    grade['D+'] = 1.33
    grade['D'] = 1
    grade['F'] = 0

    # initiate
    n1 = 0
    n2 = 0

    # get the score
    score = [grade[g] for g in grades]
    
    # calculation
    M = statistics.median(score)
    N = len(score)

    for s in score:
        if s < M:
            n1 += 1

    for s in score:
        if s == M:
            n2 += 1

    if n2 == 0:
        interpolated_median = M
    else:
        interpolated_median = M-0.167+((0.5*N-n1)/n2)*0.333

    return interpolated_median
