station = {'Anand Vihar Delhi';'IIT Chennai';'Kathmandu Nepal';'Maharastra Pollution Control Board Mumbai';'Nehru Nagar Kanpur';'Phora Durbar Nepal';'Punjabi Bagh Delhi';'R Bharati Unv Kolkata';'R K Puram Delhi';'Victoria Memorial Kolkata'};


for k = 1:10  %10
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

siz15=0; siz16=0; siz17=0;
for n = 1:f
    if data2(n,1) < 366
       siz15 = siz15 +1;
    elseif data2(n,1) > 365 && data2(n,1) < 366 + 366
        siz16 = siz16 +1;
    else
        siz17 = siz17+1;
    end
end

data15 = zeros(siz15,3);
data16 = zeros(siz16,3);
data17 = zeros(siz17,3);
for o = 1:f
    if data2(o,1) < 366
        data15(o,:) = data2(o,:);
    elseif data2(o,1) > 365 && data2(o,1) < 366 + 366
        
        data16(o - numel(data15(:,1)),:) = data2(o,:);
        data16(o - numel(data15(:,1)),1) = data2(o,1)-365;
    else
        %o - numel(data15(:,1)) - numel(data16(:,1));
        data17(o - numel(data15(:,1)) - numel(data16(:,1)),:) = data2(o,:);
        data17(o - numel(data15(:,1)) - numel(data16(:,1)),1) = mod(data2(o,1),365+366);
    end
end

monthvalabs = [31,59,90,120,151,181,212,243,273,304,334,365];
yr15 = zeros(1,12);
yr16 = zeros(1,12);
yr17 = zeros(1,12);

if siz15 > 0
    for p = 1:siz15
        if data15(p,1) <= monthvalabs(1)
            data15(p,4) = 1;
        elseif data15(p,1) <= monthvalabs(2)
            data15(p,4) = 2;
        elseif data15(p,1) <= monthvalabs(3)
            data15(p,4) = 3;
        elseif data15(p,1) <= monthvalabs(4)
            data15(p,4) = 4;
        elseif data15(p,1) <= monthvalabs(5)
            data15(p,4) = 5;
        elseif data15(p,1) <= monthvalabs(6)
            data15(p,4) = 6;
        elseif data15(p,1) <= monthvalabs(7)
            data15(p,4) = 7;
        elseif data15(p,1) <= monthvalabs(8)
            data15(p,4) = 8;
        elseif data15(p,1) <= monthvalabs(9)
            data15(p,4) = 9;
        elseif data15(p,1) <= monthvalabs(10)
            data15(p,4) = 10;
        elseif data15(p,1) <= monthvalabs(11)
            data15(p,4) = 11;
        else
            data15(p,4) = 12;
        end
    end
end

if siz16 > 0
    for p = 1:siz16
        if data16(p,1) <= monthvalabs(1)
            data16(p,4) = 1;
        elseif data16(p,1) <= monthvalabs(2)+1
            data16(p,4) = 2;
        elseif data16(p,1) <= monthvalabs(3)+1
            data16(p,4) = 3;
        elseif data16(p,1) <= monthvalabs(4)+1
            data16(p,4) = 4;
        elseif data16(p,1) <= monthvalabs(5)+1
            data16(p,4) = 5;
        elseif data16(p,1) <= monthvalabs(6)+1
            data16(p,4) = 6;
        elseif data16(p,1) <= monthvalabs(7)+1
            data16(p,4) = 7;
        elseif data16(p,1) <= monthvalabs(8)+1
            data16(p,4) = 8;
        elseif data16(p,1) <= monthvalabs(9)+1
            data16(p,4) = 9;
        elseif data16(p,1) <= monthvalabs(10)+1
            data16(p,4) = 10;
        elseif data16(p,1) <= monthvalabs(11)+1
            data16(p,4) = 11;
        else
            data16(p,4) = 12;
        end
    end
end

