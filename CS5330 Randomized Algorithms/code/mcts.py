# -*- coding: utf-8 -*-
"""
Created on Wed Oct  8 12:45:20 2014

@author: liuweizhi
"""
import os,sys,glob
import random
import matplotlib.pyplot as plt
import networkx as nx
import numpy as np
import math
import copy
import shelve
import easygui

class GameTree():
    def __init__(self):
        self.graph = []
        self.sequence = []
        return 
    def initialization(self, graphdir, seqdir):
        ''' return the constructed graph and sequence '''
        ## build the network
        f_graph = open(graphdir, 'r')
        content = f_graph.read().replace('\n', ' ').strip(' ').split(' ')
        content = [int(foo) for foo in content]
        scale =  max(content) - min(content) + 1
        f_graph.close()
        ### initialize the adjacent network with scale * scale (graph[i,j] means the number of edges between node i and node j)
        graph = np.matrix([[ 0 for j in range(scale)] for i in range(scale)])
        f_graph = open(graphdir, 'r')        
        for line in f_graph:
            tmp = line.strip('\n').split(' ')
            try:
                [v1, v2] = [int(tmp[i]) - min(content) for i in range(len(tmp))]
                if (v1 != v2):
                    graph[v1,v2] = graph[v1,v2] + 1
                    graph[v2,v1] = graph[v2,v1] + 1
                else:
                    graph[v1,v2] = graph[v1,v2] + 1
            except:
                print "the sequence file isn't complete"
                sys.exit(0)
        self.graph = graph                 
        f_graph.close()
        ## record the sequence
        sequence = []
        f_seq = open(seqdir, 'r')
        content = f_seq.read().strip('\n')
        for color in content:
            color = int(color)
            if color == 0:
                sequence.append(-1)
            elif color == 1:
                sequence.append(1)
            else:
                print "the color sequence contains number other than 0 or 1!!!!"
                sys.exit(0)
        self.sequence = sequence
        f_seq.close()
        return [self.graph, self.sequence]
  
class MCTS():
    def __init__(self):
        self.name = 'Noname'
        self.best_population = []
        self.best_reward = -9999
        self.graph = []
        self.sequence = []
        self.setdir = ''
        return
        
    def initialization(self, graph, sequence, setdir):
        self.best_population = []
        self.best_reward = -9999
        self.graph = graph
        self.sequence = sequence
        # self.setdir is for the self.output() method
        self.setdir = setdir
        return 
    
    def step(self, population, candi, func_list):
        ''' given unifinished population, return the best population and best reward which are constructed step by step '''
        # generate the population step by step
        id = len(population) + 1
        while not(self.terminal(population, candi)):
            population = self.invoke(population, candi, func_list)
            # update the next candidate space
            candi = self.candidate(population[0:id-1], [population[id-1]], candi)
            # only obtain the id th element from the population derived from self.invoke, step by step
            population = population[0:id]
            id = id + 1
        # update the best_population and best_reward
        self.evaluate(population)
        return population
        
    def repeat(self, population, candi, func_list, N):
        ''' repeat n simulations using given search component and return the best population sequence '''
        best_population = []
        best_reward = -9999
        for i in range(N):
            tmp_population = self.invoke(population, candi, func_list)
            tmp_reward = self.reward(tmp_population)
            if tmp_reward > best_reward:
                best_population = tmp_population
                best_reward = tmp_reward
        return best_population
    
    def lookahead(self, population, candi, func_list):
        ''' return the all possible population for the next step '''
        best_population = []
        best_reward = -9999
        for new_node in candi:
            # generate the new_population by append the new node to original population
            new_candi = self.candidate(population, [new_node], candi)
            new_population = [foo for foo in population]            
            # just lookahead 
            new_population.append(new_node)
            # further generate a new population sequence given new_population
            tmp_population = self.invoke(new_population, new_candi, func_list)
            tmp_reward = self.reward(tmp_population)
            # update the best_population and best_reward
            if tmp_reward > best_reward:
                best_population = tmp_population
                best_reward = tmp_reward
        return best_population
        
    def select(self, population, candi, N, thr, func_list):
        ''' given population, then select the next population state using UCB with explorer parameter thr and budget N * len(candi)'''        
        best_population = []
        best_reward = -9999
        # initialize the reawrd and number of trials of the total len(candir) arms
        arms = [{'reward':0, 'trial':0} for i in range(len(candi))]
        ucb = [0 for i in range(len(arms))]
        total_trials = 0
        untried = [foo for foo in candi]
        # the total budget is N
        candi_budget = len(candi)
        population_budget = int((1 - (self.graph.shape[0] * float(N)) / len(candi)) * (len(population) / float(len(self.sequence))) +  (self.graph.shape[0] * float(N)) / len(candi))
        for i in range(candi_budget * population_budget):
            # exists some untried arms
            if untried:
                new_node = untried[int(random.uniform(0,len(untried)))]
                untried.remove(new_node)
            # all arms were tried, then using the ucb value to select next state
            else:
                new_node = candi[ucb.index(max(ucb))]
            # generate the next population
            sub_candi = self.candidate(population, [new_node], candi)
            sub_population = [foo for foo in population]
            sub_population.append(new_node)
            tmp_population = self.invoke(sub_population, sub_candi, func_list)
            tmp_reward = self.reward(tmp_population)
            # update best_population and best_reward
            if tmp_reward > best_reward:
                best_population = tmp_population
                best_reward = tmp_reward
            # update the attributes of arms and calculate the ucb value
            arm_id = candi.index(new_node)
            arms[arm_id]['reward'] += tmp_reward
            arms[arm_id]['trial'] += 1.0
            total_trials += 1.0
            #reward_ucb = arms[arm_id]['reward'] / (algo.best_reward * arms[arm_id]['trial'])
            #trial_ucb = 1.0 / (1.0 + math.exp(- math.sqrt(2 * math.log(total_trials) / arms[arm_id]['trial'])))
            reward_ucb = arms[arm_id]['reward'] / arms[arm_id]['trial']
            trial_ucb = math.sqrt(2 * math.log(total_trials) / arms[arm_id]['trial'])
            ucb[arm_id] = reward_ucb + thr * trial_ucb
            #print 'max ucb -- %f -- %f' % (max(ucb), candi_budget * population_budget)
        return best_population
        
    def simulate(self, population, candi):
        ''' return a randomly population sequence given current unfinished population sequence '''      
        graph = self.graph 
