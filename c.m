% All in one order is - spring > 2dangle > 2dcoordinate

% 1D spring

clc;
clear all;

%% Input

n=input('Enter no of nodes');
ne=input('Enter no of springs');
k=input('Enter the stiffness of the springs: array input');
nca=input('Enter nodal connectivity array as a matrix');
nd_num=input('Node# having restraints: array input');
nd=length(nd_num);
nf_num=input('Node# having forces: array input');
nf=length(nf_num);
f=input('Value of the forces: array input');

%% Obtaining elemental matrix and global matrix

kg=zeros(n);
for i=1:ne
    n1=nca(i,1);
    n2=nca(i,2);

    ke=[k(i) -k(i);
        -k(i) k(i)];
    %Assembly
    kg(n1,n1)=kg(n1,n1)+ke(1,1);
    kg(n1,n2)=kg(n1,n2)+ke(1,2);
    kg(n2,n1)=kg(n2,n1)+ke(2,1);
    kg(n2,n2)=kg(n2,n2)+ke(2,2);
end

kgg=kg;

%% Imposing the boundary conditions
for i=1:nd
    kg(:,nd_num(i))=0;
    kg(nd_num(i),:)=0;
    kg(nd_num(i),nd_num(i))=1;
end

%% Load Vector
fg=zeros(1,n);
for i=1:nf
    fg(nf_num(i))=f(i);
end

%% Solution
u=kg\fg';

%% Postprocessing

% Spring forces calculation
force=zeros(ne,1);
for i=1:ne
    n1=nca(i,1);
    n2=nca(i,2);

    force(i)=k(i)*(u(n2)-u(n1));
end

% Nodal forces calculation
fn=kgg*u;

% 2D angle

clc
clear all

%% inputs
n = input('Enter no of nodes\n');
d = input('Enter the dimension value\n');
ne = input('Enter no of elements(truss)\n');
E=input('Enter the youngs modulus\n');
E = E*1e9;
A = input('enter the areas of each truss element: array input\n');
A = A/1e6;
k = input('Enter the lengths of each truss element: array input\n');
Theta = input('Angel with x-axis:array input\n');
nca = input('Enter nodal connectivity array as a matrix\n');
% nf_num = input('Node# having forces =: array input');
% nf = length(nf_num);

%% To obtain the global stiffness matrix

kg = zeros(2*n);


for i =1:ne
    z(1)= nca(i,1);
    z(2)= nca(i,2);
    c = cosd(Theta(i));
    s = sind(Theta(i));

    ke = (A(i)*E)/(k(i))*[c*c c*s -c*c -c*s; 
                       c*s s*s -c*s -s*s; 
                       -c*c -c*s c*c c*s; 
                       -c*s -s*s c*s s*s];

    for a =1:d
        for b = 1:d
            for x = 1:d
                for y =1:d
                     kg(2*z(a)-2+x,2*z(b)-2+y) = kg(2*z(a)-2+x,2*z(b)-2+y) + ke(2*a-2+x,2*b-2+y);
                end
            end
        end
    end
end
kgg = kg;


nd_num = [];
bd = input('Enter the boundary conditons as 0 or 1 for 0 = restrained in array [U1x U1y U2x U2y U3x U3y]\n');
bdlen = length(bd);
for i = 1:bdlen
    if bd(i) == 0
        nd_num = [nd_num, i];
    end
end
nd=length(nd_num);

for i = 1:nd
    kg(:,nd_num(i))=0;
    kg(nd_num(i),:)=0;
    kg(nd_num(i),nd_num(i))=1;
end


%% Applied Forces

nf_num = input('Node# having forces =:array input in form[1 3 4] not[1 0 3 0 4] (Nodes are in 1x, 1y,2x,..form)\n');
nf = length(nf_num);
f=input('Input forces in order: array input');
fg=zeros(1,2*n);
for i=1:nf
    fg(nf_num(i))=f(i);
end

%% Solution
u=kg\fg';

%% Post Processing

% forces =zeros(2*ne,1);
% for i=1:ne
%     n1=nca(i,1);
%     n2=nca(i,2);
%     forces(2*i-1) = (A(i)*E(u((2*n2)-1)-u((2*n1)-1)))/k(i);
%     forces(2*i) = (A(i)*E(u((2*n2))-u((2*n1))))/k(i);
% end






% fm = zeros(1,2*n);
% for i = 1:nf
%     fm(nf_num(i)) = forces(i);
% end
% 
% %% Solution
% 
% u=kg\fm';
% 

%% First method