if siz17 > 0
    for p = 1:siz17
        if data17(p,1) <= monthvalabs(1)
            data17(p,4) = 1;
        elseif data17(p,1) <= monthvalabs(2)
            data17(p,4) = 2;
        elseif data17(p,1) <= monthvalabs(3)
            data17(p,4) = 3;
        elseif data17(p,1) <= monthvalabs(4)
            data17(p,4) = 4;
        elseif data17(p,1) <= monthvalabs(5)
            data17(p,4) = 5;
        elseif data17(p,1) <= monthvalabs(6)
            data17(p,4) = 6;
        elseif data17(p,1) <= monthvalabs(7)
            data17(p,4) = 7;
        elseif data17(p,1) <= monthvalabs(8)
            data17(p,4) = 8;
        elseif data17(p,1) <= monthvalabs(9)
            data17(p,4) = 9;
        elseif data17(p,1) <= monthvalabs(10)
            data17(p,4) = 10;
        elseif data17(p,1) <= monthvalabs(11)
            data17(p,4) = 11;
        else
            data17(p,4) = 12;
        end
    end
end

if siz15>0
    summ=zeros(12);
    countm=zeros(12);
    for ind = 1:12
        for q = 1:siz15
            if data15(q,4) == ind
                summ(ind)=summ(ind)+data15(q,2);
                countm(ind)=countm(ind)+1;
            end
        end
    end
    for ind = 1:12
        yr15(1,ind) = summ(ind)/countm(ind);
        if isnan(yr15(1,ind))
            yr15(1,ind) = 0;
        end
    end
end


if siz16>0
    summ=zeros(12);
    countm=zeros(12);
    for ind = 1:12
        for q = 1:siz16
            if data16(q,4) == ind
                summ(ind)=summ(ind)+data16(q,2);
                countm(ind)=countm(ind)+1;
            end
        end
    end
    for ind = 1:12
        yr16(1,ind) = summ(ind)/countm(ind);
        if isnan(yr16(1,ind))
            yr16(1,ind) = 0;
        end
    end
end


if siz17>0
    summ=zeros(12);
    countm=zeros(12);
    for ind = 1:12
        for q = 1:siz17
            if data17(q,4) == ind
                summ(ind)=summ(ind)+data17(q,2);
                countm(ind)=countm(ind)+1;
            end
        end
    end
    for ind = 1:12
        yr17(1,ind) = summ(ind)/countm(ind);
        if isnan(yr17(1,ind))
            yr17(1,ind) = 0;
        end
    end
end

figure('units','normalized','outerposition',[0 0 1 1])
yr = [yr15;yr16;yr17]


