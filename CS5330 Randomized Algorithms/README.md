# Info

> This directory contains all the source codes, documentation for the project I have done in CS5330 Randomized Algorithms.

Particularly, I implemented the general framework of Monte Carlos tree search algorithm based on the paper [Monte Carlo Search Algorithm Discovery for One Player Games](https://arxiv.org/abs/1208.4692). The framework can generate various MCTS algorithms (e.g. the Reflexive Monte Carlo search, the Nested Monte Carlo, and the Upper Confidence Bound 1 applied to trees, etc.)  by the functional programming. 

In this project, we intend to solve a combinatorial optimization problem which decides how to color the network. In particularly, below are the backgrounds.
- Game Rule
  1. Input: undirected network adjacency list and original color sequence
  2. Initial: choose a node whatever you like and color it
  3. Process: pick a node from those uncolored nodes which connect to colored nodes and color it 
  4. Terminate: the original color sequence runs out or no further candidate nodes to color
  5. Reward: number of edges which connect to two different color nodes
  6. Output: population sequence and network reward
- Goal: search the optimal network population sequence to maximize the total reward of the network
  
A short introduction of Monte Carlo tree search algorithm, and the general framework and how to solve the network coloring problems are provided. 

