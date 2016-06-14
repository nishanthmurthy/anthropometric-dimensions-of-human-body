function [x1,y1,z1] = min_distance(d,xg,yg,zg,numLines,cd)
for a = 1:numLines 
    x=(xg-cd{1,1}(a,1))*(xg-cd{1,1}(a,1));
    y=(yg-cd{1,1}(a,2))*(yg-cd{1,1}(a,2));
    z=(zg-cd{1,1}(a,3))*(zg-cd{1,1}(a,3));
    r=x+y+z;
    if d>r
        d=r;
        x1=cd{1,1}(a,1);
        y1=cd{1,1}(a,2);
        z1=cd{1,1}(a,3);
    end
end
end
