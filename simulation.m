% Author: Julien Schmidt
% Date: March 2022
clear

N = 100; % Grid Size
H = 4; %happiness level
max_time_of_simulation = 10; % Stopping parameter. By default, we only allow for 10 seconds

% Method by which we update agents
%   1:consequently along rows, 2:random sequence of agents
%update_order_method = 1; 
update_order_method = 2;

% Method by which we move unhappy agents
%   1:moving horizontally, 2:moving in random direction
%agent_move_method = 1; 
agent_move_method = 2;

% Two methods of initiating grid. Based on distribution or exact
% distribution

% Method 1:
stream = RandStream('mlfg6331_64','Seed',0);
%random_sample = randsample(s,[1 2 3],N*N,true,[0.1 0.45 0.45]);

% Method 2:
p1 = round((N*N)*.1); p2 = p1 + round((N*N)*.45); p3 = N*N;
random_sample(1:p1) = 1;
random_sample(p1+1:p2) = 2;
random_sample(p2+1:p3) = 3;
random_sample = random_sample(randperm(length(random_sample)));


grid = reshape(random_sample, [N N]);
grid_orig = grid;
clear random_sample

% ### Initial Plotting ###
figure;
ps = get(gcf,'Position');
set(gcf, 'Position',  [ps(1), ps(2), ps(3)*2, ps(3)])

subplot(1,2,1)
hold on
title('Simulation','fontsize',20)

colormap parula
%image(grid,'CDataMapping','scaled')
imagesc(grid)
axis image
set(gca,'XTick',[])
set(gca,'YTick',[])
set(gca,'ydir','reverse')
% ### End of Initial Plotting###

%select type of update order of agents
if update_order_method == 1
    update_order = 0:1:N*N-1; %sequentially from 1,1 to N,N
elseif update_order_method ==2
    update_order = randperm(N*N)-1; %In a random permutation
end

convergence_flag = 1; %if this flag becomes 0, we stop the while loop below
num_iterations = 0; %counter for number of iterations

P = @(x) (1 + mod(x-1, N)); %function that maps periodic coordinate structure of system

disp('#############################')
disp(' ')
disp("Starting simulation..")
disp(' ')

tStart = tic; %start timer

% Loop through all agents and update accordingly
while convergence_flag == 1
    grid_previous = grid;
    convergence_flag = 0;
    to_converge = [];
    
