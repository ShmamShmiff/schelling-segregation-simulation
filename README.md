# Simulation of Schelling's Model of Segregation

To run, simply run code in matlab.

## Problem A: Consecutive Row Update Order and Unhappy Agents Move Horizontally
<p align="center">
<img width="571" alt="image" src="https://github.com/ShmamShmiff/schelling-segregation-simulation/assets/25768413/d0766cd6-e20d-444e-8cc8-2b643a478e0a">
</p>

These results are taken when we updates agents in a determined row by row order, and only move unhappy agents horizontally to the nearest empty spot in its row.

We notice several problems with this method. First, we see there are a lot of unhappy agents remaining in the system (unhappy agents are denoted by red ’x’s in right plots). In fact, these systems timed out after the 10 seconds threshold. Under this system, it is highly unlikely, and nearly stochasticly impossible for the system to converge. As such, without a stopping condition, this simulation would have continued forever. (i.e. infinite number of iterations)
Second, we see groups (or clusters) of common agents forming, however many artifacts remain apparent. The clusters are not perfect and often contain unhappy agents of the opposing color.

These artifacts and an inability to converge is due to our limitation of moving strictly in the horizontal direction. If we allowed our unhappy agents to move more freely in other directions, these problems could be resolved. This is exactly the question of the next experiment.

## Problem B: Consecutive Row Update Order and Unhappy Agents Move in Random Direction
<p align="center">
<img width="579" alt="image" src="https://github.com/ShmamShmiff/schelling-segregation-simulation/assets/25768413/c1622b45-b3cb-444a-af9e-0de1a1af1c23">
</p>

Now we keep updating rows consecutively but allow unhappy agents to move in any random direc- tion. Looking at the results above, we see that empty spaces tend to move towards the right of the system. This is likely due to unhappy agents on left of the system being updated first and taking nearby empty spaces before the unhappy agents to the right.

Convergence would typically occur after 50 to 85 iterations.

## Problem C: Random Permutation Update Order and Unhappy Agents Move Horizontally
<p align="center">
<img width="569" alt="image" src="https://github.com/ShmamShmiff/schelling-segregation-simulation/assets/25768413/4dd6d3d7-1f37-4c52-bad6-5882727f07c9">
</p>
Now we update in a random permutation but only allow unhappy agents to move horizontally to the nearest empty spot. We see the results look similar to those in part A where we update agents consecutively and only allow for horizontal moves. As we can see by the number of remaining unhappy agents, the system can still not converge to a stable solution.

Because of this problem, generally the system will never converge and the number of iterations would be infinite.

## Problem D: Random Permutation Update Order and Unhappy Agents Move in Random Direction
<p align="center">
<img width="573" alt="image" src="https://github.com/ShmamShmiff/schelling-segregation-simulation/assets/25768413/6a0ee169-6424-432d-8b88-35d2b68af86c">
</p>

Finally, we update our agents in a random order and allow them to move in any direction. Be doing so we see an nice evolution of our system in which all agents are separated into clusters. From my testing, most often, all agents become happy and no unhappy agents are left stranded. This graph looks highly similar to that of part B, however the empty spaces are distributed more evenly through the system. Out of all the methods tested, this produced the best visually-pleasing results - no visible artifacts were seen.
Convergence would typically occur after 45 to 80 iterations.

## Additional Experimentation
I begin by analyzing what happens when we change our happiness value H from 0 to 8. All results below have been simulated using a random permutation update order and a random direction move for any unhappy agents.

<p align="center">
<img width="834" alt="image" src="https://github.com/ShmamShmiff/schelling-segregation-simulation/assets/25768413/fff42c47-8efb-40ba-bf26-69dafb3d2689">
</p>

When $H = 1$, agents are easily satisfied and converge to an acceptable solution after 3 to 5 iterations. Only agents initialized with a neighborhood containing no common agents attempt to move.

<p align="center">
<img width="834" alt="image" src="https://github.com/ShmamShmiff/schelling-segregation-simulation/assets/25768413/3e4d9fa8-fe0d-4ce3-9b83-a27625a239fc">
</p>

When $H = 2$, agents are once again easily satisfied and converge to an acceptable solution after few iterations. After running a few trials, the system converged after 8 to 16 iterations.

<p align="center">
<img width="834" alt="image" src="https://github.com/ShmamShmiff/schelling-segregation-simulation/assets/25768413/9f243d27-1f7e-4ab3-bbbc-134058877baa">
</p>

