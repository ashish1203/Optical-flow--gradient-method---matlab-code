%Optical flow by gradient method
%s=smoothing parameter
%n=number of iterations
function OpticalFlowGradient(inputimage1,inputimage2,s,n)
%Load images
L1=double(imread(inputimage1,'.jpg'));
L2=double(imread(inputimage2,'.jpg'));
%Image size
[rows, columns]=size(l1); %12 must have the same size
%Result flow
u=zeros(rows, columns);
v=zeros(rows, columns);
%Temporal flow
tu=zeros(rows, columns);
tv=zeros(rows, columns);
%Flow computation
for k=1:n %iterations
for x=2:columns-1
for y=2:rows-1
%derivatives
Ex=(L1(y,x+1)-L1(y,x)+L2(y,x+1)-L2(y,x)+L1(y+1,x+1)-L1(y+1,x)+L2(y+1,x+1)-L2(y+1,x))/4;
Ey=(L1(y+1,x)-L1(y,x)+L2(y+1,x)-L2(y,x)+L1(y+1,x+1)-L1(y,x+1)+L2(y+1,x+1)-L2(y,x+1))/4;
Et=(L2(y,x)-L1(y,x)+L2(y+1,x)-L1(y+1,x)+L2(y,x+1)L1(y,x+1)
+L2(y+1,x+1)-L1(y+1,x+1))/4;
%average
AU=(u(y,x-1)+u(y,x+1)+u(y-1,x)+u(y+1,x))/4;
AV=(v(y,x-1)+v(y,x+1)+v(y-1,x)+v(y+1,x))/4;
%update estimates
A=(Ex*AU+Ey*AV+Et);
B=(1+s*(Ex*Ex+Ey*Ey));
tu(y,x)=AU-(Ex*s*A/B);
tv(y,x)=AV-(Ey*s*A/B);
end %for (x,y)
end
%update
for x=2:columns-1
for y=2:rows-1
u(y,x)=tu(y,x); v(y,x)=tv(y,x);
end %for (x,y)
end
end %iterations
%display result
quiver(u,v,1);