% for i=1:ne
%     n1 = nca(i,1);
%     n2 = nca(i,2);
% 
%     c = cosd(Theta(i));
%     s = sind(Theta(i));
%     ke = (A(i)E)/(k(i))[c*c c*s -c*c -c*s; 
%                        c*s s*s -c*s -s*s; 
%                        -c*c -c*s c*c c*s; 
%                        -c*s -s*s c*s s*s];
% 
% 
%             kg(2*n1-1,2*n1-1) = kg(2*n1-1,2*n1-1) + ke(1,1);
%             kg(2*n1-1,2*n1) = kg(2*n1-1,2*n1) + ke(1,2);
%             kg(2*n1-1,2*n2-1) = kg(2*n1-1,2*n2-1) + ke(1,3);
%             kg(2*n1-1,2*n2) = kg(2*n1-1,2*n2) + ke(1,4);
% 
%             kg(2*n1,2*n1-1) = kg(2*n1,2*n1-1) + ke(2,1);
%             kg(2*n1,2*n1) = kg(2*n1,2*n1) + ke(2,2);
%             kg(2*n1,2*n2-1) = kg(2*n1,2*n2-1) + ke(2,3);
%             kg(2*n1,2*n2) = kg(2*n1,2*n2) +ke(2,4);
% 
%             kg(2*n2-1,2*n1-1) = kg(2*n2-1,2*n1-1) + ke(3,1);
%             kg(2*n2-1,2*n1) = kg(2*n2-1,2*n1) + ke(3,2);
%             kg(2*n2-1,2*n2-1) = kg(2*n2-1,2*n2-1) + ke(3,3);
%             kg(2*n2-1,2*n2) = kg(2*n2-1,2*n2) + ke(3,4);
% 
%             kg(2*n2,2*n1-1) = kg(2*n2,2*n1-1) + ke(4,1);
%             kg(2*n2,2*n1) = kg(2*n2,2*n1) + ke(4,2);
%             kg(2*n2,2*n2-1) = kg(2*n2,2*n2-1) + ke(4,3);
%             kg(2*n2,2*n2) = kg(2*n2,2*n2) +ke(4,4);
% 
% 
% end

%% Second method

% for ii=1:2
%     n1=nca(i,ii);
%     for jj=1:2
%         n2=nca(i,jj);
% 
%         kg(2*n1-1,2*n2-1) = kg(2*n1-1,2*n2-1)+ke(2*ii-1,2*jj-1);
%         kg(2*n1-1,2*n2)=kg(2*n1-1,2*n2)+ke(2*ii-1,2*jj);
%         kg(2*n1,2*n2-1)=kg(2*n1,2*n2-1)+ke(2*ii,2*jj-1);
%         kg(2*n1,2*n2)=kg(kg(2*n1,2*n2)+ke(2*ii,2*jj));
%     end
% end

% 2D coordinate

clc;
clear all;

%% Inputs
n=input('Enter the n umber of nodes\n');
x=input('Enter the X coordinates of these nodes: Array\n');
y=input('Enter the Y coordinates of these nodes: Array\n');
ne=input('Enter no of truss elements\n');
A=input('Enter Area of cross-section in consistent unit as array\n');
A=A/1e6;
E=input('Enter the youngs modulus in consistent unit as array\n');
E=E*1e9;
nca=input('Enter nodal connectivity array as a matrix\n');

nd=input('Number of restraints \n');
for i=1:nd
    ndnum(i)=input(['Node number haveing restraint #' num2str(i) ':' '\n']);
    ndof_x(i)=input(['Dof-x for restraint #' num2str(i) ':' '\n']);
    ndof_y(i)=input(['Dof-y for restraint #' num2str(i) ':' '\n']);
end

%% Obtaining the elemental stiffness matrix and assembly
kg=zeros(2*n);
for i=1:ne
    n1=nca(i,1);
    n2=nca(i,2);
    l(i)=sqrt((x(n2)-x(n1))^2 + (y(n2)-y(n1))^2);
    c=(x(n2)-x(n1))/l(i);
    s=(y(n2)-y(n1))/l(i);

    t=[c s 0 0;
        0 0 c s];
    ke=t'*[1 -1;-1 1]*t;
    ke=(A(i)*E(i)/l(i))*ke;

    % Asembly
    for ii=1:2
        n1=nca(i,ii);
        for jj=1:2
            n2=nca(i,jj);
            kg(2*n1-1,2*n2-1)=kg(2*n1-1,2*n2-1)+ke(2*ii-1,2*jj-1);
            kg(2*n1-1,2*n2)=kg(2*n1-1,2*n2)+ke(2*ii-1,2*jj);
            kg(2*n1,2*n2-1)=kg(2*n1-1,2*n2-1)+ke(2*ii,2*jj-1);
            kg(2*n1,2*n2)=kg(2*n1-1,2*n2)+ke(2*ii,2*jj);
        end
    end
end

kgg = kg;

