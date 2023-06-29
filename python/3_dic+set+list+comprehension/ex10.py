# -*- coding: utf-8 -*-
"""
Created on Wed Jun 28 11:28:40 2023

@author: Norah Lu
"""

import numpy as np


# calculate matrix multiplication
def matrix_multiply(X, Y):
    result = [[sum(a*b for a,b in zip(X_row,Y_col)) for Y_col in zip(*Y)] for X_row in X]
    return result


# convert list into a list of lists
def extractDigits(lst):
    return [[el] for el in lst]


def payouts(pa, pb, n, bet):

    # initialize
    each_round = [[(1-pa)*(1-pb), pa*(1-pb)+(1-pa)*pb, pa*pb]]
    round_score = [[(1-pa)*(1-pb)],
                   [pa*(1-pb)+(1-pa)*pb],
                   [pa*pb]]
    score = round_score

    # calculate probability for all scores
    for round in range(2, n+1):

        sigma = matrix_multiply(round_score, each_round)
        rows = len(sigma)
        columns = len(sigma[0])
        round_score = np.zeros(2*round+1)

        for i in range(rows):
            for j in range(columns):
                s = i+j
                round_score[s] = round_score[s] + sigma[i][j]

        round_score = extractDigits(round_score.tolist())
        score.append(round_score)

    score[0] = [score[0], score[1], score[2]]  # merge the first score
    del score[1:3]  # Removing merged elements

    # calculate the total probability for last digit
    total = {}
    for round in range(n):
        round_score = score[round]
        for i, v in enumerate(round_score):
            last_digit = i % 10
            total[last_digit] = total.get(last_digit, 0) + v[0]

    # calculate payoff
    payoff = {}
    for key, value in total.items():
        payoff[key] = value*bet

    return payoff
