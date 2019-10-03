function pol = o3(k)


station = {'Anand Vihar Delhi';'Victoria Memorial Kolkata';'Maharastra Pollution Control Board Mumbai';'Nehru Nagar Kanpur';'IIT Chennai';'Kathmandu Nepal';'Maharastra Pollution Control Board Mumbai';'Nehru Nagar Kanpur';'Phora Durbar Nepal';'Punjabi Bagh Delhi';'R Bharati Unv Kolkata';'R K Puram Delhi';'Victoria Memorial Kolkata'};



file_name = strcat(station{k},' O3.xlsx');
[conc, txt, raw] = xlsread(file_name,'1');
%datenum(raw(:,1),'dd-mm-yyyy')-datenum('29-06-2015','dd-mm-yyyy');
siz=numel(conc);
data = zeros(siz,2);
a = ones(siz,1);
data(:,2) = conc;
%data1(:,2) = cell2mat(txt);
%data1(:,1:2) = cell2mat(txt);
data(:,1) = datenum(raw(:,1),'dd-mm-yyyy')-datenum('01-01-2015','dd-mm-yyyy')+1;

d = data(1,1);
sum = data(1,2);
count = 1;
flag = 1;f=1;
%data(1:285,:);
for i = 2:siz
    if data(i,1) ~= d
        f = f +1;
        d = data(i,1);
    end
end

%f;
d = data(1,1);
data2 = zeros(f,2);
for i = 2:siz
    if data(i,1) == d
        sum = sum + data(i,2);
        count = count + 1;
    else
        data2(flag,1) = d;
        data2(flag,2) = sum/count;
        data2(flag,3) = count;
        flag = flag +1;
        sum = data(i,2);
        count = 1;
        d = data(i,1);
    end
    if i == siz
        data2(flag,1) = d;
        data2(flag,2) = sum/count;
        data2(flag,3) = count;
    end
end
data2;

month = ['Jan';
'Feb';
'Mar';
'Apr';
'May';
'Jun';
'Jul';
'Aug';
'Sep';
'Oct';
'Nov';
'Dec';];
%month(24,:);

monthval = [31,59,90,120,151,181,212,243,273,304,334,365,365+31,365+60,365+91,365+121,365+152,365+182,365+213,365+244,365+274,365+305,365+335,365+366,731+31,731+59,731+90,731+120,731+151,731+181,731+212,731+243,731+273,315,669];
monthvalabs = [31,59,90,120,151,181,212,243,273,304,334,365];

for s = 1:f
    if data2(s,1)>365 && data2(s,1)< 365 + 366 +1
        data2(s,1) = data2(s,1) - 365;
    elseif data2(s,1)> 365 + 366
        data2(s,1) = data2(s,1) - 365 - 366;
    end
end


    for p = 1:f
        if data2(p,1) <= monthvalabs(1)
            data2(p,4) = 1;
        elseif data2(p,1) <= monthvalabs(2)
            data2(p,4) = 2;
        elseif data2(p,1) <= monthvalabs(3)
            data2(p,4) = 3;
        elseif data2(p,1) <= monthvalabs(4)
            data2(p,4) = 4;
        elseif data2(p,1) <= monthvalabs(5)
            data2(p,4) = 5;
        elseif data2(p,1) <= monthvalabs(6)
            data2(p,4) = 6;
        elseif data2(p,1) <= monthvalabs(7)
            data2(p,4) = 7;
        elseif data2(p,1) <= monthvalabs(8)
            data2(p,4) = 8;
        elseif data2(p,1) <= monthvalabs(9)
            data2(p,4) = 9;
        elseif data2(p,1) <= monthvalabs(10)
            data2(p,4) = 10;
        elseif data2(p,1) <= monthvalabs(11)
            data2(p,4) = 11;
        else
            data2(p,4) = 12;
        end
    end



    summ=zeros(12);
    countm=zeros(12);
    for ind = 1:12
        for q = 1:f
            if data2(q,4) == ind
                summ(ind)=summ(ind)+data2(q,2);
                countm(ind)=countm(ind)+1;
            end
        end
    end
    for ind = 1:12
        yr2(1,ind) = summ(ind)/countm(ind);
        if isnan(yr2(1,ind))
            yr2(1,ind) = 0;
        end
    end


y0 = [0 max(data2(:,2))];





pol = polyfit(data2(:,1),data2(:,2),5);
x=linspace(min(data2(:,1)),max(data2(:,1)));
x1 = x;
y1 = polyval(pol,x1);



end