%% Imposing Boundary Condtions
for i=1:nd
    if ndof_x(i)==0 && ndof_y(i)==0;
        kg(:,2*ndnum(i)-1)=0;
        kg(2*ndnum(i)-1,:)=0;
        kg(2*ndnum(i)-1,2*ndnum(i)-1)=1;
        kg(:,2*ndnum(i))=0;
        kg(2*ndnum(i),:)=0;
        kg(2*ndnum(i),2*ndnum(i))=1;
    elseif ndof_x==0 && ndof_y~=0
        kg(:,2*ndnum(i)-1)=0;
        kg(2*ndnum(i)-1,:)=0;
        kg(2*ndnum(i)-1,2*ndnum(i)-1)=1;
    elseif ndof_x~=0 && ndof_y==0
        kg(:,2*ndnum(i))=0;
        kg(2*ndnum(i),:)=0;
        kg(2*ndnum(i),2*ndnum(i))=1;
    end
end
kg

% Trauss 3D

clc;
clear all;

%% Inputs
n = input('Enter number of nodes:\n');
x = input('Enter X coordinates (array):\n');
y = input('Enter Y coordinates (array):\n');
z = input('Enter Z coordinates (array):\n');
ne = input('Enter number of truss elements:\n');
A = input('Enter area of cross-sections (array):\n');  
A = A / 1e6;  
E = input('Enter Young modulus (array):\n');  
E = E * 1e9;  
nca = input('Enter nodal connectivity array (matrix):\n');

nd = input('Enter number of restrained nodes:\n');
for i = 1:nd
    ndnum(i) = input(['Node number with restraint #' num2str(i) ':\n']);
    ndof_x(i) = input(['Restrained in X-direction? (1 for yes, 0 for no) for node #' num2str(i) ':\n']);
    ndof_y(i) = input(['Restrained in Y-direction? (1 for yes, 0 for no) for node #' num2str(i) ':\n']);
    ndof_z(i) = input(['Restrained in Z-direction? (1 for yes, 0 for no) for node #' num2str(i) ':\n']);
end

%% Initialization
kg = zeros(3 * n);  % Global stiffness matrix initialization
l = zeros(1, ne);   % Length of each element

%% Stiffness Matrix Computation and Assembly
for i = 1:ne
    % Nodes forming the element
    n1 = nca(i, 1);
    n2 = nca(i, 2);
    
    % Length of the element
    dx = x(n2) - x(n1);
    dy = y(n2) - y(n1);
    dz = z(n2) - z(n1);
    l(i) = sqrt(dx^2 + dy^2 + dz^2);
    
    % Direction cosines
    c_x = dx / l(i);
    c_y = dy / l(i);
    c_z = dz / l(i);
    
    % Transformation matrix
    T = [c_x, c_y, c_z,  0,   0,   0;
          0,   0,   0, c_x, c_y, c_z];
    
    % Local stiffness matrix
    k_local = (A(i) * E(i) / l(i)) * [1, -1; -1, 1];
    
    % Global element stiffness matrix
    k_global = T' * k_local * T;
    
    % Assembly into global stiffness matrix
    dof = [3 * n1 - 2, 3 * n1 - 1, 3 * n1, 3 * n2 - 2, 3 * n2 - 1, 3 * n2];
    for ii = 1:6
        for jj = 1:6
            kg(dof(ii), dof(jj)) = kg(dof(ii), dof(jj)) + k_global(ii, jj);
        end
    end
end

kgg=kg;

%% Applying Boundary Conditions
for i = 1:nd
    node = ndnum(i);
    if ndof_x(i) == 1
        kg(:, 3 * node - 2) = 0;
        kg(3 * node - 2, :) = 0;
        kg(3 * node - 2, 3 * node - 2) = 1;
    end
    if ndof_y(i) == 1
        kg(:, 3 * node - 1) = 0;
        kg(3 * node - 1, :) = 0;
        kg(3 * node - 1, 3 * node - 1) = 1;
    end
    if ndof_z(i) == 1
        kg(:, 3 * node) = 0;
        kg(3 * node, :) = 0;
        kg(3 * node, 3 * node) = 1;
    end
end


%% Output the Global Stiffness Matrix
disp('The global stiffness matrix is:');
disp(kg);

% input of 2D trauss

4
[0 1.5 1.5 0]
[0 0 1.5 1.5]
4
[2.25 2.25 2.25 2.25]
[62 62 62 62]
[1 2;1 3;3 4;2 3]
2
1
0
0
4
0
0

% 3D trauss input

4
[0 0 0 40]
[0 0 -30 0]
[30 -30 0 0]
3
[1 1 1]
[15 15 15]
[1 4;2 4;3 4]
3
1
1
1
1
2
1
1
1
3
1
1
1

























