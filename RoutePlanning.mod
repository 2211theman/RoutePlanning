# Define Sets and Parameters
set Nodes;

param StartNode symbolic in Nodes;
param EndNode symbolic in Nodes;

set Links within (Nodes diff {EndNode}) cross (Nodes diff {StartNode});

param Costs {Links};

# Define Variables
var Path {Links} binary;

# Define Objective Function
minimize TotalCost: sum {(i, j) in Links} Costs[i, j] * Path[i, j];

# Define Constraint
subject to FlowConservation {k in Nodes}:
    sum {(k,j) in Links} Path[k,j]
    - sum {(i,k) in Links} Path[i,k]=
    if (k = StartNode) then +1
    else if (k = EndNode) then -1
    else 0;

subject to IncludeArc72:
    Path['n7', 'n2'] = 1;

subject to ExcludeArc79:
    Path['n7', 'n9'] = 0;
 