#        # states_seq is empty which means the initial state of simulation
#        if [] == population:
#            new_node = candi[int(random.uniform(0,len(candi)))]
#            population.append(new_node)
        # generate the uniformly randomly simulation population sequence
        while(not(self.terminal(population, candi))):
            new_node = candi[int(random.uniform(0, len(candi)))]
            candi = self.candidate(population, [new_node], candi)
            population.append(new_node)
        self.evaluate(population)       
        return population

    def candidate(self, population, new_node, candi):
        ''' return the next candidate space given the population '''
        # return the ajcacent vector of new_node
        if (population==[]) and (new_node==[]) and (candi==[]):
            candi = list(np.where(self.graph.sum(axis=0).A1>0)[0])
        elif (population==[]) and (new_node) and (candi):
            new_node_neighbor = []
            for foo in new_node:
                new_node_neighbor.extend(np.where(self.graph[foo,].A1>0)[0].tolist())
            candi = list(set(new_node_neighbor) - set(new_node))
        else:
            new_node_neighbor = []
            for foo in new_node:
                new_node_neighbor.extend(np.where(self.graph[foo,].A1>0)[0].tolist())
            try:
                candi = list((set(candi) | set(new_node_neighbor)) - set(new_node) - set(population))
            except:
                print 'candi',candi
                print 'new_node_neighbor',new_node_neighbor
                print 'new_node',new_node
                print 'population',population
                sys.exit(0)
        return candi
        
    def evaluate(self, population):
        ''' return the best_population, best_reward of the upper search component
        and the population evaluated, and check if the budget is run out '''
        global numCalls
        global budget
        # calculate the reward given finished population sequence
        reward = self.reward(population)
        # update the best_reward and best_population
        if reward > self.best_reward:
            self.best_reward = reward
            self.best_population = [population]  
        elif reward == self.best_reward:
            self.best_population.append(population)
        # update the budget usage
        numCalls = numCalls + 1
        print '%s - (%d/%s) - best reward: %d/%d' % (self.name, numCalls, str(budget), self.best_reward, reward)
        if numCalls == budget:
            print 'the budget has been run out'
            # output the current best population and reward
            # self.output(self.best_population[0], self.best_reward)
            sys.exit(0) # need modify
        return reward
    
    def invoke(self, population, candi, func_list):
        if not(self.terminal(population, candi)):
            func = func_list[0]
            population = func['func'](population, candi, **func['argv'])
        else:
            self.evaluate(population)
        return population
    
    def reward(self, population):
        ''' return the reward of the graph given population sequence'''
        graph = self.graph
        sequence = self.sequence
        # for color_seq, if the value == 0, then it means the corresponding node isn't painted
        color_seq = np.matrix([0 for v in range(self.graph.shape[0])])
        for v in population:
            color_seq[0, v] = sequence[population.index(v)]
        return int(np.square(color_seq) * graph * np.square(color_seq).T - color_seq * graph * color_seq.T) / 4
        
    def terminal(self, population, candi):
        ''' return whether entering the terminal state '''
        if (population):
            if (candi and (len(population)<len(self.sequence))):
                flag = False
            else:
                flag = True
        # the initial state of population
        else:
            flag = False
        return flag
        
        
    def draw(self, population):
        ''' return the colored graph given population sequence '''
        graph = self.graph
        sequence = self.sequence
        G = nx.from_numpy_matrix(graph)
        pos = nx.circular_layout(G)
        node_color = []
        labels = {}
        for v in G:
            if v in population:
                if sequence[population.index(v)] == -1:
                    node_color.append('r')
                elif sequence[population.index(v)] == 1:
                    node_color.append('b')
            else:
                node_color.append('w')
            labels[v] = v 
        nx.draw_networkx(G, pos, node_color=node_color, labels=labels)
        plt.show()        
        return 
        
    # like epsilon-greedy mab problem within budget maxtry
    def brute(self, maxtry, epsilon):
        ''' return a population sequence base on epsilon greedy algorithms '''
        graph = self.graph
        sequence = self.sequence
        # record the best populate file and reward
        best_sequence = []
        second_sequence = []
        best_reward = -9999
        second_reward = -9999
        # brute force random simulation
        id = 1
        while id<=maxtry:
            if random.random() < epsilon:
                candi = self.candidate([],[],[])
                population = self.simulate([],candi)
            else:
                try:
                    best_sequence_sample = best_sequence[int(random.uniform(0, len(best_sequence)))]
                    best_sequence_sample = best_sequence_sample[0:int(random.uniform(0, len(best_sequence_sample)))] 
                except:
                    best_sequence_sample = []
                population = best_sequence_sample
            #print population
            reward = self.evaluate(population)
            if reward > best_reward:
                # previous best_reward turns into second_reward
                second_reward = best_reward
                second_sequence = best_sequence            
                best_reward = reward
                best_sequence = []
                best_sequence.append(population)
            elif reward == best_reward:
                if not(population in best_sequence):
                    best_sequence.append(population)
            elif reward > second_reward:
                second_reward = reward
                second_sequence = []
                second_sequence.append(population)
            elif reward == second_reward:
                if not(population in second_sequence):
                    second_sequence.append(population)
            id = id + 1
        self.output(best_sequence[0], best_reward)
        return {'best_seq':best_sequence, 'best_reward':best_reward, 'second_seq':second_sequence, 'second_reward':second_reward}

    def output(self, population, reward):
        ''' write the reward and population sequence into txt files '''
        # write reward into file    
        checker = ['Lim Wei Quan', 'Lim Wei Zhong', 'Zhang Chen']
        f_reward = open(os.path.join(self.setdir, 'reward.txt'), 'w')
        f_reward.write('reward=%d\n' % reward)
        for foo in checker:
            f_reward.write('%s\n' % foo)
        f_reward.close()
        # write population sequence and corresponding color sequence into file
        sequence = self.sequence
        f_population = open(os.path.join(self.setdir, 'population.txt'), 'w')
        for i in range(len(population)):
            f_population.write('%d %d\n' % (population[i], (self.sequence[i]+1)/2))
        f_population.close()
        return 
    
    
