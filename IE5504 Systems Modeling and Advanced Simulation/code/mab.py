# -*- coding: utf-8 -*-
"""
Created on Tue Oct  7 15:43:41 2014

@author: liuweizhi
"""
import os
import random 
random.seed(5504)
import math
import matplotlib.pyplot as plt
from matplotlib import rc
rc('font',**{'family':'sans-serif','sans-serif':['Helvetica']})
rc('text', usetex=True)
import numpy as np
from scipy.stats import norm
import time

class BernoulliArm():
    def __init__(self, p):
        # generate the probability of success for the arm
        self.p = p
        return
    def draw(self):
        if random.random() > self.p:
            return 0.0
        else:
            return 1.0
            
class UCB():
    def __init__(self, cp):
        # generate the weight of exploration for the UCB value
        self.cp = cp
        self.counts = []
        self.values = []
        self.ucb_values = []
        return
    def initialize(self, n_arms, arms, init_sim):
        self.counts = [0 for i in range(n_arms)]
        self.values = [0.0 for i in range(n_arms)]
        self.ucb_values = [0.0 for i in range(n_arms)]
        return
    def select_arm(self):
        n_arms = len(self.counts)
        # obtain the initial information for each arm
        for arm in range(n_arms):
            if self.counts[arm] == 0:
                return arm
        # use UCB value to select arm after the initial information obtaining procedure
        self.ucb_values = [0.0 for arm in range(n_arms)]
        total_counts = sum(self.counts)
        for arm in range(n_arms):
            exploration = math.sqrt((2*math.log(total_counts)) / (float(self.counts[arm])))
            self.ucb_values[arm] = round(self.values[arm] + self.cp * exploration, 5)
        return ind_max(self.ucb_values)
        
    def update(self, choose_arm, reward):
        self.counts[choose_arm] = self.counts[choose_arm] + 1
        n = self.counts[choose_arm]
        value = self.values[choose_arm]
        new_value = (value * (n-1) + reward) / (float(n))
        self.values[choose_arm] = new_value
        return        

class BayesBandit():
    def __init__(self):
        self.counts = []
        # store the success times for each arm
        self.success = []
        self.bayes = []
        return
        
    def initialize(self, n_arms, arms, init_sim):
        self.counts = [0 for i in range(n_arms)]
        self.success = [0 for i in range(n_arms)]
        self.bayes = [0 for i in range(n_arms)]
        return 
    
    def select_arm(self):
        for i in range(len(self.bayes)):
            self.bayes[i] = np.random.beta(1+self.success[i], 1+self.counts[i]-self.success[i])
        return ind_max(self.bayes)
    
    def update(self, choose_arm, reward):
        self.counts[choose_arm] += 1
        self.success[choose_arm] += reward
        return 

