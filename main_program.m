
fid=fopen('subject.obj','r');
%opening file in read mode

if fid<0
error('cannot open the file:%s',filename);
end

data=textscan(fid,'%s','delimiter','\n','whitespace',' ');
%textscan reads data from text file and converts and stores into cell array

fclose(fid);

c=deblank(data{1});
%deblank removes trailing null characters and whitespaces, i.e: tabs and spaces

c(cellfun('isempty',c))=[];
%Apply function to each cell in cell array

fid=fopen('subject.obj','w');

if fid<0

error('cannot open the file:%s',subject.obj);

end

fprintf(fid,'%s\n',c{:});

fclose(fid);

edit 'vertices.txt';

edit 'faces.txt';

fid=fopen('vertices.txt','w');

fid1=fopen('faces.txt','w');

% c=textread('subject.obj','%s','delimiter','\n');

n=size(c,1);

for i=2:1:n

s=c{i,1};

if(strcmp(s(1),'v')&&isspace(s(2)))

fprintf(fid,'%s\n',s);

elseif(strcmp(s(1),'f'))

fprintf(fid1,'%s\n',s);

end

end

fclose(fid);

fclose(fid1);

v=importdata('vertices.txt',' ');

f=importdata('faces.txt',' ');
figure;
h=patch('Faces',f.data,'Vertices',v.data,'Facecolor','yellow');

%to get no of lines in vertices.txt file
fid = fopen('vertices.txt', 'rb'); %rb is 'read binary' mode, even 'r' can be used

%Get file size.
fseek(fid, 0, 'eof');
%fseek(fileID, offset, origin)
%sets the file position indicator offset bytes from origin in the specified file.
%status = fseek(fileID, offset, origin) returns 0 when the operation
%is successful. Otherwise, it returns -1.


fileSize = ftell(fid);
%position = ftell(fileID) returns the current position in the specified
%file. position is a zero-based integer that indicates the number of bytes
%from the beginning of the file. If the query is unsuccessful, position is
%-1. fileID is an integer file identifier obtained from fopen.

frewind(fid);
%frewind(fileID) sets the file position indicator to the beginning of a
%file. fileID is an integer file identifier obtained from fopen.

%Read the whole file.
data = fread(fid, fileSize, 'uint8');
%A = fread(fileID,sizeA,precision) interprets values in the file according
%to the form and size described by precision.
%The sizeA argument is optional.


% Count number of line-feeds and increase by one.
numLines = sum(data == 10) + 1;
fclose(fid);
numLines=numLines-1;

%to find right shoulder vertices
cd = struct2cell(v);                  
[x1,y1,z1]=min_distance(10000,0,0,10,numLines,cd);
[x2,y2,z2]=min_distance(10000,-10,0,0,numLines,cd);
[xl,yl,zl]=min_distance(10000,x2,0,z1-.2,numLines,cd);

%to find left shoulder vertices
[x1,y1,z1]=min_distance(10000,10,0,0,numLines,cd);                 
[xr,yr,zr]=min_distance(10000,x1,0,zl,numLines,cd);



%to find shoulder length
shoulder_length=xr-xl;
shoulder_length=shoulder_length*100;
shoulder_length=round(shoulder_length);
s1=shoulder_length;
fprintf('\n\n shoulder length   : %d',s1);
%to find the waist length
a=(shoulder_length)/2; % 2a is the major axis of an ellipse
[x1,ys1,z1]=min_distance(10000,0,10,0,numLines,cd);
[x1,ys2,z1]=min_distance(10000,0,-10,0,numLines,cd);
b=(ys2-ys1)/2; % 2b is the minor axis of the ellipse
h=((a-b)^2/(a+b)^2); %formula for h of an ellipse
p=3.14*(a+b)*(1+(3*h/(10+sqrt(4-3*h)))); %ramanujam formula for perimeter
s2= round(p/2.58);
fprintf('\n waist length         : %d\n\n',s2);