def recursive(func_list):
    ''' return the self-loop recursive func_list given func_list '''
    for i in range(len(func_list)-1):
        func_list[i]['argv']['func_list'] = func_list[i+1:len(func_list)]
    return func_list  
 
def combinator(func_list):
    ''' run the recurisive func '''
    func_list = recursive(func_list)
    func = func_list[0]
    result = func['func'](**func['argv'])
    return result
    
def restore_shelve(filename):
    ''' restore the workspace '''
    f_shelf = shelve.open(filename)
    for key in f_shelf:
        globals()[key] = f_shelf[key]
    f_shelf.close()
    return 
### parameters initialization
#random.seed(5330)
### read file    
homedir = os.getcwd()
datadir = os.path.join(homedir, 'data/submission')
datalist = os.listdir(datadir)
for foo in datalist[1:2]:
    # initialize the game tree
    if 'set' in foo:
        setdir = os.path.join(datadir, foo)
    else:
        continue
    graphdir = glob.glob('%s/graph*.txt' % setdir)[0]
    seqdir = glob.glob('%s/seq*.txt' % setdir)[0]
    tree = GameTree()
    [graph, sequence] = tree.initialization(graphdir, seqdir)

    # create MCTS() class algo to let the algo_list legal
    algo = MCTS()
    algo.initialization(graph, sequence, setdir)
    population = []
    candi = algo.candidate([], [], [])
    # specify the algorithms we want to use like UCT, Nested Monte Carlo Tree
    algo_list = {
       'rmc': [{'func':algo.step, 'argv':{'population':population, 'candi':candi}}, {'func':algo.repeat, 'argv':{'N':10000}}, {'func':algo.step, 'argv':{}}, {'func':algo.repeat, 'argv':{'N':10}}, {'func':algo.simulate, 'argv':{}}],
       'nmc1': [{'func':algo.step, 'argv':{'population':population, 'candi':candi}}, {'func':algo.lookahead, 'argv':{}}, {'func':algo.simulate, 'argv':{}}],
       'r-nmc1': [{'func':algo.repeat, 'argv':{'population':population, 'candi':candi, 'N':100}}, {'func':algo.step, 'argv':{}}, {'func':algo.lookahead, 'argv':{}}, {'func':algo.simulate, 'argv':{}}],                
       'nmc2': [{'func':algo.step, 'argv':{'population':population, 'candi':candi}}, {'func':algo.lookahead, 'argv':{}}, {'func':algo.step, 'argv':{}}, {'func':algo.lookahead, 'argv':{}}, {'func':algo.simulate, 'argv':{}}],
        # uct algorithms computation time : len(seq) * N_repeat * (N_graph * len(graph) + 1) * len(seq) / 2
       'uct0.5': [{'func':algo.step, 'argv':{'population':population, 'candi':candi}}, {'func':algo.repeat, 'argv':{'N':1}}, {'func':algo.select, 'argv':{'N': 1, 'thr':0.5}}, {'func':algo.simulate, 'argv':{}}],
       'uct1.0': [{'func':algo.step, 'argv':{'population':population, 'candi':candi}}, {'func':algo.repeat, 'argv':{'N':1}}, {'func':algo.select, 'argv':{'N': 3, 'thr':1.0}}, {'func':algo.simulate, 'argv':{}}],                 
       'meta-uct0.5': [{'func':algo.step, 'argv':{'population':population, 'candi':candi}}, {'func':algo.select, 'argv':{'N': 2, 'thr':0.5}}, {'func':algo.step, 'argv':{}}, {'func':algo.select, 'argv':{'N': 3, 'thr':0.5}}, {'func':algo.simulate, 'argv':{}}],                 
       'r1': [{'func':algo.select, 'argv':{'population':population, 'candi':candi, 'N':100, 'thr':0.5}}, {'func':algo.step, 'argv':{}}, {'func':algo.repeat, 'argv':{'N':100}}, {'func':algo.select, 'argv':{'N':1000, 'thr':0.5}}, {'func':algo.simulate, 'argv':{}}],
    }
    
    # the candidate algorithms to be compared
    algo_candi = ['meta-uct0.5']
    best_population = []
    best_reward = -9999
    algo_result = []
    for foo in algo_candi:
        # define the basic parameter
        global budget
        budget = float('inf')
        global numCalls
        numCalls = 0        
        # initial the algo (clear the previous algorithm's best_population and best_reward in algo)
        algo.initialization(graph, sequence, setdir)
        algo.name = foo
        # run the algorithms based on the foo
        combinator(algo_list[foo])
        reward = algo.reward(algo.best_population[0])
        # update the best population and best reward
        if reward > best_reward:
            best_population = [foo for foo in algo.best_population[0]]
            best_reward = reward
        # record the result of algo based on foo
        algo_result.append(copy.deepcopy(algo))
    # output the global best population, best reward given the comparision of all algorithms in algo_candi
    algo.output(best_population, best_reward)
    # save the current workspace 
    f_shelf = shelve.open(os.path.join(setdir, 'workspace.out'), 'n')
    for key in dir():
        try:
            f_shelf[key] = globals()[key]
        except:
            print 'ERROR shelving: {0}'.format(key)
    f_shelf.close()
    
    # notify the programmer that the simulation is done
    print '\a'*7
    #easygui.msgbox("Simulation is Done", title="Message")

    
    