class OCBA():
    def __init__(self):
        self.success = [] # record reward history for each arm
        self.mu = [] # record average reward for each arm
        self.std = [] # record standard deviation for each arm
        self.sn_ratio = [] # record the signal to noise ratio for each arm
        self.ratio = [] # record the allocation ratio for each arm
        self.last_count = [] # record the cumulative counts for each arm in last time
        self.new_count = [] # record the expected counts for each arm in present state based on OCBA allocation rule
        self.n_arms = -9999
        self.init_sim = -9999
        self.arms = [] # store the arms
        self.small_num = 1e-100
        return
    
    def initialize(self, n_arms, arms, init_sim):
        self.n_arms = n_arms
        # store the reward history for each arm to compute mean and variance
        self.success = [[] for i in range(n_arms)]
        self.mu = [0 for i in range(n_arms)]
        self.std = [0 for i in range(n_arms)]
        # store the signal-to-noise ratio
        self.sn_ratio = [0 for i in range(n_arms)]
        # store the budget allocation ratio
        self.ratio = [0 for i in range(n_arms)]
        # store the trial number for each arm in up to last time
        self.last_count = [0 for i in range(n_arms)]
        # store the optimal trial number for each arm up to now
        self.new_count = [0 for i in range(n_arms)]
        # store the initial simulation time for each arm
        self.init_sim = init_sim
        self.arms = [arm for arm in arms]
        
        # run initial simulation for each arm with init_sim times to obtain preliminary statistics
        for arm in range(n_arms):
            for foo in range(self.init_sim):
                self.success[arm].append(self.arms[arm].draw())
                self.last_count[arm] += 1
        # compute the preliminary statistic for each arm
        for arm in range(n_arms):
            num_trial = float(len(self.success[arm]))
            self.mu[arm] = np.mean(np.array(self.success[arm]))
            self.std[arm] = math.sqrt(num_trial / (num_trial - 1)) * np.std(np.array(self.success[arm]))
        # find the current best arm
        best_arm = ind_max(self.mu)
        # compute the signal to noise ratio based on OCBA allocation rule
        best_arm_factor = 0 # compute the factor in the signal to noise ratio for best arm (that sqrt{} part)
        for arm in range(n_arms):
            # the signal to noise ratio is no sense for best arm
            if arm == best_arm:
                continue
            else:
                # compute the signal noise ratio for non-best arm
                self.sn_ratio[arm] = (self.std[arm] / (self.mu[best_arm] - self.mu[arm] + self.small_num)) ** 2
                best_arm_factor += (self.sn_ratio[arm] / (self.std[arm] + self.small_num)) ** 2
        # compute the "signal to noise ratio" for the best arm
        self.sn_ratio[best_arm] = self.std[best_arm] * math.sqrt(best_arm_factor)
        # compute the allocation ratio and new count for each arm
        sum_sn_ratio = np.sum(np.array(self.sn_ratio))
        sum_last_count = np.sum(np.array(self.last_count))
        for arm in range(n_arms):
            self.ratio[arm] = self.sn_ratio[arm] / sum_sn_ratio
            self.new_count[arm] = self.ratio[arm] * (sum_last_count + 1) # delta = 1, in order to avoid numerical issue
        return
            
    def select_arm(self):        
        return ind_max(list(np.array(self.new_count) - np.array(self.last_count)))
        #return ind_max(self.mu)
        
    def update(self, choose_arm, reward):
        # update basic infor for choose_arm
        self.success[choose_arm].append(reward)
        self.last_count[choose_arm] += 1
        
        # update basic statistics
        for arm in range(n_arms):
            num_trial = float(len(self.success[arm]))
            self.mu[arm] = np.mean(np.array(self.success[arm]))
            self.std[arm] = math.sqrt(num_trial / (num_trial - 1)) * np.std(np.array(self.success[arm])) + self.small_num
        # find the current best arm
        best_arm = ind_max(self.mu)
        # compute the signal to noise ratio based on OCBA allocation rule
        best_arm_factor = 0 # compute the factor in the signal to noise ratio for best arm (that sqrt{} part)
        for arm in range(n_arms):
            # the signal to noise ratio is no sense for best arm
            if arm == best_arm:
                continue
            else:
                # compute the signal noise ratio for non-best arm
                self.sn_ratio[arm] = (self.std[arm] / (self.mu[best_arm] - self.mu[arm] + self.small_num)) ** 2
                best_arm_factor += (self.sn_ratio[arm] / (self.std[arm])) ** 2
        # compute the "signal to noise ratio" for the best arm
        self.sn_ratio[best_arm] = self.std[best_arm] * math.sqrt(best_arm_factor)
        # compute the allocation ratio and new count for each arm
        sum_sn_ratio = np.sum(np.array(self.sn_ratio))
        sum_last_count = np.sum(np.array(self.last_count))
        for arm in range(n_arms):
            self.ratio[arm] = self.sn_ratio[arm] / sum_sn_ratio
            self.new_count[arm] = self.ratio[arm] * (sum_last_count + 1) # delta = 1, in order to avoid numerical issue
        return
        
# return the identifier of the largest value in the list            
def ind_max(foo):
    return foo.index(max(foo))
   
