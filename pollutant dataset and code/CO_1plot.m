station = {'Anand Vihar Delhi';'IIT Chennai';'Maharastra Pollution Control Board Mumbai';'Manali Chennai';'Navi Mumbai Municipal Corp ';'Nehru Nagar Kanpur';'R Bharati Unv Kolkata';'R K Puram Delhi';'Victoria Memorial Kolkata'};


for k = 1:1  %10
file_name = strcat(station{k},' CO.xlsx');
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

figure('units','normalized','outerposition',[0 0 1 1])
y0 = [0 max(data2(:,2))];
for m = 1:12
        x0 = [monthval(m) monthval(m)];
       
            line(x0, y0);

       
            t = text(monthval(m),y0(2) + 5,month(m,:),'HorizontalAlignment','left','FontSize',10);
       
        set(t,'Rotation',90);
    hold on
end


b = bar(monthvalabs,yr2');
b.FaceColor = [0 0.5 1];b(1).EdgeColor = [0 0.3 0.7];b(1).FaceAlpha = 0.3;
hold on

p0 = plot(data2(:,1),data2(:,2),'o','MarkerSize',3,'color',[0.4 0.4 0.4]);
hold on


pol = polyfit(data2(:,1),data2(:,2),5);
x=linspace(min(data2(:,1)),max(data2(:,1)));
x1 = x;
y1 = polyval(pol,x1);
p1 = plot(x1,y1,'color',[0 0.2 0.4]);
hold on
p1.LineWidth = 1.4;



%c = [40,80,180,280,400]; %edit no2
%c = [30,60,90,120,250]; %edit pm2.5
%c = [50,100,250,350,430]; %edit pm10
%c = [40,80,380,800,1600]; %edit so2
%c = [50,100,168,208,748]; %edit o3
c = [1,2,10,17,34] * 1000; %edit co

x = linspace(1,375);


y=c(1)+0*x;
p1 = plot(x,y,'-','color',[0.7 0.7 0.7]);
text(380,c(1),'Good','HorizontalAlignment','left','color',[0.2 0.2 0.2]);
p1.LineWidth = 1.2;
hold on


if c(2) < max(data2(:,2))
y=c(2)+0*x;
p2 = plot(x,y,'-','color',[0.55 0.55 0.55]);
text(380,c(2),'Satisfactory','HorizontalAlignment','left','color',[0.2 0.2 0.2]);
p2.LineWidth = 1.2;
hold on
end

if c(3) < max(data2(:,2))
y=c(3)+0*x;
p3 = plot(x,y,'-','color',[0.40 0.40 0.40]);
text(380,c(3),'Moderate','HorizontalAlignment','left','color',[0.2 0.2 0.2]);
p3.LineWidth = 1.2;
hold on
end

if c(4) < max(data2(:,2))
y=c(4)+0*x;
p4 = plot(x,y,'-','color',[0.25 0.25 0.25]);
text(380,c(4),'Poor','HorizontalAlignment','left','color',[0.2 0.2 0.2]);
p4.LineWidth = 1.2;
hold on
end

if c(5) < max(data2(:,2))
y=c(5)+0*x;
p5 = plot(x,y,'-','color',[0.1 0.1 0.1]);
text(380,c(5),'Very Poor','HorizontalAlignment','left','color',[0.2 0.2 0.2]);
p5.LineWidth = 1.2;
end

xlabel('Absolute Julian Day') % x-axis label
ylabel('Concentration (micrograms / cubic meter)') % y-axis label
%title({'First line';'Second line'})
headin = strcat('Carbon Monoxide Concentration Trends in',{' '},station{k});
polynom1 = num2str(pol(1));
polynom2 = num2str(pol(2));
polynom3 = num2str(pol(3));
polynom4 = num2str(pol(4));
polynom5 = num2str(pol(5));
polynom6 = num2str(pol(6));

sstot = 0;datam = mean(data(:,2));
for u = 1:f
    sstot = sstot + (data2(u,2) - datam)^2;
end

ssres = 0;
for u = 1:f
    ssres = ssres + (data2(u,2) - polyval(pol,data2(u,1)))^2;
end


rsq = 1 - ssres/sstot;
rsq = num2str(rsq);

headin = headin + "\n" + "Equation =>  0  =  " + polynom1 + " * x^{5}  +  " + polynom2 + " * x^{4}  +  " + polynom3 + " * x^{3}  +  " + polynom4 + " * x^{2}  +  " + polynom5 + " * x  +  " + polynom6;
low = num2str(min(data2(:,1))-1);
high = num2str(max(data2(:,1)));
headin = headin + "  , " + low + " < x < " + high;
headin = headin + "\n" + "R^{2} = " + rsq + "\n\n\n\n";
title(compose(headin))

%p0.LineWidth = 1.1;



legend([p0 b p1],'Readings','Monthly Avg.','Trend Curve')

hold off;
saveas(gcf,strcat(station{k},' CO 1plot.jpeg'));
   %{ 
    %}
    
end