b = bar(monthvalabs,yr');
b(1).FaceColor = [0.3 0 1];b(1).EdgeColor = [0.2 0 1];b(1).FaceAlpha = 0.4;
b(2).FaceColor = [1 0.3 0];b(2).EdgeColor = [1 0.2 0];b(2).FaceAlpha = 0.4;
b(3).FaceColor = [0 1 0.3];b(3).EdgeColor = [0 1 0.2];b(3).FaceAlpha = 0.4;
hold on

y0 = [0 max(data2(:,2))];
for m = 1:12
        x0 = [monthval(m) monthval(m)];
       
            line(x0, y0);

       
            t = text(monthval(m),y0(2) + 5,month(m,:),'HorizontalAlignment','left','FontSize',10);
       
        set(t,'Rotation',90);
    hold on
end
if siz15>0
p015 = plot(data15(:,1),data15(:,2),'o','MarkerSize',3,'color',[0.3 0 0.1]);
hold on
end
if siz16>0
p016 = plot(data16(:,1),data16(:,2),'o','MarkerSize',3,'color',[1 0.3 0]);
hold on
end
if siz17>0
p017 = plot(data17(:,1),data17(:,2),'o','MarkerSize',3,'color',[0 1 0.3]);
hold on
end

p15 = plot(0,0,'color',[0.3 0.0 1]);
p16 = plot(0,0,'color',[1 0.3 0.0]);
p17 = plot(0,0,'color',[0.0 1 0.3]);
p15.LineWidth = 1.4;
p16.LineWidth = 1.4;
p17.LineWidth = 1.4;

if siz15>0
pol15 = polyfit(data15(:,1),data15(:,2),5);
x=linspace(min(data15(:,1)),max(data15(:,1)));
x1 = x;
y1 = polyval(pol15,x1);
p15 = plot(x1,y1,'color',[0.3 0.0 1]);
hold on
p15.LineWidth = 1.4;
end

if siz16>0
pol16 = polyfit(data16(:,1),data16(:,2),5);
x=linspace(min(data16(:,1)),max(data16(:,1)));
x1 = x;
y1 = polyval(pol16,x1);
p16 = plot(x1,y1,'color',[1 0.3 0.0]);
hold on
p16.LineWidth = 1.4;
end

if siz17>0
pol17 = polyfit(data17(:,1),data17(:,2),5);
x=linspace(min(data17(:,1)),max(data17(:,1)));
x1 = x;
y1 = polyval(pol17,x1);
p17 = plot(x1,y1,'color',[0.0 1 0.3]);
hold on
p17.LineWidth = 1.4;
end

%c = [40,80,180,280,400]; %edit no2
%c = [30,60,90,120,250]; %edit pm2.5
%c = [50,100,250,350,430]; %edit pm10
%c = [40,80,380,800,1600]; %edit so2
c = [50,100,168,208,748]; %edit o3
%c = [1,2,10,17,34] * 1000; %edit co

x = linspace(1,366);


y=c(1)+0*x;
p1 = plot(x,y,'-','color',[0.7 0.7 0.7]);
text(375,c(1),'Good','HorizontalAlignment','left','color',[0.2 0.2 0.2]);
p1.LineWidth = 1.2;
hold on


if c(2) < max(data2(:,2))
y=c(2)+0*x;
p2 = plot(x,y,'-','color',[0.55 0.55 0.55]);
text(375,c(2),'Satisfactory','HorizontalAlignment','left','color',[0.2 0.2 0.2]);
p2.LineWidth = 1.2;
hold on
end

if c(3) < max(data2(:,2))
y=c(3)+0*x;
p3 = plot(x,y,'-','color',[0.40 0.40 0.40]);
text(375,c(3),'Moderate','HorizontalAlignment','left','color',[0.2 0.2 0.2]);
p3.LineWidth = 1.2;
hold on
end

if c(4) < max(data2(:,2))
y=c(4)+0*x;
p4 = plot(x,y,'-','color',[0.25 0.25 0.25]);
text(375,c(4),'Poor','HorizontalAlignment','left','color',[0.2 0.2 0.2]);
p4.LineWidth = 1.2;
hold on
end

if c(5) < max(data2(:,2))
y=c(5)+0*x;
p5 = plot(x,y,'-','color',[0.1 0.1 0.1]);
text(375,c(5),'Very Poor','HorizontalAlignment','left','color',[0.2 0.2 0.2]);
p5.LineWidth = 1.2;
end

xlabel('Absolute Julian Day') % x-axis label
ylabel('Concentration (micrograms / cubic meter)') % y-axis label
%title({'First line';'Second line'})
headin = strcat('Ozone Concentration Trends in',{' '},station{k});
frac = numel(data2(:,1))/(max(data2(:,1))-min(data2(:,1))+1);
frac = num2str(frac);
headin = headin + "\n";
headin = strcat(headin,'Fraction of data collection =',{' '},frac);
headin = headin + "\n\n\n";
title(compose(headin))
%p0.LineWidth = 1.1;



legend([p15 p16 p17],'2015','2016','2017')

hold off;
saveas(gcf,strcat(station{k},' O3 abs.jpeg'));
    
    
    
end