# calculate the APCS-B for the current situation
def pcs_calc(trials, reward_history):
    n_arms = len(trials)
    pcs_value = 0
    # compute the estimated success rate for each arm
    arm_mu = [0 for i in range(n_arms)]
    arm_var = [0 for i in range(n_arms)]
    for arm in range(n_arms):
        # to calculate mean and variance, the arm should be played at least once
        if reward_history[arm]:
            arm_mu[arm] = np.mean(np.array(reward_history[arm]))
            arm_var[arm] = np.var(np.array(reward_history[arm]))
    # compute the APCS-B
    best_arm = ind_max(arm_mu)
    #print 'best_arm = %d' % (best_arm)
    for arm in range(n_arms):
        if (arm != best_arm): 
            if (trials[arm]>=2) and (trials[best_arm]>=2):          
                pcs_value += norm.cdf((arm_mu[arm] - arm_mu[best_arm]) / math.sqrt((arm_var[best_arm] / trials[best_arm]) + (arm_var[arm] / trials[arm]) + 1e-100))
#                print 'Best (%f, %f) , Other (%f, %f), pcs_part = %f' % (arm_mu[best_arm], arm_var[best_arm], arm_mu[arm], arm_var[arm],
#                                                      norm.cdf((arm_mu[arm] - arm_mu[best_arm]) / math.sqrt(arm_var[best_arm] / trials[best_arm] + arm_var[arm] / trials[arm])))                
            else:
                return 0
    if pcs_value == 0.5:
        print 'PCS = %f' % (1 - pcs_value)
        print 'Reawrd - History', reward_history
        print 'len reward history = ', len(reward_history) 
        print 'arm_mu = ', arm_mu
        print 'arm_var/trials = ', np.array(arm_var) / np.array(trials)
    return 1 - pcs_value

# run simulation and test the performance of algorithims
def test_algorithm(algo, algo_name, arms, n_reps, n_budgets, init_sim):
    # run independent simulation for n_reps time
    rewards = [[0 for i in range(n_budgets)] for j in range(n_reps)]
    cpu_time = [0 for i in range(n_reps)]
    cumulative_rewards = [[0 for i in range(n_budgets)] for j in range(n_reps)]
    pcs = [[0 for i in range(n_budgets)] for j in range(n_reps)]
    
    for rep in range(n_reps):
        # initialize the algorithm and conduct initial simulation
        n_arms = len(arms)
        algo.initialize(n_arms, arms, init_sim)
        start = n_arms * init_sim
        trials = [0 for i in range(n_arms)]
        reward_history = [[] for i in range(n_arms)]
        time_start = time.time()
        if algo_name == 'OCBA':
            trials = [n_arms * init_sim for i in range(n_arms)]
            reward_history = [[algo.success[arm][step] for step in range(init_sim)] for arm in range(n_arms)]
            rewards[rep][0:start] = [foo for arm in range(n_arms) for foo in reward_history[arm]]
            for i in range(len(rewards[rep])):
                if i==0:
                    cumulative_rewards[rep][i] = rewards[rep][i]
                else:
                    cumulative_rewards[rep][i] = cumulative_rewards[rep][i-1] + rewards[rep][i]
        # conduct normal simulation
        for sim in range(start, n_budgets):
            # run algorithm            
            choose_arm = algo.select_arm()
            reward = arms[choose_arm].draw()
            algo.update(choose_arm, reward)
            
            # update statistics
            rewards[rep][sim] = reward                
            try:
                cumulative_rewards[rep][sim] = cumulative_rewards[rep][sim-1] + reward
            except:
                cumulative_rewards[rep][sim] = reward
            trials[choose_arm] += 1
            reward_history[choose_arm].append(reward)
            pcs[rep][sim] = pcs_calc(trials, reward_history)
            if pcs[rep][sim] == 0.5:
                print choose_arm
            #print '%s - (%d, %d) : pcs = %f, cumulative reward = %d, choose arm = %d' % (algo_name, rep, sim, pcs[rep][sim], cumulative_rewards[rep][sim], choose_arm)
        time_end = time.time()
        cpu_time[rep] = time_end - time_start
            
    return [rewards, cpu_time, cumulative_rewards, pcs]

