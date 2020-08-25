#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
update: 2020-08-25 21:33:27
change: last_page = 64,  fix bug-->  tr td tag decode， add score and problem link columns
Created on Tue Jan  3 10:29:52 2017
@author: liuweizhi
"""

import re
import urllib.request
from bs4 import BeautifulSoup
import os
import csv
import time


def spider(url):
    resp = urllib.request.urlopen(url)
    soup = BeautifulSoup(resp, features='html.parser')
    ctx = soup.find_all("table", "problems")[0].find_all("tr")
    for row in ctx:
        item = row.find_all('td')
        try:
            # get the problem id
            id = item[0].find('a').string.strip()
            l = len(id)
            p2 = id[l-1:l]
            # 处理目前赛制题目命名的问题
            if p2.isalpha():
                p1 = id[0:l - 1]
                p2 = id[l - 1:l]
            else:
                p1 = id[0:l - 2]
                p2 = id[l - 2:l]
            link = f'https://codeforces.com/problemset/problem/{p1}/{p2}'
            col2 = item[1].find_all('a')
            title = col2[0].string.strip()
            tags = [foo.string.strip() for foo in col2[1:]]
            score = item[3].find('span').string.strip()
            solved = re.findall('x(\d+)', str(item[4].find('a')))[0]
            codeforces[id] = {'title': title, 'tags': tags, 'score': score, 'solved': solved, 'accepted': 0,
                              "link": link}
            print(codeforces[id])
        except:
            pass


codeforces = {}
wait = 5 # wait time to avoid the blocking of spider
last_page = 64 # the total page number of problem set page
url = ['https://codeforces.com/problemset/page/%d' % page for page in range(1,last_page+1)]
for foo in url:
    print('Processing URL %s' % foo)
    spider(foo)
    print('Wait %f seconds' % wait)
    time.sleep(wait)

#%% mark the accepted problems
def accepted(url):
    response = urllib.request.urlopen(url)
    soup = BeautifulSoup(response.read())
    pattern = {'name':'table', 'class':'status-frame-datatable'}
    table = soup.findAll(**pattern)[0]
    pattern = {'name': 'tr'}
    content = table.findAll(**pattern)
    for row in content:
        try:
            item = row.findAll('td')
            # check whether this problem is solved
            if 'Accepted' in str(row):
                id = item[3].find('a').string.split('-')[0].strip()
                codeforces[id]['accepted'] = 1
        except:
            continue
    return soup

wait = 15 # wait time to avoid the blocking of spider
last_page = 10 # the total page number of user submission
handle = 'Greenwicher' # ⭐⭐输入你的cf用户名 please input your handle
url = ['https://codeforces.com/submissions/%s/page/%d' % (handle, page) for page in range(1, last_page+1)]
for foo in url:
    print('Processing URL %s' % foo)
    accepted(foo)
    print('Wait %f seconds' % wait)
    time.sleep(wait)

#%% output the problem set to csv files
root = os.getcwd()
with open(os.path.join(root, "CodeForces-ProblemSet.csv"), "w", encoding="utf-8") as f_out:
    f_csv = csv.writer(f_out)
    f_csv.writerow(['ID', 'Title', 'Tags', 'Score', 'Solved', 'Accepted', 'Link'])
    for id in codeforces:
        title = codeforces[id]['title']
        tags = ', '.join(codeforces[id]['tags'])
        score = codeforces[id]['score']
        solved = codeforces[id]['solved']
        accepted = codeforces[id]['accepted']
        link = codeforces[id]['link']
        f_csv.writerow([id, title, tags, score, solved, accepted, link])
    f_out.close()

#%% analyze the problem set
# initialize the difficult and tag list
difficult_level = {}
tags_level = {}
for id in codeforces:
    # '(?i)[A-Z][0-9]',
    difficult = re.findall('(?i)[A-Z]', id)[0]
    tags = codeforces[id]['tags']
    difficult_level[difficult] = difficult_level.get(difficult, 0) + 1
    for tag in tags:
        tags_level[tag] = tags_level.get(tag, 0) + 1
import operator
tag_level = sorted(tags_level.items(), key=operator.itemgetter(1))[::-1]
tag_list = [foo[0] for foo in tag_level]
difficult_level = sorted(difficult_level.items(), key=operator.itemgetter(0))
difficult_list = [foo[0] for foo in difficult_level]

# initialize the 2D relationships matrix
# matrix_solved: the number of AC submission for each tag in each difficult level
# matrix_freq: the number of tag frequency for each difficult level
matrix_solved, matrix_freq = [[[0] * len(difficult_list) for _ in range(len(tag_list))] for _ in range(2)]

# a-f  tag freq
# a-f tag  submission
# a-f score tag  1
# construct the 2D relationships matrix
for id in codeforces:
    # '(?i)[A-Z][0-9]',
    difficult = re.findall('(?i)[A-Z]', id)[0]
    difficult_id = difficult_list.index(difficult)
    tags = codeforces[id]['tags']
    solved = codeforces[id]['solved']
    for tag in tags:
        tag_id = tag_list.index(tag)
        matrix_solved[tag_id][difficult_id] += int(solved)
        matrix_freq[tag_id][difficult_id] += 1

#%% visualization
root = os.getcwd()

def outputMatrix(name, data):
    with open(os.path.join(root,name),"w", encoding="utf-8") as f_out:
        f_csv = csv.writer(f_out)
        f_csv.writerow(['Tags/Difficult '] + difficult_list)
        for i in range(len(tag_list)):
            tag = tag_list[i]
            f_csv.writerow([tag]+data[i])
        f_out.close()
    return

outputMatrix('Matrix-Solved.csv', matrix_solved)
outputMatrix('Matrix-Freq.csv', matrix_freq)
