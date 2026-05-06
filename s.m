clc
clear;

















































c=[10 6 6 0 0 0];
A=[ 2 2 2 1 0 0; 2 3 3 0 1 0; 1 0 0 0 0 1];
b=[240; 270; 60];
m=size(A,1);
n=size(A,2);
bv_index=n-m+1:n;
Y=[A b];

for s=1:50
    cb=c(bv_index);
    xb=Y(:,end);
    z=cb*xb;
    zjcj=cb*Y(:,1:n)-c;
    Table=[zjcj z;Y]
    if all(zjcj>=0)
        disp(xb)
        disp(z)
        break
    else
        [a EV]=min(zjcj);
        if(Y(:,EV)<=0)
            disp('unbounded sol')
            break
        else

            for j=1:m
                if(Y(j,EV)>0)
                    ratio(j)=xb(j)/Y(j,EV);
                else
                    ratio(j)=inf;
                end
            end
        end
        [k LV]=min(ratio);
        bv_index(LV)=EV;
    end
    pivot=Y(LV,EV);
    LV
    EV
    pivot
    Y(LV,:)=Y(LV,:)/pivot;
    for i=1:m
        if(i~=LV)
            Y(i,:)=Y(i,:)-Y(i,EV)*Y(LV,:);
        end
    end
end