def plot(n_arms, n_budgets, n_reps, rewards, cpu_time, cumulative_rewards, pcs):
    img_dir = os.getcwd() + '/imgs'
    algo_list = [k for k in rewards]
    
    # boxplot for rewards 
    ensemble_rewards = {}
    for algo in algo_list:
        ensemble_rewards[algo] = np.array([0 for i in range(n_budgets)])
        for rep in range(n_reps):
            ensemble_rewards[algo] += np.array(rewards[algo][rep])
        ensemble_rewards[algo] = list(ensemble_rewards[algo] / float(n_reps))
    ylabel = 'Reward'
    title = 'Reward Comparision \n (Replication = %d, Budget = %d, Arms = %d)' % (n_reps, n_budgets, n_arms)
    save_dir = os.path.join(img_dir, 'boxplot_rewards.pdf')
    boxplot(ensemble_rewards, algo_list, ylabel, title, save_dir)

    # boxplot for cpu_time
    ylabel = 'CPU Time (seconds)'
    title = 'CPU Time Comparision \n (Replication = %d, Budget = %d, Arms = %d)' % (n_reps, n_budgets, n_arms)
    save_dir = os.path.join(img_dir, 'boxplot_cpu_time.pdf')
    boxplot(cpu_time, algo_list, ylabel, title, save_dir)
    
    # time-series plot for pcs
    ensemble_pcs = {}
    for algo in algo_list:
        ensemble_pcs[algo] = [0 for i in range(n_budgets)]
        for rep in range(n_reps):
            ensemble_pcs[algo] += np.array(pcs[algo][rep])
        ensemble_pcs[algo] = list(ensemble_pcs[algo] / float(n_reps))
        plt.plot([i for i in range(n_budgets)], ensemble_pcs[algo], label=algo)
    plt.xlabel('Budgets')
    plt.ylabel('APCS-B')
    plt.title('APCS-B vs Budgets \n (Replication = %d, Arms = %d)' % (n_reps, n_arms))
    box = plt.gca().get_position()
    plt.gca().set_position([box.x0, box.y0 + box.height * 0.2, box.width, box.height * 0.8])
    plt.legend(loc='upper center', bbox_to_anchor=(0.5, -0.2), fancybox=True, shadow=True, ncol=len(algo_list))
    plt.grid()
    plt.savefig(os.path.join(img_dir, 'series_pcs.pdf'))
    plt.close()
    
    # time-series plot for cumulative rewards
    ensemble_cum_rewards = {}
    for algo in algo_list:
        ensemble_cum_rewards[algo] = [0 for i in range(n_budgets)]
        for rep in range(n_reps):
            ensemble_cum_rewards[algo] += np.array(cumulative_rewards[algo][rep])
        ensemble_cum_rewards[algo] = list(ensemble_cum_rewards[algo] / float(n_reps))
        plt.plot([i for i in range(n_budgets)], ensemble_cum_rewards[algo], label=algo)
    plt.xlabel('Budgets')
    plt.ylabel('Cumulative Rewards')
    plt.title('Cumulative Rewards vs Budgets \n (Replication = %d, Arms = %d)' % (n_reps, n_arms))
    box = plt.gca().get_position()
    plt.gca().set_position([box.x0, box.y0 + box.height * 0.2, box.width, box.height * 0.8])
    plt.legend(loc='upper center', bbox_to_anchor=(0.5, -0.2), fancybox=True, shadow=True, ncol=len(algo_list))
    plt.grid()
    plt.savefig(os.path.join(img_dir, 'series_cumulative_rewards.pdf'))
    plt.close()
    
    return 
        
def boxplot(d, algo_list, ylabel, title, save_dir):
    data = []
    for foo in algo_list:
        data.append(d[foo])
    plt.boxplot(data)
    plt.xticks([i+1 for i in range(len(algo_list))], tuple(algo_list), rotation=15)
    plt.ylabel(ylabel)
    plt.title(title)
    plt.savefig(save_dir)
    plt.close()
    
    return
    