Here, when $H = 3$, we begin to see more separation in the form of cliques. A pattern begins to emerge. The system converged around 18 to 22 iterations.

<p align="center">
<img width="834" alt="image" src="https://github.com/ShmamShmiff/schelling-segregation-simulation/assets/25768413/b8d97332-e357-4d94-89ed-ef2dbd3c183c">
</p>

When $H = 4$, we arrive at our original problem. This is identical to my results presented before. Convergence would typically occur after 45 to 80 iterations.

<p align="center">
<img width="834" alt="image" src="https://github.com/ShmamShmiff/schelling-segregation-simulation/assets/25768413/b6610858-eead-41de-9380-38bdc2591965">
</p>

At $H = 5$, we reach our first issue with convergence. No matter how we arrange things, it is impossible for any agent to be happy in any feasible neighborhood. The program, however, does not know this and will attempt to find an acceptable solution regardless. This process is infinite and therefore so is our number of iterations. The images above show the evolution of this system as it continues through time. Note we end up with two ’blobs’ comprising of the two agents (remember the system is periodic).

<p align="center">
<img width="834" alt="image" src="https://github.com/ShmamShmiff/schelling-segregation-simulation/assets/25768413/bfdec43b-9fad-4ef7-94b2-ef2d52ca8d29">
</p>

Once again, at $H = 6$, we see there exists no possible solution to this system. After running for 2688 iterations, I arrived at the state above. Please note the system still finds cliques and can begin to form large ’blobs.’

<p align="center">
<img width="834" alt="image" src="https://github.com/ShmamShmiff/schelling-segregation-simulation/assets/25768413/16a2b11f-3f81-489e-ad77-d9b890d79ec9">
</p>

Finally, at $H = 7,8$ I know there will be an infinite number of iterations as the system cannot find a stable state. I also observed the state could not form any ’blobs’. This is odd because it is possible to construct feasible neighborhoods of a happy agent consisting of 7 to 8 neighbors. I believe, however, that due to the random movement of any unhappy particle, our system is being prevented from forming stable groups through random chance alone. The image illustrating my results was taken after I stopped the program after 454 iterations.

Now I will be comparing the results of running the program for different grid sizes N. Please note, I hold constant the same methods as above with $H = 4$.
  
<p align="center">
<img width="834" alt="image" src="https://github.com/ShmamShmiff/schelling-segregation-simulation/assets/25768413/7a318d3b-0c97-4247-92a7-00a9b162f030">
</p>

For small values of N, I found the program took very little time to converge (around 1 second).

<p align="center">
<img width="834" alt="image" src="https://github.com/ShmamShmiff/schelling-segregation-simulation/assets/25768413/c94672f4-56bf-4f9b-8e55-ce1c65688d4e">
</p>

The program also worked for larger values of N. At N = 300, the program found a stable state in around 11 seconds.

<p align="center">
<img width="834" alt="image" src="https://github.com/ShmamShmiff/schelling-segregation-simulation/assets/25768413/85cea189-75a9-4cbf-91ab-f161ddb409a7">
</p>

As soon as we grow N larger, we begin facing more time constraints. At N = 700, it took almost two minutes to find a stable state. I also tried at N = 1000 but the program became too slow. Interestingly, as we increase N, we do not necessarily see a large increase in number of required iterations. We do not see the same scaling factor between N and number of iterations.


### Now, What Happens If We Only Move Agents to Empty Spots Which Satisfy Happiness Constraints?
As mentioned, what if we prevent agents from moving to the nearest empty stop in a random direction without first checking if they will be happy there. This means we will only move an agent if it will be happy in its new position. To explore this question, I wrote a second script which investigates just this. Once again, I will be using updating agents in a random permutation and moving unhappy agents by first picking a random direction and then searching for a potential stable move in that direction.

<p align="center">
<img width="576" alt="image" src="https://github.com/ShmamShmiff/schelling-segregation-simulation/assets/25768413/8fde81a7-2cb4-46d5-972f-b2bd8e35ca49">
</p>

Interestingly, we see a symmetric pattern emerging. Similarities in the pattern seem to be mirrored across the image’s diagonal axis. This is highly unexpected. I am still uncertain if this is truly a phenomenon at play or a potential bug in my code (if the case is the latter, I spent a lot of time searching but to no avail).



