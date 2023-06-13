# -*- coding: utf-8 -*-
"""
Created on Tue Jun  6 10:49:44 2023

@author: Norah Lu
"""

qwert = ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p']

# input
word = input('Enter a word: ')

# initialize
character = list(set(word))
is_qwert = True

# check
for c in character:
    if c not in qwert:
        is_qwert = False
        break

# print
if is_qwert:
    print('{} is a qwerty word.'.format(word))
else:
    print('{} is not a qwerty word.'.format(word))
