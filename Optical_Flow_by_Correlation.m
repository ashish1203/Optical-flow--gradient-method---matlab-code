%Optical flow by correlation
%d: max displacement., w: window size 2w+1
function FlowCorr(inputimage1,inputimage2,d,w)
%Load images
L1=double(imread(inputimage1,'.jpg'));
L2=double(imread(inputimage2,'.jpg'));
%image size
[rows, columns]=size(L1); %L2 must have the same size
%result image
u=zeros(rows, columns);
v=zeros(rows, columns);
%correlation for each pixel
for x1=w+d+1:columns–w–d
for y1=w+d+1:rows–w–d
min=99999; dx=0; dy=0;
%desplacement position
for x2=x1–d:x1+d
for y2=y1–d:y1+d
sum=0;
for i=-w:w% window
for j=–w:w
sum=sum+(double(L1(y1+j,x1+i))–
double(L2(y2+j,x2+i)))^2;
end
end
if (sum<min)
min=sum;
dx=x2–x1; dy=y2–y1;
end
end
end
u(y1,x1)=dx;
v(y1,x1)=dy;
end
end
%display result
quiver(u,v,.1);