for i=1:N*N
    update_index = update_order(i);
    x = mod(update_index,N)+1;
    y = floor(update_index/N)+1;
    
    %grid(y,x) = 1;
    %imagesc(grid)
    %disp(' Hit space to continue ...');
    %pause;
    
    agent_val = grid(y,x);
    
    neighborhood = [grid(P(y-1),P(x-1)), grid(P(y-1),x), grid(P(y-1),P(x+1));...
        grid(y,P(x-1)), grid(y,x), grid(y,P(x+1));...
        grid(P(y+1),P(x-1)), grid(P(y+1),x), grid(P(y+1),P(x+1));];
    
    %check if agent is happy
    if agent_val ~= 1 && sum(sum(neighborhood == agent_val)) >= H+1 %if number of identical agents is greater or equal H (note: H+1 because we are counting the agent itself)
        %agent is happy and does not move
    elseif agent_val > 1
        convergence_flag = 1;
        to_converge = [to_converge; [y,x]];
        move = [y,x];
        
        if agent_move_method == 1
            to_right = [grid(y,x+1:N), grid(y,P(N+1):P(N+x-1))] == 1;
            to_left = flip(to_right,2);
            
            %if at least an open move exists
            if sum(to_right) > 0
                FR = find(to_right, 1, 'first');
                FL = find(to_left, 1, 'first');
                
                %if first empty spot to the right is closer than first to the left
                if FR <= FL
                    move = [y,P(x+FR)];
                else %if first empty spot to the left is closer than first to the right
                    move = [y,P(x-FL)];
                end
            end
        elseif agent_move_method == 2
            direction = randi([1 4],1);
            if direction == 1
                to_right = [grid(y,x+1:N), grid(y,P(N+1):P(N+x-1))] == 1;
                %if at least an open move exists
                if sum(to_right) > 0
                    FR = find(to_right, 1, 'first'); %find the first empty cell to right
                    move = [y,P(x+FR)];
                end
            elseif direction == 2
                to_left = flip([grid(y,x+1:N), grid(y,P(N+1):P(N+x-1))] == 1,2);
                %if at least an open move exists
                if sum(to_left) > 0
                    FL = find(to_left, 1, 'first'); %find the first empty cell to left
                    move = [y,P(x-FL)];
                end
            elseif direction == 3
                to_down = [grid(y+1:N,x)', grid(P(N+1):P(N+y-1),x)'] == 1;
                %if at least an open move exists
                if sum(to_down) > 0
                    FD = find(to_down, 1, 'first'); %find the first empty cell to down
                    move = [P(y+FD),x];
                end
            elseif direction == 4
                to_up = flip([grid(y+1:N,x)', grid(P(N+1):P(N+y-1),x)'] == 1,2);
                %if at least an open move exists
                if sum(to_up) > 0
                    FU = find(to_up, 1, 'first'); %find the first empty cell to top
                    move = [P(y-FU),x];
                end
            end
            
            
        end
        
        %if we try to move to move to a square that is not empty and that
        %is not the agent's current square
        if grid(move(1),move(2)) ~= 1 && x ~= move(2) && y ~= move(1)
            disp("Error: tying to move to a square that is not empty")
            pause;
        end
        
        grid(y,x) = 1; %set agent's current square to empty
        grid(move(1),move(2)) = agent_val; %move agent to new empty spot
        
    end
    

    
end
imagesc(grid)
axis image
pause(0.01); %pause for milisecond just to update visualization
num_iterations = num_iterations + 1; %increase iteration count

if toc(tStart) >= max_time_of_simulation %check timer. if we have passed our time limit, break
    break
end

end

toc(tStart) %stop timer

% ### Display info and finalize visualization ###

disp("DONE!")
if convergence_flag == 0
    disp("Converged!")
else
    disp("Could not converge ;(")
end

disp(['Number of iterations: ',num2str(num_iterations)])

unhappy_agents = get_unhappy_agents(grid, N, H);
disp(['Number of unhappy agents remaining: ',num2str(length(unhappy_agents))])

imagesc(grid)
axis image

subplot(1,2,2)
imagesc(grid)
axis image
hold on

for i=1:length(unhappy_agents)
    plot(unhappy_agents(i,2),unhappy_agents(i,1),'x','color','red','linewidth',1)
end
set(gca,'XTick',[])
set(gca,'YTick',[])
title('Unhappy Agents','fontsize',20)
set(gca,'ydir','reverse')

disp('#############################')
disp(' ')

clear

%function to find unhappy agents in final state
function unhappy_agents = get_unhappy_agents(grid, N, H)

    P = @(x) (1 + mod(x-1, N)); %function to return priodic index
    unhappy_agents = []; %where we store unhappy agents
    update_order = 1:1:N*N;
    for i=1:N*N
        update_index = update_order(i)-1;
        x = mod(update_index,N)+1;
        y = floor(update_index/N)+1;

        agent_val = grid(y,x);
        
        %compute local neighborhood
        neighborhood = [grid(P(y-1),P(x-1)), grid(P(y-1),x), grid(P(y-1),P(x+1));...
        grid(y,P(x-1)), grid(y,x), grid(y,P(x+1));...
        grid(P(y+1),P(x-1)), grid(P(y+1),x), grid(P(y+1),P(x+1));];

        if agent_val ~= 1 && sum(sum(neighborhood == agent_val)) >= H+1 %if number of identical agents is greater or equal H (note: H+1 because we are counting the agent itself)
            %agent is happy and does not move
        elseif agent_val > 1
            unhappy_agents = [unhappy_agents; [y,x]]; %update unhapy agents list
        end
    end
end