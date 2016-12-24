import os,sys
import shelve 
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.backends.backend_pdf import PdfPages

def restore_shelve(filename):
    ''' restore the workspace '''
    f_shelf = shelve.open(filename)
    for key in f_shelf:
        try:
            globals()[key] = f_shelf[key]
        except:
            print 'ERROR shelving: {0}'.format(key)
    f_shelf.close()
    return 
    
homedir = os.getcwd()
restore_shelve(os.path.join(homedir, 'plot/workspace.out'))

# generate descriptive statistics for reward and time
print '****** statistics for reward ******'
for foo in reward:
    print '%s - (%f, %f)' % (foo, round(np.mean(reward[foo]),2), round(np.std(reward[foo]) ,2))

print '****** statistics for time ******'    
for foo in time:
    print '%s - (%f, %f)' % (foo, round(np.mean(time[foo]),2), round(np.std(time[foo]) ,2))
    
# plot reward sequence trends    
scale = {}
for foo in comp:
    scale[foo] = float('inf')
    for i in range(len(comp[foo])):
        if np.sum(comp[foo][i]>0) < scale[foo]:
            scale[foo] = np.sum(comp[foo][i]>0)
avg_comp = {}
for foo in comp:
    avg_comp[foo] = 0
    for i in range(len(comp[foo])):
        avg_comp[foo] = avg_comp[foo] + comp[foo][i]
    avg_comp[foo] = avg_comp[foo] / float(len(comp[foo]))

for foo in avg_comp:
    plt.plot(np.arange(scale[foo]), avg_comp[foo][0:scale[foo]], 'b')
    plt.suptitle('Reward Sequence Trends - %s' % foo)
    plt.xlabel('steps')
    plt.ylabel('reward')
    plt.grid()
    plt.savefig('trends_%s.pdf' % foo)
    plt.close()
       
# boxplot of best reward comparision
data = []
algo_list = ['rmc', 'nmc1', 'nmc2', 'uct0.5', 'uct1.0']
for foo in algo_list:
    data.append(reward[foo])
plt.boxplot(data)
plt.xticks([1,2,3,4,5], tuple(algo_list), rotation=15)
plt.ylabel('Best Rewards')
plt.title('Comparision of Best Rewards')
plt.savefig('best_reward_compare.pdf')
plt.close()

# boxplot of best reward comparision
data = []
algo_list = ['rmc', 'nmc1', 'nmc2', 'uct0.5', 'uct1.0']
for foo in algo_list:
    data.append(time[foo])
plt.boxplot(data)
plt.xticks([1,2,3,4,5], tuple(algo_list), rotation=15)
plt.ylabel('Computation Time (seconds)')
plt.title('Comparision of Computation Time')
plt.savefig('computation_time_compare.pdf')
plt.close()