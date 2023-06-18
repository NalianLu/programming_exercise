# -*- coding: utf-8 -*-
"""
Created on Sat Jun 17 14:49:42 2023

@author: Norah Lu
"""

import numpy as np  # calculate correlation coefficient


def correl(file, v1, v2):

    # import data
    with open(file, 'r', encoding="utf8") as f:

        # initialize
        # color = []  # string
        # director_name = []  # string
        num_critic_for_reviews = []  # int
        duration = []  # int
        director_facebook_likes = []  # int
        # actor_2_name = []  # string
        actor_1_facebook_likes = []  # int
        gross = []  # int
        # actor_1_name = []  # string
        num_voted_users = []  # int
        cast_total_facebook_likes = []  # int
        facenumber_in_poster = []  # int
        # plot_keywords = []  # string
        num_user_for_reviews = []  # int
        # language = []  # string
        # country = []  # string
        # content_rating = []  # string
        budget = []  # int
        title_year = []  # int
        actor_2_facebook_likes = []  # int
        imdb_score = []  # float
        aspect_ratio = []  # float
        movie_facebook_likes = []  # int

        # skip the first header line
        next(f)

        for line in f:

            element = line.split(',')
            blank = ''

            if blank not in element:

                num_critic_for_reviews.append(int(element[2]))
                duration.append(int(element[3]))
                director_facebook_likes.append(int(element[4]))
                actor_1_facebook_likes.append(int(element[6]))
                gross.append(int(element[7]))
                num_voted_users.append(int(element[9]))
                cast_total_facebook_likes.append(int(element[10]))
                facenumber_in_poster.append(int(element[11]))
                num_user_for_reviews.append(int(element[13]))
                budget.append(int(element[17]))
                title_year.append(int(element[18]))
                actor_2_facebook_likes.append(int(element[19]))
                imdb_score.append(float(element[20]))
                aspect_ratio.append(float(element[21]))
                movie_facebook_likes.append(int(element[22]))

        # find values for the first variable
        if v1 == 'num_critic_for_reviews':
            array1 = num_critic_for_reviews
        elif v1 == 'duration':
            array1 = duration
        elif v1 == 'director_facebook_likes':
            array1 = director_facebook_likes
        elif v1 == 'actor_1_facebook_likes':
            array1 = actor_1_facebook_likes
        elif v1 == 'gross':
            array1 = gross
        elif v1 == 'num_voted_users':
            array1 = num_voted_users
        elif v1 == 'cast_total_facebook_likes':
            array1 = cast_total_facebook_likes
        elif v1 == 'facenumber_in_poster':
            array1 = facenumber_in_poster
        elif v1 == 'num_user_for_reviews':
            array1 = num_user_for_reviews
        elif v1 == 'budget':
            array1 = budget
        elif v1 == 'title_year':
            array1 = title_year
        elif v1 == 'actor_2_facebook_likes':
            array1 = actor_2_facebook_likes
        elif v1 == 'imdb_score':
            array1 = imdb_score
        elif v1 == 'aspect_ratio':
            array1 = aspect_ratio
        elif v1 == 'movie_facebook_likes':
            array1 = movie_facebook_likes

        # find values for the second variable
        if v2 == 'num_critic_for_reviews':
            array2 = num_critic_for_reviews
        elif v2 == 'duration':
            array2 = duration
        elif v2 == 'director_facebook_likes':
            array2 = director_facebook_likes
        elif v2 == 'actor_1_facebook_likes':
            array2 = actor_1_facebook_likes
        elif v2 == 'gross':
            array2 = gross
        elif v2 == 'num_voted_users':
            array2 = num_voted_users
        elif v2 == 'cast_total_facebook_likes':
            array2 = cast_total_facebook_likes
        elif v2 == 'facenumber_in_poster':
            array2 = facenumber_in_poster
        elif v2 == 'num_user_for_reviews':
            array2 = num_user_for_reviews
        elif v2 == 'budget':
            array2 = budget
        elif v2 == 'title_year':
            array2 = title_year
        elif v2 == 'actor_2_facebook_likes':
            array2 = actor_2_facebook_likes
        elif v2 == 'imdb_score':
            array2 = imdb_score
        elif v2 == 'aspect_ratio':
            array2 = aspect_ratio
        elif v2 == 'movie_facebook_likes':
            array2 = movie_facebook_likes

        # calculate correlation coefficient
        c = np.corrcoef(array1, array2)[0, 1]

        return c