def plot2(algo_name, algo_list, n_arms, n_budgets, n_reps, rewards, cpu_time, cumulative_rewards, pcs):
    img_dir = os.getcwd() + '/imgs'

    # time-series plot for pcs
    ensemble_pcs = {}
    for algo in algo_list:
        ensemble_pcs[algo] = [0 for i in range(n_budgets)]
        for rep in range(n_reps):
            ensemble_pcs[algo] += np.array(pcs[algo][rep])
        ensemble_pcs[algo] = list(ensemble_pcs[algo] / float(n_reps))
        plt.plot([i for i in range(n_budgets)], ensemble_pcs[algo], label=algo)
    plt.xlabel('Budgets')
    plt.ylabel('APCS-B')
    plt.title('APCS-B vs Budgets - %s \n (Replication = %d, Arms = %d)' % (algo_name, n_reps, n_arms))
    box = plt.gca().get_position()
    plt.gca().set_position([box.x0, box.y0 + box.height * 0.2, box.width, box.height * 0.8])
    plt.legend(loc='upper center', bbox_to_anchor=(0.5, -0.2), fancybox=True, shadow=True, ncol=len(algo_list))
    plt.grid()
    plt.savefig(os.path.join(img_dir, '%s_rate_series_pcs.pdf' % (algo_name)))
    plt.close()
    
    # time-series plot for cumulative rewards
    ensemble_cum_rewards = {}
    for algo in algo_list:
        ensemble_cum_rewards[algo] = [0 for i in range(n_budgets)]
        for rep in range(n_reps):
            ensemble_cum_rewards[algo] += np.array(cumulative_rewards[algo][rep])
        ensemble_cum_rewards[algo] = list(ensemble_cum_rewards[algo] / float(n_reps))
        plt.plot([i for i in range(n_budgets)], ensemble_cum_rewards[algo], label=algo)
    plt.xlabel('Budgets')
    plt.ylabel('Cumulative Rewards')
    plt.title('Cumulative Rewards vs Budgets - %s \n (Replication = %d, Arms = %d)' % (algo_name, n_reps, n_arms))
    box = plt.gca().get_position()
    plt.gca().set_position([box.x0, box.y0 + box.height * 0.2, box.width, box.height * 0.8])
    plt.legend(loc='upper center', bbox_to_anchor=(0.5, -0.2), fancybox=True, shadow=True, ncol=len(algo_list))
    plt.grid()
    plt.savefig(os.path.join(img_dir, '%s_rate_series_cumulative_rewards.pdf' % (algo_name)))
    plt.close()
    
    return 

def plot3(algo_list, n_arms, n_budgets, n_reps, rewards, cpu_time, cumulative_rewards, pcs):
    img_dir = os.getcwd() + '/imgs'
    algo_name = 'OCBA'
    # time-series plot for pcs
    ensemble_pcs = {}
    for algo in algo_list:
        ensemble_pcs[algo] = [0 for i in range(n_budgets)]
        for rep in range(n_reps):
            ensemble_pcs[algo] += np.array(pcs[algo][rep])
        ensemble_pcs[algo] = list(ensemble_pcs[algo] / float(n_reps))
        plt.plot([i for i in range(n_budgets)], ensemble_pcs[algo], label=algo)
    plt.xlabel('Budgets')
    plt.ylabel('APCS-B')
    plt.title('APCS-B vs Budgets - %s \n (Replication = %d, Arms = %d)' % (algo_name, n_reps, n_arms))
    box = plt.gca().get_position()
    plt.gca().set_position([box.x0, box.y0 + box.height * 0.2, box.width, box.height * 0.8])
    plt.legend(loc='upper center', bbox_to_anchor=(0.5, -0.2), fancybox=True, shadow=True, ncol=len(algo_list))
    plt.grid()
    plt.savefig(os.path.join(img_dir, '%s_initsim_series_pcs.pdf' % (algo_name)))
    plt.close()
    
    # time-series plot for cumulative rewards
    ensemble_cum_rewards = {}
    for algo in algo_list:
        ensemble_cum_rewards[algo] = [0 for i in range(n_budgets)]
        for rep in range(n_reps):
            ensemble_cum_rewards[algo] += np.array(cumulative_rewards[algo][rep])
        ensemble_cum_rewards[algo] = list(ensemble_cum_rewards[algo] / float(n_reps))
        plt.plot([i for i in range(n_budgets)], ensemble_cum_rewards[algo], label=algo)
    plt.xlabel('Budgets')
    plt.ylabel('Cumulative Rewards')
    plt.title('Cumulative Rewards vs Budgets - %s \n (Replication = %d, Arms = %d)' % (algo_name, n_reps, n_arms))
    box = plt.gca().get_position()
    plt.gca().set_position([box.x0, box.y0 + box.height * 0.2, box.width, box.height * 0.8])
    plt.legend(loc='upper center', bbox_to_anchor=(0.5, -0.2), fancybox=True, shadow=True, ncol=len(algo_list))
    plt.grid()
    plt.savefig(os.path.join(img_dir, '%s_initsim_series_cumulative_rewards.pdf' % (algo_name)))
    plt.close()
    
    return 
    
