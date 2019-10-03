 function met_data(file_names, year)

file_name = strcat(file_names,'.xlsx');
[num, txt, raw] = xlsread(file_name,'1');
siz = numel(raw(:,1));
data = zeros(siz,10);
data(:,1) = datenum(txt(:,1),'mm-dd-yyyy');
data(:,2:10) = num(:,1:9);
%year = 2010;
yearmin = datenum(strcat('01-01-',num2str(year)),'mm-dd-yyyy');
yearmax = datenum(strcat('12-31-',num2str(year)),'mm-dd-yyyy');
I = find(data(:,1) >= yearmin & data(:,1) <= yearmax);

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

monthval = [31,59,90,120,151,181,212,243,273,304,334,366];
y0 = [0 max(data(I,5))+10];

%temperature
figure('units','normalized','outerposition',[0 0 1 1])
x1 = data(I,1)-yearmin+1;
p1 = bar(x1,data(I,5),'FaceColor',[1 0.8 0.2]);
hold on
p2 = bar(x1,data(I,6),'FaceColor',[1 1 1]);
hold on

for m = 1:12
        x0 = [monthval(m) monthval(m)];
       
            line(x0, y0);

       
            t = text(monthval(m),y0(1) - y0(2)/12,month(m,:),'HorizontalAlignment','left','FontSize',10);
       
        set(t,'Rotation',90);
    hold on
end

sumt = sum(data(I,5)) + sum(data(I,6));
avgtemp = (sumt)/(2*numel(I));
x = linspace(1,370);
y = avgtemp + 0*x;
p3 = plot(x,y,'-','color',[0.8 0.2 0.2]);
text(370,avgtemp,num2str(avgtemp),'HorizontalAlignment','left','color',[0.2 0.2 0.2]);
p3.LineWidth = 1.4;
hold on

pol = polyfit(x1,(data(I,5)+data(I,6))/2,5);


y1 = polyval(pol,x1);
p4 = plot(x1,y1,'color',[0.8 0.6 0.15]);
p4.LineWidth = 1.4;

hold on
labelx = "\n\n" + "Absolute Julian Day";
xlabel(compose(labelx))
ylabel('Temperature (deg. C)')
legend([p1 p4 p3],'Temp. Range of a Day','Temperature Trend','Avg. Temp')
headin = strcat(file_names,{' '}, num2str(year),{' '}, 'Temperature');
title(headin)
headin = strcat(file_names,'_', num2str(year),'_', 'Temperature');

saveas(gcf,strcat(headin,'.jpeg'));
hold off

%precipitation and rh
fig = figure('units','normalized','outerposition',[0 0 1 1])
leftc = [0.1 0.1 0.5];
rightc = [0.15 0.8 0.15];
set(fig,'defaultAxesColorOrder',[leftc; rightc]);
y0 = [0 max(data(I,7))+10];

for m = 1:12
        x0 = [monthval(m) monthval(m)];
       yyaxis left
            line(x0, y0,'Color','red');

       
            t = text(monthval(m),y0(1) - y0(2)/12,month(m,:),'HorizontalAlignment','left','FontSize',10);
       
        set(t,'Rotation',90);
    hold on
end

x1 = data(I,1)-yearmin+1;
yyaxis left
p5 = bar(x1,data(I,7),'FaceColor',[0.2 0.6 0.8]);
%set(gca,'YScale','log')
hold on 

avgrain = sum(data(I,7))/numel(I);
x = linspace(1,370);
y = avgrain + 0*x;
yyaxis left
p6 = plot(x,y,'-','color',[0.1 0.1 0.5]);
p6.LineWidth = 1.4;
hold on

yyaxis right
p7 = plot(x1,data(I,9),'o','MarkerSize',3,'color',[0.15 0.8 0.15]);

pol = polyfit(x1,data(I,9),5);


y1 = polyval(pol,x1);
yyaxis right
p8 = plot(x1,y1,'color',[0.15 0.8 0.15]);
p8.LineWidth = 1.4;

labelx = "\n\n" + "Absolute Julian Day";
xlabel(compose(labelx))
yyaxis left
ylabel('Precipitation (mm)')
yyaxis right
ylabel('Relative Humidity (fraction)')
legend([p5 p6 p7 p8],'Precipitation of a Day','Avg. Precipitation','Relative Humidity of a Day','Relative Humidity Trend')
headin = strcat(file_names,{' '}, num2str(year),{' '}, 'Precipitation and Relative Humidity');
title(headin)
headin = strcat(file_names,'_', num2str(year),'_', 'Precipitation and Relative Humidity');
saveas(gcf,strcat(headin,'.jpeg'));
hold off

%wind and solar

fig2 = figure('units','normalized','outerposition',[0 0 1 1])
leftc = [0.2 0.47 0.6];
rightc = 0.7*[0.9 0.9 0];
set(fig2,'defaultAxesColorOrder',[leftc; rightc]);
y0 = [0 max(data(I,8))*1.2];

for m = 1:12
        x0 = [monthval(m) monthval(m)];
       yyaxis left
            line(x0, y0,'Color','red');

       
            t = text(monthval(m),y0(1) - y0(2)/12,month(m,:),'HorizontalAlignment','left','FontSize',10);
       
        set(t,'Rotation',90);
    hold on
end

x1 = data(I,1)-yearmin+1;
yyaxis left
p9 = bar(x1,data(I,8),'FaceColor',[0.3 0.7 0.9]);
%set(gca,'YScale','log')
hold on 

avgrain = sum(data(I,8))/numel(I);
x = linspace(1,370);
y = avgrain + 0*x;
yyaxis left
p10 = plot(x,y,'-','color',[0.2 0.47 0.6]);
p10.LineWidth = 1.4;
hold on

yyaxis right
p11 = plot(x1,data(I,10),'o','MarkerSize',3,'color',[0.9 0.9 0]);

pol = polyfit(x1,data(I,10),3);


y1 = polyval(pol,x1);
yyaxis right
p12 = plot(x1,y1,'color',0.7*[0.9 0.9 0]);
p12.LineWidth = 1.4;

labelx = "\n\n" + "Absolute Julian Day";
xlabel(compose(labelx))
yyaxis left
ylabel('Wind Speed (m/s)')
yyaxis right
ylabel('Solar Radiation (MJ/sq. m)')
legend([p9 p10 p11 p12],'Wind Speed of a Day','Avg. Wind Speed','Solar Radian of a Day','Solar Radiation Trend')
headin = strcat(file_names,{' '}, num2str(year),{' '}, 'Wind Speed and Solar Radiation');
title(headin)
headin = strcat(file_names,'_', num2str(year),'_', 'Wind Speed and Solar Radiation');
saveas(gcf,strcat(headin,'.jpeg'));
hold off

end




