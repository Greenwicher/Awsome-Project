import os,sys,glob
import random
import numpy as np
import py_compile

class GameTree():
    
    def __init__(self):
        self.graph = []
        self.sequence = []
        self.population = []
        self.color_seq = []
        return 
        
    def initialization(self, graphdir, seqdir, popdir):
        ''' return the constructed graph and sequence '''
        ## build the network
        f_graph = open(graphdir, 'r')
        content = f_graph.read().replace('\n', ' ').strip(' ').split(' ')
        content = [int(foo) for foo in content]
        scale =  max(content) - min(content) + 1
        f_graph.close()
        ### initialize the adjacent network with scale * scale 
        graph = np.matrix([[ 0 for j in range(scale)] for i in range(scale)])
        f_graph = open(graphdir, 'r')        
        for line in f_graph:
            tmp = line.strip('\n').split(' ')
            try:
                [v1, v2] = [int(tmp[i])  for i in range(len(tmp))]
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
        ## record the population
        population = []
        color_seq = []
        f_pop = open(popdir, 'r')
        for lines in f_pop:
            [state, color] = [int(foo) for foo in lines.strip('\n').split(' ')]
            population.append(state)
            color_seq.append(color)
        self.population = population
        self.color_seq = color_seq
        f_pop.close()
        return 
        
    def reward(self, population):
        ''' return the reward of the graph given population sequence'''
        graph = self.graph
        sequence = self.sequence
        # for color_seq, if the value == 0, then it means the corresponding node isn't painted
        color_seq = np.matrix([0 for v in range(self.graph.shape[0])])
        for v in population:
            color_seq[0, v] = sequence[population.index(v)]
        return int(np.square(color_seq) * graph * np.square(color_seq).T - color_seq * graph * color_seq.T) / 4

    def checker(self):
        # calculate reward
        print 'the reward is : %d' % self.reward(self.population)
        sequence = [(foo+1)/2 for foo in self.sequence]
        # population color sequece with original sequence
        if self.color_seq != sequence[0:len(self.color_seq)]:
            homedir = os.getcwd()
            f_seq = open(os.path.join(homedir, 'check_seq.txt'), 'w')
            for i in range(len(self.color_seq)):
                if sequence[i] != self.color_seq[i]:
                    print "the no.%d line is not same" % (i+1)
                f_seq.write('%d %d\n' % (sequence[i], self.color_seq[i]))
            f_seq.close()
            print 'the color sequence in population file is not identical with the original sequence !!!'
            print 'the Program is WRONG....'
        # check if the node can be reached
        for i in range(1,len(self.population)):
            #print 'check node %d...' % (self.population[i])
            flag = False
            for j in range(i):
                #print '(%d, %d)' % (self.population[i], self.population[j])
                if (self.graph[self.population[i],self.population[j]]):
                    flag = True
                    break
            if not(flag):
                print 'cannot reach %d' % (self.population[i])
                sys.exit(0)
        return 
            
homedir = os.getcwd()
if (sys.argv[1] and sys.argv[2] and sys.argv[3]):
    graphdir = os.path.join(homedir, sys.argv[1])
    seqdir = os.path.join(homedir, sys.argv[2])
    popdir = os.path.join(homedir, sys.argv[3])
    tree = GameTree()
    tree.initialization(graphdir, seqdir, popdir)
    tree.checker()
    if not('.pyc' in sys.argv[0]):
        py_compile.compile(os.path.join(homedir, sys.argv[0]))
       
else:
    print 'the input file missing or wrong input command'