# generate K arms
n_arms = int(raw_input("How many arms do you want to create?\n"))
n_budgets = int(raw_input("How many budgets do you want to allocate for single simualtion?\n"))
n_reps = int(raw_input("How many replications do you want to conduct?\n"))

##########################
success_rates = [round(random.random(), 3) for i in range(n_arms)]
arms = [BernoulliArm(success_rates[i]) for i in range(n_arms)]

algo_list = {'UCB(0.3)':UCB(0.3), 'BayesBandit':BayesBandit(), 'OCBA':OCBA()}
#algo_list = {'OCBA':OCBA()}
algo = {}
rewards = {}
cpu_time = {}
cumulative_rewards = {}
pcs = {}
for foo in algo_list:
    # algorithm initialization
    algo[foo] = algo_list[foo]
    algo_name = foo
    if foo == 'OCBA':
        init_sim = int((raw_input('How many initial budgets do you want to allocate for each arm in OCBA algorithms with total budget = %d, and %d arms?\n' % (n_budgets, n_arms))))
    else:
        init_sim = 0
    # run algorithm
    [rewards[foo], cpu_time[foo], cumulative_rewards[foo], pcs[foo]] = test_algorithm(algo[foo], algo_name, arms, n_reps, n_budgets, init_sim)  
plot(n_arms, n_budgets, n_reps, rewards, cpu_time, cumulative_rewards, pcs)

#########################
n_budgets = int(raw_input("Success Rates Variation - How many budgets do you want to allocate for single simualtion?\n"))
base_success_rates = 0.5
increment = 0.1
variation = list(np.array([0.00, 0.25, 0.50, 0.75, 1.00]) * increment + base_success_rates)
algo = {}
for foo in algo_list:
    rewards = {}
    cpu_time = {}
    cumulative_rewards = {}
    pcs = {}
    for var in variation:
        algo[foo] = algo_list[foo]
        algo_name = foo
        success_rates = [base_success_rates for i in range(n_arms)]
        success_rates[0] = var
        arms = [BernoulliArm(success_rates[i]) for i in range(n_arms)]
        [rewards[var], cpu_time[var], cumulative_rewards[var], pcs[var]] = test_algorithm(algo[foo], algo_name, arms, n_reps, n_budgets, init_sim)  
    plot2(foo, variation, n_arms, n_budgets, n_reps, rewards, cpu_time, cumulative_rewards, pcs)

#########################
init_sim = [5, 10, 15, 20, 30]
n_budgets = int(raw_input("OCBA Init-Sim - How many budgets do you want to allocate for single simualtion?\n"))
success_rates = [round(random.random(), 3) for i in range(n_arms)]
arms = [BernoulliArm(success_rates[i]) for i in range(n_arms)]
rewards = {}
cpu_time = {}
cumulative_rewards = {}
pcs = {}
for initsim in init_sim:
    algo_name = 'OCBA'
    [rewards[initsim], cpu_time[initsim], cumulative_rewards[initsim], pcs[initsim]] = test_algorithm(algo_list['OCBA'], algo_name, arms, n_reps, n_budgets, initsim)  
plot3(init_sim, n_arms, n_budgets, n_reps, rewards, cpu_time, cumulative_rewards, pcs)
