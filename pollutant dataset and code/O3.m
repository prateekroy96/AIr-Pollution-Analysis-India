station = {'Anand Vihar Delhi';'IIT Chennai';'Kathmandu Nepal';'Maharastra Pollution Control Board Mumbai';'Nehru Nagar Kanpur';'Phora Durbar Nepal';'Punjabi Bagh Delhi';'R Bharati Unv Kolkata';'R K Puram Delhi';'Victoria Memorial Kolkata'};


for k = 1:10
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

month = ['Jan 15   ';
'Feb 15   ';
'Mar 15   ';
'Apr 15   ';
'May 15   ';
'Jun 15   ';
'Jul 15   ';
'Aug 15   ';
'Sep 15   ';
'Oct 15   ';
'Nov 15   ';
'Dec 15   ';
'Jan 16   ';
'Feb 16   ';
'Mar 16   ';
'Apr 16   ';
'May 16   ';
'Jun 16   ';
'Jul 16   ';
'Aug 16   ';
'Sep 16   ';
'Diwali 16';
'Nov 16   ';
'Dec 16   ';
'Jan 17   ';
'Feb 17   ';
'Mar 17   ';
'Apr 17   ';
'May 17   ';
'Jun 17   ';
'Jul 17   ';
'Aug 17   ';
'Sep 17   ';
'Diwali 15'];
%month(24,:);

monthval = [31,59,90,120,151,181,212,243,273,304,334,365,365+31,365+60,365+91,365+121,365+152,365+182,365+213,365+244,365+274,365+305,365+335,365+366,731+31,731+59,731+90,731+120,731+151,731+181,731+212,731+243,731+273,315,669];

figure('units','normalized','outerposition',[0 0 1 1])

y0 = [0 max(data2(:,2))];
for m = 1:34
    
    if monthval(m) > min(data2(:,1)) && monthval(m) < max(data2(:,1))
        x0 = [monthval(m) monthval(m)];
        if m == 22 || m == 34
            line(x0, y0,'color',[0 0 0]);
        else
            line(x0, y0);
        end
        if m == 22
            t = text(monthval(m),y0(2) + 5,strcat(month(m,:),' (Oct)'),'HorizontalAlignment','left','FontSize',8);
        else
            t = text(monthval(m),y0(2) + 5,month(m,:),'HorizontalAlignment','left','FontSize',8);
        end
        set(t,'Rotation',90);
    end
    hold on
end
 
p0 = plot(data2(:,1),data2(:,2),'o','MarkerSize',3,'color',[0.6 0.6 0.6]);
hold on
pol = polyfit(data2(:,1),data2(:,2),8);

x=linspace(min(data2(:,1)),max(data2(:,1)));

x1 = x;
y1 = polyval(pol,x1);
p00 = plot(x1,y1,'color',[0.2 0 0.7]);
hold on
dev = data2(:,2) - polyval(pol,data2(:,1));
s = rms(dev);
%s = std(data2(:,2));
p01 = plot(x1,y1+s,':','color',[0.3 0 1]);
hold on
p02 = plot(x1,y1-s,':','color',[0.3 0 1]);
hold on

%c = [40,80,180,280,400]; %edit no2
%c = [30,60,90,120,250]; %edit pm2.5
%c = [50,100,250,350,430]; %edit pm10
%c = [40,80,380,800,1600]; %edit so2
c = [50,100,168,208,748]; %edit o3
%c = [1,2,10,17,34] * 1000; %edit co



y=c(1)+0*x;
p1 = plot(x,y,'-','color',[0 0.9 0]);
text(max(data2(:,1))+10,c(1),'Good','HorizontalAlignment','left','color',[0 0.6 0]);
p1.LineWidth = 1.2;
hold on


if c(2) < max(data2(:,2))
y=c(2)+0*x;
p2 = plot(x,y,'-','color',[0.45 0.9 0]);
text(max(data2(:,1))+10,c(2),'Satisfactory','HorizontalAlignment','left','color',[0.3 0.6 0]);
p2.LineWidth = 1.2;
hold on
end

if c(3) < max(data2(:,2))
y=c(3)+0*x;
p3 = plot(x,y,'-','color',[0.9 0.9 0]);
text(max(data2(:,1))+10,c(3),'Moderate','HorizontalAlignment','left','color',[0.6 0.6 0]);
p3.LineWidth = 1.2;
hold on
end

if c(4) < max(data2(:,2))
y=c(4)+0*x;
p4 = plot(x,y,'-','color',[0.9 0.45 0]);
text(max(data2(:,1))+10,c(4),'Poor','HorizontalAlignment','left','color',[0.6 0.3 0]);
p4.LineWidth = 1.2;
hold on
end

if c(5) < max(data2(:,2))
y=c(5)+0*x;
p5 = plot(x,y,'-','color',[0.9 0 0]);
text(max(data2(:,1))+10,c(5),'Very Poor','HorizontalAlignment','left','color',[0.6 0 0]);
p5.LineWidth = 1.2;
end

xlabel('Relative Julian Day (w.r.t 1/1/2015)') % x-axis label
ylabel('Concentration (micrograms / cubic meter)') % y-axis label
%title({'First line';'Second line'})
headin = strcat('Ozone Concentration Trends in',{' '},station{k});
headin = headin + "\n\n\n\n\n";

title(compose(headin))

p0.LineWidth = 1.1;
p00.LineWidth = 1.2;
p01.LineWidth = 1.2;
p02.LineWidth = 1.2;






legend([p0 p00 p01],'Readings','Trend Curve','Std. Dev.')

hold off;
saveas(gcf,strcat(station{k},' O3.jpeg'));




    
    
    
    
end