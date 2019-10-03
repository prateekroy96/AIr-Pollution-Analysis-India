station = {'Delhi','Kolkata','Mumbai','Kanpur'};
for k = 1:4  %4
%k = 1;
%met data
file_name = strcat(station{k},'_m.xlsx');
[num, txt, raw] = xlsread(file_name,'1');
siz = numel(raw(:,1));
data_m = zeros(siz,10);
data_m(:,1) = datenum(txt(:,1),'mm-dd-yyyy');
data_m(:,2:10) = num(:,1:9);
%day temp sr rh p
met_avg = zeros(365,5);
met_add = zeros(365,4);
met_sum = zeros(365,4);
met_avg(:,1)= 1:365;

for year = 2004:2013
yearmin = datenum(strcat('01-01-',num2str(year)),'mm-dd-yyyy');
yearmax = yearmin + 364;
I = find(data_m(:,1) >= yearmin & data_m(:,1) <= yearmax);
met_add(:,1) = (data_m(I,5) + data_m(I,5))/2; %temp
met_add(:,2) = data_m(I,10); %sr
met_add(:,3) = data_m(I,9);  %rh
met_add(:,4) = data_m(I,7);  %p
met_sum = met_sum + met_add;
end

met_avg(:,2:5)= met_sum/10;

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

monthval = [31,59,90,120,151,181,212,243,273,304,334,365];

%[a_co, a_no2, a_o3] = tox();

x1 = 1:365;
c = [30, 60, 90, 120, 250; 
    1000, 2000, 10000, 17000, 34000; 
    40, 80, 180, 280, 400; 
    50, 100, 168, 208, 748];
para= {'PM2.5','CO','NO2','O3'};

for z = 1:4
%pol. and temp----------------------------------------------------------
figure('units','normalized','outerposition',[0 0 1 1])
y0 = [0 max(met_avg(:,2))+10];
%season cutoffs
%winter 0-59; spring 59-120; summer 120-181; monsoon 181-258; 
%autumn 258-319; fall 319-365;
y00 = int16(y0(2));
r1 = rectangle('Position',[0 0 59 y00]);
r1.FaceColor = 0.85*[.8 .8 1];
r1.EdgeColor = 0.85*[.8 .8 1];
t = text(10,y0(2) - y0(2)/30,'Winter','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);

r2 = rectangle('Position',[59 0 120-59 y00]);
r2.FaceColor = 0.9*0.8*[.8 .8 1] + 0.9*0.2*[.8 1 .8];
r2.EdgeColor = 0.9*0.8*[.8 .8 1] + 0.9*0.2*[.8 1 .8];
t = text(59+10,y0(2) - y0(2)/30,'Spring','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);

r3 = rectangle('Position',[120 0 181-120 y00]);
r3.FaceColor = 0.6*[.8 .8 1] + 0.4*[.8 1 .8];
r3.EdgeColor = 0.6*[.8 .8 1] + 0.4*[.8 1 .8];
t = text(120+10,y0(2) - y0(2)/30,'Summer','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);

r4 = rectangle('Position',[181 0 258-181 y00]);
r4.FaceColor = 0.4*[.8 .8 1] + 0.6*[.8 1 .8];
r4.EdgeColor = 0.4*[.8 .8 1] + 0.6*[.8 1 .8];
t = text(181+10,y0(2) - y0(2)/30,'Monsoon','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);

r5 = rectangle('Position',[258 0 319-258 y00]);
r5.FaceColor = 0.9*0.2*[.8 .8 1] + 0.9*0.8*[.8 1 .8];
r5.EdgeColor = 0.9*0.2*[.8 .8 1] + 0.9*0.8*[.8 1 .8];
t = text(258+10,y0(2) - y0(2)/30,'Autumn','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);

r6 = rectangle('Position',[319 0 365-319 y00]);
r6.FaceColor = 0.85*[.8 1 .8];
r6.EdgeColor = 0.85*[.8 1 .8];
t = text(319+10,y0(2) - y0(2)/30,'Fall','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);
%month cutoffs

for m = 1:12
        x0 = [monthval(m) monthval(m)];
       
            line(x0, y0,'Color',[.6 .6 .6]);

       
            t = text(monthval(m),y0(1) - y0(2)/11,month(m,:),'HorizontalAlignment','left','FontSize',10);
       
        set(t,'Rotation',90);
    hold on
end


x = linspace(1,365);
yyaxis right
y=c(z,1)+0*x;
l1 = plot(x,y,'-','color',[0.5 0.5 0.5]);
text(370,c(z,1),'Good','HorizontalAlignment','left','color',[0.2 0.2 0.2]);
l1.LineWidth = 1.3;
hold on


y=c(z,2)+0*x;
l2 = plot(x,y,'-','color',[0.4 0.4 0.4]);
text(370,c(z,2),'Satisfactory','HorizontalAlignment','left','color',[0.2 0.2 0.2]);
l2.LineWidth = 1.3;
hold on

y=c(z,3)+0*x;
l3 = plot(x,y,'-','color',[0.3 0.3 0.3]);
text(370,c(z,3),'Moderate','HorizontalAlignment','left','color',[0.2 0.2 0.2]);
l3.LineWidth = 1.3;
hold on


y=c(z,4)+0*x;
l4 = plot(x,y,'-','color',[0.2 0.2 0.2]);
text(370,c(z,4),'Poor','HorizontalAlignment','left','color',[0.2 0.2 0.2]);
l4.LineWidth = 1.3;
hold on


if z == 1 || z == 3
y=c(z,5)+0*x;
l5 = plot(x,y,'-','color',[0.1 0.1 0.1]);
text(370,c(z,5),'Very Poor','HorizontalAlignment','left','color',[0.2 0.2 0.2]);
l5.LineWidth = 1.3;
hold on
end

yyaxis left
pol = polyfit(met_avg(:,1),met_avg(:,2),5);


y1 = polyval(pol,x1);
p1 = plot(x1,y1,':','color',[.8 .2 .2]);
p1.LineWidth = 1.8;
hold on
r11 = r(x1,met_avg(:,2),y1');
yyaxis right

pol_p = pollu(z,k);
y1 = polyval(pol_p,x1);
p2 = plot(x1,y1,'-','Color',[0 0 .4]);
p2.LineWidth = 1.4;
hold on

labelx = "\n\n" + "Absolute Julian Day";
xlabel(compose(labelx))
yyaxis left
ylabel('Temperature (Degree Celsius)')
yyaxis right
ylabel(strcat(para{z},{' '},'conc. (micrograms / cu. meters)'))

headin = strcat(station{k},{' - '},'Temperature (R sq. =',{' '},num2str(r11),') and',{' '},para{z},{' '},'Trends');
title(headin);

legend([p1 p2],'Temperature',para{z});
saveas(gcf,strcat(station{k},'_','Temp','_',para{z},'.jpeg'));
hold off

%pol. and Solar Rad---------------------------------------------------------
figure('units','normalized','outerposition',[0 0 1 1])
y0 = [0 max(met_avg(:,3))*1.2];
%season cutoffs
%winter 0-59; spring 59-120; summer 120-181; monsoon 181-258; 
%autumn 258-319; fall 319-365;
y00 = int16(y0(2));
r1 = rectangle('Position',[0 0 59 y00]);
r1.FaceColor = 0.85*[.8 .8 1];
r1.EdgeColor = 0.85*[.8 .8 1];
t = text(10,y0(2) - y0(2)/30,'Winter','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);

r2 = rectangle('Position',[59 0 120-59 y00]);
r2.FaceColor = 0.9*0.8*[.8 .8 1] + 0.9*0.2*[.8 1 .8];
r2.EdgeColor = 0.9*0.8*[.8 .8 1] + 0.9*0.2*[.8 1 .8];
t = text(59+10,y0(2) - y0(2)/30,'Spring','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);

r3 = rectangle('Position',[120 0 181-120 y00]);
r3.FaceColor = 0.6*[.8 .8 1] + 0.4*[.8 1 .8];
r3.EdgeColor = 0.6*[.8 .8 1] + 0.4*[.8 1 .8];
t = text(120+10,y0(2) - y0(2)/30,'Summer','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);

r4 = rectangle('Position',[181 0 258-181 y00]);
r4.FaceColor = 0.4*[.8 .8 1] + 0.6*[.8 1 .8];
r4.EdgeColor = 0.4*[.8 .8 1] + 0.6*[.8 1 .8];
t = text(181+10,y0(2) - y0(2)/30,'Monsoon','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);

r5 = rectangle('Position',[258 0 319-258 y00]);
r5.FaceColor = 0.9*0.2*[.8 .8 1] + 0.9*0.8*[.8 1 .8];
r5.EdgeColor = 0.9*0.2*[.8 .8 1] + 0.9*0.8*[.8 1 .8];
t = text(258+10,y0(2) - y0(2)/30,'Autumn','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);

r6 = rectangle('Position',[319 0 365-319 y00]);
r6.FaceColor = 0.85*[.8 1 .8];
r6.EdgeColor = 0.85*[.8 1 .8];
t = text(319+10,y0(2) - y0(2)/30,'Fall','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);
%month cutoffs

for m = 1:12
        x0 = [monthval(m) monthval(m)];
       
            line(x0, y0,'Color',[.6 .6 .6]);

       
            t = text(monthval(m),y0(1) - y0(2)/11,month(m,:),'HorizontalAlignment','left','FontSize',10);
       
        set(t,'Rotation',90);
    hold on
end


x = linspace(1,365)
yyaxis right
y=c(z,1)+0*x;
l1 = plot(x,y,'-','color',[0.5 0.5 0.5]);
text(370,c(z,1),'Good','HorizontalAlignment','left','color',[0.2 0.2 0.2]);
l1.LineWidth = 1.3;
hold on


y=c(z,2)+0*x;
l2 = plot(x,y,'-','color',[0.4 0.4 0.4]);
text(370,c(z,2),'Satisfactory','HorizontalAlignment','left','color',[0.2 0.2 0.2]);
l2.LineWidth = 1.3;
hold on

y=c(z,3)+0*x;
l3 = plot(x,y,'-','color',[0.3 0.3 0.3]);
text(370,c(z,3),'Moderate','HorizontalAlignment','left','color',[0.2 0.2 0.2]);
l3.LineWidth = 1.3;
hold on


y=c(z,4)+0*x;
l4 = plot(x,y,'-','color',[0.2 0.2 0.2]);
text(370,c(z,4),'Poor','HorizontalAlignment','left','color',[0.2 0.2 0.2]);
l4.LineWidth = 1.3;
hold on


if z == 1 || z == 3
y=c(z,5)+0*x;
l5 = plot(x,y,'-','color',[0.1 0.1 0.1]);
text(370,c(z,5),'Very Poor','HorizontalAlignment','left','color',[0.2 0.2 0.2]);
l5.LineWidth = 1.3;
hold on
end
yyaxis left
pol = polyfit(met_avg(:,1),met_avg(:,3),3);


y1 = polyval(pol,x1);
p1 = plot(x1,y1,':','color',[.4 .4 .2]);
p1.LineWidth = 1.8;
hold on
r11 = r(x1,met_avg(:,3),y1');
yyaxis right

pol_p = pollu(z,k);
y1 = polyval(pol_p,x1);
p2 = plot(x1,y1,'-','Color',[0 0 .4]);
p2.LineWidth = 1.4;
hold on

labelx = "\n\n" + "Absolute Julian Day";
xlabel(compose(labelx))
yyaxis left
ylabel('Solar Radiation (MJ/sq. m)')
yyaxis right
ylabel(strcat(para{z},{' '},'conc. (micrograms / cu. meters)'))
headin = strcat(station{k},{' - '},'Solar Radiation (R sq. =',{' '},num2str(r11),') and',{' '},para{z},{' '},'Trends');
title(headin);

legend([p1 p2],'Solar Radiation',para{z});
saveas(gcf,strcat(station{k},'_','SR','_',para{z},'.jpeg'));
hold off

%pol. and RH---------------------------------------------------------
figure('units','normalized','outerposition',[0 0 1 1])
y0 = [0 1];
%season cutoffs
%winter 0-59; spring 59-120; summer 120-181; monsoon 181-258; 
%autumn 258-319; fall 319-365;
y00 = int16(y0(2));
r1 = rectangle('Position',[0 0 59 y00]);
r1.FaceColor = 0.85*[.8 .8 1];
r1.EdgeColor = 0.85*[.8 .8 1];
t = text(10,y0(2) - y0(2)/30,'Winter','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);

r2 = rectangle('Position',[59 0 120-59 y00]);
r2.FaceColor = 0.9*0.8*[.8 .8 1] + 0.9*0.2*[.8 1 .8];
r2.EdgeColor = 0.9*0.8*[.8 .8 1] + 0.9*0.2*[.8 1 .8];
t = text(59+10,y0(2) - y0(2)/30,'Spring','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);

r3 = rectangle('Position',[120 0 181-120 y00]);
r3.FaceColor = 0.6*[.8 .8 1] + 0.4*[.8 1 .8];
r3.EdgeColor = 0.6*[.8 .8 1] + 0.4*[.8 1 .8];
t = text(120+10,y0(2) - y0(2)/30,'Summer','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);

r4 = rectangle('Position',[181 0 258-181 y00]);
r4.FaceColor = 0.4*[.8 .8 1] + 0.6*[.8 1 .8];
r4.EdgeColor = 0.4*[.8 .8 1] + 0.6*[.8 1 .8];
t = text(181+10,y0(2) - y0(2)/30,'Monsoon','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);

r5 = rectangle('Position',[258 0 319-258 y00]);
r5.FaceColor = 0.9*0.2*[.8 .8 1] + 0.9*0.8*[.8 1 .8];
r5.EdgeColor = 0.9*0.2*[.8 .8 1] + 0.9*0.8*[.8 1 .8];
t = text(258+10,y0(2) - y0(2)/30,'Autumn','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);

r6 = rectangle('Position',[319 0 365-319 y00]);
r6.FaceColor = 0.85*[.8 1 .8];
r6.EdgeColor = 0.85*[.8 1 .8];
t = text(319+10,y0(2) - y0(2)/30,'Fall','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);
%month cutoffs

for m = 1:12
        x0 = [monthval(m) monthval(m)];
       
            line(x0, y0,'Color',[.6 .6 .6]);

       
            t = text(monthval(m),y0(1) - y0(2)/11,month(m,:),'HorizontalAlignment','left','FontSize',10);
       
        set(t,'Rotation',90);
    hold on
end


x = linspace(1,365)
yyaxis right
y=c(z,1)+0*x;
l1 = plot(x,y,'-','color',[0.5 0.5 0.5]);
text(370,c(z,1),'Good','HorizontalAlignment','left','color',[0.2 0.2 0.2]);
l1.LineWidth = 1.3;
hold on


y=c(z,2)+0*x;
l2 = plot(x,y,'-','color',[0.4 0.4 0.4]);
text(370,c(z,2),'Satisfactory','HorizontalAlignment','left','color',[0.2 0.2 0.2]);
l2.LineWidth = 1.3;
hold on

y=c(z,3)+0*x;
l3 = plot(x,y,'-','color',[0.3 0.3 0.3]);
text(370,c(z,3),'Moderate','HorizontalAlignment','left','color',[0.2 0.2 0.2]);
l3.LineWidth = 1.3;
hold on


y=c(z,4)+0*x;
l4 = plot(x,y,'-','color',[0.2 0.2 0.2]);
text(370,c(z,4),'Poor','HorizontalAlignment','left','color',[0.2 0.2 0.2]);
l4.LineWidth = 1.3;
hold on


if z == 1 || z == 3
y=c(z,5)+0*x;
l5 = plot(x,y,'-','color',[0.1 0.1 0.1]);
text(370,c(z,5),'Very Poor','HorizontalAlignment','left','color',[0.2 0.2 0.2]);
l5.LineWidth = 1.3;
hold on
end
yyaxis left
pol = polyfit(met_avg(:,1),met_avg(:,4),5);


y1 = polyval(pol,x1);
p1 = plot(x1,y1,':','color',[.4 .4 .2]);
p1.LineWidth = 1.8;
hold on
r11 = r(x1,met_avg(:,4),y1');
yyaxis right

pol_p = pollu(z,k);
y1 = polyval(pol_p,x1);
p2 = plot(x1,y1,'-','Color',[0 0 .4]);
p2.LineWidth = 1.4;
hold on

labelx = "\n\n" + "Absolute Julian Day";
xlabel(compose(labelx))
yyaxis left
ylabel('Relative Humidity (fraction)')
yyaxis right
ylabel(strcat(para{z},{' '},'conc. (micrograms / cu. meters)'))
headin = strcat(station{k},{' - '},'Relative Humidity (R sq. =',{' '},num2str(r11),') and',{' '},para{z},{' '},'Trends');
title(headin);

legend([p1 p2],'Relative Humidity',para{z});
saveas(gcf,strcat(station{k},'_','RH','_',para{z},'.jpeg'));
hold off

%pol. and precipitation---------------------------------------------------------
figure('units','normalized','outerposition',[0 0 1 1])
y0 = [0 max(met_avg(:,5))*1.2];
%season cutoffs
%winter 0-59; spring 59-120; summer 120-181; monsoon 181-258; 
%autumn 258-319; fall 319-365;
y00 = int16(y0(2));
r1 = rectangle('Position',[0 0 59 y00]);
r1.FaceColor = 0.85*[.8 .8 1];
r1.EdgeColor = 0.85*[.8 .8 1];
t = text(10,y0(2) - y0(2)/30,'Winter','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);

r2 = rectangle('Position',[59 0 120-59 y00]);
r2.FaceColor = 0.9*0.8*[.8 .8 1] + 0.9*0.2*[.8 1 .8];
r2.EdgeColor = 0.9*0.8*[.8 .8 1] + 0.9*0.2*[.8 1 .8];
t = text(59+10,y0(2) - y0(2)/30,'Spring','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);

r3 = rectangle('Position',[120 0 181-120 y00]);
r3.FaceColor = 0.6*[.8 .8 1] + 0.4*[.8 1 .8];
r3.EdgeColor = 0.6*[.8 .8 1] + 0.4*[.8 1 .8];
t = text(120+10,y0(2) - y0(2)/30,'Summer','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);

r4 = rectangle('Position',[181 0 258-181 y00]);
r4.FaceColor = 0.4*[.8 .8 1] + 0.6*[.8 1 .8];
r4.EdgeColor = 0.4*[.8 .8 1] + 0.6*[.8 1 .8];
t = text(181+10,y0(2) - y0(2)/30,'Monsoon','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);

r5 = rectangle('Position',[258 0 319-258 y00]);
r5.FaceColor = 0.9*0.2*[.8 .8 1] + 0.9*0.8*[.8 1 .8];
r5.EdgeColor = 0.9*0.2*[.8 .8 1] + 0.9*0.8*[.8 1 .8];
t = text(258+10,y0(2) - y0(2)/30,'Autumn','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);

r6 = rectangle('Position',[319 0 365-319 y00]);
r6.FaceColor = 0.85*[.8 1 .8];
r6.EdgeColor = 0.85*[.8 1 .8];
t = text(319+10,y0(2) - y0(2)/30,'Fall','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);
%month cutoffs

for m = 1:12
        x0 = [monthval(m) monthval(m)];
       
            line(x0, y0,'Color',[.6 .6 .6]);

       
            t = text(monthval(m),y0(1) - y0(2)/11,month(m,:),'HorizontalAlignment','left','FontSize',10);
       
        set(t,'Rotation',90);
    hold on
end


x = linspace(1,365)
yyaxis right
y=c(z,1)+0*x;
l1 = plot(x,y,'-','color',[0.5 0.5 0.5]);
text(370,c(z,1),'Good','HorizontalAlignment','left','color',[0.2 0.2 0.2]);
l1.LineWidth = 1.3;
hold on


y=c(z,2)+0*x;
l2 = plot(x,y,'-','color',[0.4 0.4 0.4]);
text(370,c(z,2),'Satisfactory','HorizontalAlignment','left','color',[0.2 0.2 0.2]);
l2.LineWidth = 1.3;
hold on

y=c(z,3)+0*x;
l3 = plot(x,y,'-','color',[0.3 0.3 0.3]);
text(370,c(z,3),'Moderate','HorizontalAlignment','left','color',[0.2 0.2 0.2]);
l3.LineWidth = 1.3;
hold on


y=c(z,4)+0*x;
l4 = plot(x,y,'-','color',[0.2 0.2 0.2]);
text(370,c(z,4),'Poor','HorizontalAlignment','left','color',[0.2 0.2 0.2]);
l4.LineWidth = 1.3;
hold on


if z == 1 || z == 3
y=c(z,5)+0*x;
l5 = plot(x,y,'-','color',[0.1 0.1 0.1]);
text(370,c(z,5),'Very Poor','HorizontalAlignment','left','color',[0.2 0.2 0.2]);
l5.LineWidth = 1.3;
hold on
end
yyaxis left

p1 = bar(x1,met_avg(:,5),'FaceColor',[0.2 0.6 0.8]);
hold on

yyaxis right

pol_p = pollu(z,k);
y1 = polyval(pol_p,x1);
p2 = plot(x1,y1,'-','Color',[0 0 .4]);
p2.LineWidth = 1.4;
hold on

labelx = "\n\n" + "Absolute Julian Day";
xlabel(compose(labelx))
yyaxis left
ylabel('Precipitation (mm)')
yyaxis right
ylabel(strcat(para{z},{' '},'conc. (micrograms / cu. meters)'))
headin = strcat(station{k},{' - '},'Precipitation and',{' '},para{z},{' '},'Trends');
title(headin);

legend([p1 p2],'Precipitation',para{z});
saveas(gcf,strcat(station{k},'_','Rain','_',para{z},'.jpeg'));
hold off
end

%no vs o3--------------------------------------------------------------
figure('units','normalized','outerposition',[0 0 1 1])
yyaxis left

y0 = [0 c(3,5)*1.2];
%season cutoffs
%winter 0-59; spring 59-120; summer 120-181; monsoon 181-258; 
%autumn 258-319; fall 319-365;
y00 = int16(y0(2));
r1 = rectangle('Position',[0 0 59 y00]);
r1.FaceColor = 0.85*[.8 .8 1];
r1.EdgeColor = 0.85*[.8 .8 1];
t = text(10,y0(2) - y0(2)/20,'Winter','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);

r2 = rectangle('Position',[59 0 120-59 y00]);
r2.FaceColor = 0.9*0.8*[.8 .8 1] + 0.9*0.2*[.8 1 .8];
r2.EdgeColor = 0.9*0.8*[.8 .8 1] + 0.9*0.2*[.8 1 .8];
t = text(59+10,y0(2) - y0(2)/20,'Spring','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);

r3 = rectangle('Position',[120 0 181-120 y00]);
r3.FaceColor = 0.6*[.8 .8 1] + 0.4*[.8 1 .8];
r3.EdgeColor = 0.6*[.8 .8 1] + 0.4*[.8 1 .8];
t = text(120+10,y0(2) - y0(2)/20,'Summer','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);

r4 = rectangle('Position',[181 0 258-181 y00]);
r4.FaceColor = 0.4*[.8 .8 1] + 0.6*[.8 1 .8];
r4.EdgeColor = 0.4*[.8 .8 1] + 0.6*[.8 1 .8];
t = text(181+10,y0(2) - y0(2)/20,'Monsoon','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);

r5 = rectangle('Position',[258 0 319-258 y00]);
r5.FaceColor = 0.9*0.2*[.8 .8 1] + 0.9*0.8*[.8 1 .8];
r5.EdgeColor = 0.9*0.2*[.8 .8 1] + 0.9*0.8*[.8 1 .8];
t = text(258+10,y0(2) - y0(2)/20,'Autumn','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);

r6 = rectangle('Position',[319 0 365-319 y00]);
r6.FaceColor = 0.85*[.8 1 .8];
r6.EdgeColor = 0.85*[.8 1 .8];
t = text(319+10,y0(2) - y0(2)/20,'Fall','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);
%month cutoffs

for m = 1:12
        x0 = [monthval(m) monthval(m)];
       
            line(x0, y0,'Color',[.6 .6 .6]);

       
            t = text(monthval(m),y0(1) - y0(2)/11,month(m,:),'HorizontalAlignment','left','FontSize',10);
       
        set(t,'Rotation',90);
    hold on
end


x = linspace(1,365);
yyaxis left
y=c(3,1)+0*x;
l1 = plot(x,y,':','color',0.9*[0.2 0.2 1]);
text(366,c(3,1),'Good (NO2)','HorizontalAlignment','left','color',[0.2 0.2 0.7]);
l1.LineWidth = 1.3;
hold on


y=c(3,2)+0*x;
l2 = plot(x,y,':','color',0.8*[0.2 0.2 1]);
text(366,c(3,2),'Satisfactory (NO2)','HorizontalAlignment','left','color',[0.2 0.2 0.7]);
l2.LineWidth = 1.3;
hold on

y=c(3,3)+0*x;
l3 = plot(x,y,':','color',0.7*[0.2 0.2 1]);
text(366,c(3,3),'Moderate (NO2)','HorizontalAlignment','left','color',[0.2 0.2 0.7]);
l3.LineWidth = 1.3;
hold on


y=c(3,4)+0*x;
l4 = plot(x,y,':','color',0.6*[0.2 0.2 1]);
text(366,c(3,4),'Poor (NO2)','HorizontalAlignment','left','color',[0.2 0.2 0.7]);
l4.LineWidth = 1.3;
hold on


y=c(3,5)+0*x;
l5 = plot(x,y,':','color',0.5*[0.2 0.2 1]);
text(366,c(3,5),'Very Poor (NO2)','HorizontalAlignment','left','color',[0.2 0.2 0.7]);
l5.LineWidth = 1.3;
hold on


yyaxis right
y=c(4,1)+0*x;
l1 = plot(x,y,':','color',0.9*[1 0.2 0.2]);
text(366,c(4,1),'Good (O3)','HorizontalAlignment','left','color',[0.7 0.2 0.2]);
l1.LineWidth = 1.3;
hold on


y=c(4,2)+0*x;
l2 = plot(x,y,':','color',0.8*[1 0.2 0.2]);
text(366,c(4,2),'Satisfactory (O3)','HorizontalAlignment','left','color',[0.7 0.2 0.2]);
l2.LineWidth = 1.3;
hold on

y=c(4,3)+0*x;
l3 = plot(x,y,':','color',0.7*[1 0.2 0.2]);
text(366,c(4,3),'Moderate (O3)','HorizontalAlignment','left','color',[0.7 0.2 0.2]);
l3.LineWidth = 1.3;
hold on


y=c(4,4)+0*x;
l4 = plot(x,y,':','color',0.6*[1 0.2 0.2]);
text(366,c(4,4),'Poor (O3)','HorizontalAlignment','left','color',[0.7 0.2 0.2]);
l4.LineWidth = 1.3;
hold on

yyaxis left

pol_p = pollu(3,k);
y11 = polyval(pol_p,x1);
p21 = plot(x1,y11,'-','Color',[0 0 .8]);
p21.LineWidth = 1.5;
hold on

yyaxis right

pol_p = pollu(4,k);
y12 = polyval(pol_p,x1);
p22 = plot(x1,y12,'-','Color',[.8 0 0]);
p22.LineWidth = 1.5;
hold on

labelx = "\n\n" + "Absolute Julian Day";
xlabel(compose(labelx))
yyaxis left
ylabel('NO2 conc. (micrograms / cu. meters)')
yyaxis right
ylabel('O3 conc. (micrograms / cu. meters)')
headin = strcat(station{k},{' - '},'NO2 and O3 Trends');
title(headin);

legend([p21 p22],'NO2','O3');
saveas(gcf,strcat(station{k},'_NO2_O3.jpeg'));
hold off


%no vs co--------------------------------------------------------------
figure('units','normalized','outerposition',[0 0 1 1])
yyaxis left

y0 = [0 c(3,5)*1.2];
%season cutoffs
%winter 0-59; spring 59-120; summer 120-181; monsoon 181-258; 
%autumn 258-319; fall 319-365;
y00 = int16(y0(2));
r1 = rectangle('Position',[0 0 59 y00]);
r1.FaceColor = 0.85*[.8 .8 1];
r1.EdgeColor = 0.85*[.8 .8 1];
t = text(10,y0(2) - y0(2)/20,'Winter','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);

r2 = rectangle('Position',[59 0 120-59 y00]);
r2.FaceColor = 0.9*0.8*[.8 .8 1] + 0.9*0.2*[.8 1 .8];
r2.EdgeColor = 0.9*0.8*[.8 .8 1] + 0.9*0.2*[.8 1 .8];
t = text(59+10,y0(2) - y0(2)/20,'Spring','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);

r3 = rectangle('Position',[120 0 181-120 y00]);
r3.FaceColor = 0.6*[.8 .8 1] + 0.4*[.8 1 .8];
r3.EdgeColor = 0.6*[.8 .8 1] + 0.4*[.8 1 .8];
t = text(120+10,y0(2) - y0(2)/20,'Summer','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);

r4 = rectangle('Position',[181 0 258-181 y00]);
r4.FaceColor = 0.4*[.8 .8 1] + 0.6*[.8 1 .8];
r4.EdgeColor = 0.4*[.8 .8 1] + 0.6*[.8 1 .8];
t = text(181+10,y0(2) - y0(2)/20,'Monsoon','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);

r5 = rectangle('Position',[258 0 319-258 y00]);
r5.FaceColor = 0.9*0.2*[.8 .8 1] + 0.9*0.8*[.8 1 .8];
r5.EdgeColor = 0.9*0.2*[.8 .8 1] + 0.9*0.8*[.8 1 .8];
t = text(258+10,y0(2) - y0(2)/20,'Autumn','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);

r6 = rectangle('Position',[319 0 365-319 y00]);
r6.FaceColor = 0.85*[.8 1 .8];
r6.EdgeColor = 0.85*[.8 1 .8];
t = text(319+10,y0(2) - y0(2)/20,'Fall','HorizontalAlignment','left','Color',[.4 .4 .4],'FontSize',10);
%month cutoffs

for m = 1:12
        x0 = [monthval(m) monthval(m)];
       
            line(x0, y0,'Color',[.6 .6 .6]);

       
            t = text(monthval(m),y0(1) - y0(2)/11,month(m,:),'HorizontalAlignment','left','FontSize',10);
       
        set(t,'Rotation',90);
    hold on
end


x = linspace(1,365);
yyaxis left
y=c(3,1)+0*x;
l1 = plot(x,y,':','color',0.9*[0.2 0.2 1]);
text(366,c(3,1),'Good (NO2)','HorizontalAlignment','left','color',[0.2 0.2 0.7]);
l1.LineWidth = 1.3;
hold on


y=c(3,2)+0*x;
l2 = plot(x,y,':','color',0.8*[0.2 0.2 1]);
text(366,c(3,2),'Satisfactory (NO2)','HorizontalAlignment','left','color',[0.2 0.2 0.7]);
l2.LineWidth = 1.3;
hold on

y=c(3,3)+0*x;
l3 = plot(x,y,':','color',0.7*[0.2 0.2 1]);
text(366,c(3,3),'Moderate (NO2)','HorizontalAlignment','left','color',[0.2 0.2 0.7]);
l3.LineWidth = 1.3;
hold on


y=c(3,4)+0*x;
l4 = plot(x,y,':','color',0.6*[0.2 0.2 1]);
text(366,c(3,4),'Poor (NO2)','HorizontalAlignment','left','color',[0.2 0.2 0.7]);
l4.LineWidth = 1.3;
hold on


y=c(3,5)+0*x;
l5 = plot(x,y,':','color',0.5*[0.2 0.2 1]);
text(366,c(3,5),'Very Poor (NO2)','HorizontalAlignment','left','color',[0.2 0.2 0.7]);
l5.LineWidth = 1.3;
hold on


yyaxis right
y=c(2,1)+0*x;
l1 = plot(x,y,':','color',0.9*[1 0.2 0.2]);
text(366,c(2,1),'Good (CO)','HorizontalAlignment','left','color',[0.7 0.2 0.2]);
l1.LineWidth = 1.3;
hold on


y=c(2,2)+0*x;
l2 = plot(x,y,':','color',0.8*[1 0.2 0.2]);
text(366,c(2,2),'Satisfactory (CO)','HorizontalAlignment','left','color',[0.7 0.2 0.2]);
l2.LineWidth = 1.3;
hold on

y=c(2,3)+0*x;
l3 = plot(x,y,':','color',0.7*[1 0.2 0.2]);
text(366,c(2,3),'Moderate (CO)','HorizontalAlignment','left','color',[0.7 0.2 0.2]);
l3.LineWidth = 1.3;
hold on



yyaxis left

p21 = plot(x1,y11,'-','Color',[0 0 .8]);
p21.LineWidth = 1.5;
hold on

yyaxis right

pol_p = pollu(2,k);
y13 = polyval(pol_p,x1);
p32 = plot(x1,y13,'-','Color',[.8 0 0]);
p32.LineWidth = 1.5;
hold on

labelx = "\n\n" + "Absolute Julian Day";
xlabel(compose(labelx))
yyaxis left
ylabel('NO2 conc. (micrograms / cu. meters)')
yyaxis right
ylabel('CO conc. (micrograms / cu. meters)')
headin = strcat(station{k},{' - '},'NO2 and CO Trends');
title(headin);

legend([p21 p22],'NO2','CO');
saveas(gcf,strcat(station{k},'_NO2_CO.jpeg'));
hold off


%no2 corr----------------------------------------------
%O3
figure('units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1);
covar =  cov(y11,y12);
scatter(y11,y12,5,'filled','MarkerFaceColor',[0.1 0.6 0.1]); 
hold on; 
poline = polyfit(y11,y12,1); 
y3 = polyval(poline,y11); 

hold on

make_ellipse (y11,y12);
%rsq = r(y11,y12,y3);
% Set the axis labels
hXLabel = xlabel('NO2 concentration (micro. g / cu. m)');
hYLabel = ylabel('O3 concentration (micro. g / cu. m)');
    
correl = covar(2,1)/sqrt(covar(1,1)*covar(2,2));
legend('Reading','Error Ellipse') 
title(strcat(station{k},{' '},'NO2 vs O3',{' '},'(Correlation =',{' '},num2str(correl),')'));

hold off


%CO
subplot(1,2,2);

covar =  cov(y11,y13);
scatter(y11,y13,5,'filled','MarkerFaceColor',[0.1 0.6 0.1]); 
hold on; 
poline = polyfit(y11,y13,1); 
y3 = polyval(poline,y11); 

hold on

make_ellipse (y11,y13);
%rsq = r(y11,y12,y3);
% Set the axis labels
hXLabel = xlabel('NO2 concentration (micro. g / cu. m)');
hYLabel = ylabel('CO concentration (micro. g / cu. m)');
    
correl = covar(2,1)/sqrt(covar(1,1)*covar(2,2));
legend('Reading','Error Ellipse') 
title(strcat(station{k},{' '},'NO2 vs CO',{' '},'(Correlation =',{' '},num2str(correl),')'));

saveas(gcf,strcat(station{k},'_NO2_corr.jpeg'));


%{
y=c(4,5)+0*x;
l5 = plot(x,y,'-','color',[0.1 0.1 0.1]);
text(370,c(z,5),'Very Poor','HorizontalAlignment','left','color',[0.2 0.2 0.2]);
l5.LineWidth = 1.3;
hold on
%}





%covarience and corelation---------------------------------------------
%temp



%
figure('units','normalized','outerposition',[0 0 1 1])

subplot(2,2,1)
%pm2.5
x2 = polyval(pollu(1,k),x1);
y2 = met_avg(:,2);
covar =  cov(x2,y2);
scatter(log(x2),y2,5,'filled','MarkerFaceColor',[0.1 0.6 0.1]); hold on; poline = polyfit(log(x2)',y2,1); y3 = polyval(poline,log(x2)); pq = plot(log(x2),y3,'color',[0.1 0.1 0.6]); pq.LineWidth = 1.3;

hold on
make_ellipse (log(x2),y2);rsq = r(log(x2),y2,y3');
% Set the axis labels
hXLabel = xlabel('log(x) [x = PM2.5 concentration (micro. g / cu. m)]');
hYLabel = ylabel('Temp. (Deg. C)');
    
correl = covar(2,1)/sqrt(covar(1,1)*covar(2,2));
legend('Reading','Relation','Error Ellipse') 
title(strcat(station{k},{' '},'Temp. vs PM2.5',{' '},'(Correlation =',{' '},num2str(correl),', R sq. =',{' '},num2str(rsq),')'));

%temp
subplot(2,2,2)
%co
x2 = polyval(pollu(2,k),x1);
y2 = met_avg(:,2);
covar =  cov(x2,y2);
scatter(log(x2),y2,5,'filled','MarkerFaceColor',[0.1 0.6 0.1]); hold on; poline = polyfit(log(x2)',y2,1); y3 = polyval(poline,log(x2)); pq = plot(log(x2),y3,'color',[0.1 0.1 0.6]); pq.LineWidth = 1.3;
hold on
make_ellipse (log(x2),y2);rsq = r(log(x2),y2,y3');

% Set the axis labels
hXLabel = xlabel('log(x) [x = CO concentration (micro. g / cu. m)]');
hYLabel = ylabel('Temp. (Deg. C)');
    
correl = covar(2,1)/sqrt(covar(1,1)*covar(2,2));
legend('Reading','Relation','Error Ellipse') 
title(strcat(station{k},{' '},'Temp. vs CO',{' '},'(Correlation =',{' '},num2str(correl),', R sq. =',{' '},num2str(rsq),')'));

%temp
subplot(2,2,3)
%no2
x2 = polyval(pollu(3,k),x1);
y2 = met_avg(:,2);
covar =  cov(x2,y2);
scatter(log(x2),y2,5,'filled','MarkerFaceColor',[0.1 0.6 0.1]); hold on; poline = polyfit(log(x2)',y2,1); y3 = polyval(poline,log(x2)); pq = plot(log(x2),y3,'color',[0.1 0.1 0.6]); pq.LineWidth = 1.3;
hold on
make_ellipse (log(x2),y2);rsq = r(log(x2),y2,y3');

% Set the axis labels
hXLabel = xlabel('log(x) [x = NO2 concentration (micro. g / cu. m)]');
hYLabel = ylabel('Temp. (Deg. C)');
    
correl = covar(2,1)/sqrt(covar(1,1)*covar(2,2));
legend('Reading','Relation','Error Ellipse') 
title(strcat(station{k},{' '},'Temp. vs NO2',{' '},'(Correlation =',{' '},num2str(correl),', R sq. =',{' '},num2str(rsq),')'));

%temp
subplot(2,2,4)
%o3
x2 = polyval(pollu(4,k),x1);
y2 = met_avg(:,2);
covar =  cov(x2,y2);
scatter(log(x2),y2,5,'filled','MarkerFaceColor',[0.1 0.6 0.1]); hold on; poline = polyfit(log(x2)',y2,1); y3 = polyval(poline,log(x2)); pq = plot(log(x2),y3,'color',[0.1 0.1 0.6]); pq.LineWidth = 1.3;
hold on
make_ellipse (log(x2),y2);rsq = r(log(x2),y2,y3');

% Set the axis labels
hXLabel = xlabel('log(x) [x = O3 concentration (micro. g / cu. m)]');
hYLabel = ylabel('Temp. (Deg. C)');
    
correl = covar(2,1)/sqrt(covar(1,1)*covar(2,2));
legend('Reading','Relation','Error Ellipse') 
title(strcat(station{k},{' '},'Temp. vs O3',{' '},'(Correlation =',{' '},num2str(correl),', R sq. =',{' '},num2str(rsq),')'));
saveas(gcf,strcat(station{k},'_','Temp Correlation lognormal.jpeg'));
hold off

%SR---------------------------------------------------------------
figure('units','normalized','outerposition',[0 0 1 1])

subplot(2,2,1)
%pm2.5
x2 = polyval(pollu(1,k),x1);
y2 = met_avg(:,3);
covar =  cov(x2,y2);
scatter(log(x2),y2,5,'filled','MarkerFaceColor',[0.1 0.6 0.1]); hold on; poline = polyfit(log(x2)',y2,1); y3 = polyval(poline,log(x2)); pq = plot(log(x2),y3,'color',[0.1 0.1 0.6]); pq.LineWidth = 1.3;
hold on
make_ellipse (log(x2),y2);rsq = r(log(x2),y2,y3');

% Set the axis labels
hXLabel = xlabel('log(x) [x = PM2.5 concentration (micro. g / cu. m)]');
hYLabel = ylabel('Solar Radiation (MJ/sq. m)');
    
correl = covar(2,1)/sqrt(covar(1,1)*covar(2,2));
legend('Reading','Relation','Error Ellipse') 
title(strcat(station{k},{' '},'Solar Radiation vs PM2.5',{' '},'(Correlation =',{' '},num2str(correl),', R sq. =',{' '},num2str(rsq),')'));

%sr
subplot(2,2,2)
%co
x2 = polyval(pollu(2,k),x1);
y2 = met_avg(:,3);
covar =  cov(x2,y2);
scatter(log(x2),y2,5,'filled','MarkerFaceColor',[0.1 0.6 0.1]); hold on; poline = polyfit(log(x2)',y2,1); y3 = polyval(poline,log(x2)); pq = plot(log(x2),y3,'color',[0.1 0.1 0.6]); pq.LineWidth = 1.3;
hold on
make_ellipse (log(x2),y2);rsq = r(log(x2),y2,y3');

% Set the axis labels
hXLabel = xlabel('log(x) [x = CO concentration (micro. g / cu. m)]');
hYLabel = ylabel('Solar Radiation (MJ/sq. m)');
    
correl = covar(2,1)/sqrt(covar(1,1)*covar(2,2));legend('Reading','Relation','Error Ellipse') 
title(strcat(station{k},{' '},'Solar Radiation vs CO',{' '},'(Correlation =',{' '},num2str(correl),', R sq. =',{' '},num2str(rsq),')'));

%sr
subplot(2,2,3)
%no2
x2 = polyval(pollu(3,k),x1);
y2 = met_avg(:,3);
covar =  cov(x2,y2);
scatter(log(x2),y2,5,'filled','MarkerFaceColor',[0.1 0.6 0.1]); hold on; poline = polyfit(log(x2)',y2,1); y3 = polyval(poline,log(x2)); pq = plot(log(x2),y3,'color',[0.1 0.1 0.6]); pq.LineWidth = 1.3;
hold on
make_ellipse (log(x2),y2);rsq = r(log(x2),y2,y3');

% Set the axis labels
hXLabel = xlabel('log(x) [x = NO2 concentration (micro. g / cu. m)]');
hYLabel = ylabel('Solar Radiation (MJ/sq. m)');
    
correl = covar(2,1)/sqrt(covar(1,1)*covar(2,2));legend('Reading','Relation','Error Ellipse') 
title(strcat(station{k},{' '},'Solar Radiation vs NO2',{' '},'(Correlation =',{' '},num2str(correl),', R sq. =',{' '},num2str(rsq),')'));

%sr
subplot(2,2,4)
%o3
x2 = polyval(pollu(4,k),x1);
y2 = met_avg(:,3);
covar =  cov(x2,y2);
scatter(log(x2),y2,5,'filled','MarkerFaceColor',[0.1 0.6 0.1]); hold on; poline = polyfit(log(x2)',y2,1); y3 = polyval(poline,log(x2)); pq = plot(log(x2),y3,'color',[0.1 0.1 0.6]); pq.LineWidth = 1.3;
hold on
make_ellipse (log(x2),y2);rsq = r(log(x2),y2,y3');

% Set the axis labels
hXLabel = xlabel('log(x) [x = O3 concentration (micro. g / cu. m)]');
hYLabel = ylabel('Solar Radiation (MJ/sq. m)');
    
correl = covar(2,1)/sqrt(covar(1,1)*covar(2,2));legend('Reading','Relation','Error Ellipse') 
title(strcat(station{k},{' '},'Solar Radiation vs O3',{' '},'(Correlation =',{' '},num2str(correl),', R sq. =',{' '},num2str(rsq),')'));
saveas(gcf,strcat(station{k},'_','SR Correlation lognormal.jpeg'));
hold off

%rh---------------------------------------------------------------

figure('units','normalized','outerposition',[0 0 1 1])

subplot(2,2,1)
%pm2.5
x2 = polyval(pollu(1,k),x1);
y2 = met_avg(:,4);
covar =  cov(x2,y2);
scatter(log(x2),y2,5,'filled','MarkerFaceColor',[0.1 0.6 0.1]); hold on; poline = polyfit(log(x2)',y2,1); y3 = polyval(poline,log(x2)); pq = plot(log(x2),y3,'color',[0.1 0.1 0.6]); pq.LineWidth = 1.3;
hold on
make_ellipse (log(x2),y2);rsq = r(log(x2),y2,y3');

% Set the axis labels
hXLabel = xlabel('log(x) [x = PM2.5 concentration (micro. g / cu. m)]');
hYLabel = ylabel('Relative Humidity (fraction)');
    
correl = covar(2,1)/sqrt(covar(1,1)*covar(2,2));legend('Reading','Relation','Error Ellipse') 
title(strcat(station{k},{' '},'Relative Humidity vs PM2.5',{' '},'(Correlation =',{' '},num2str(correl),', R sq. =',{' '},num2str(rsq),')'));

%sr
subplot(2,2,2)
%co
x2 = polyval(pollu(2,k),x1);
y2 = met_avg(:,4);
covar =  cov(x2,y2);
scatter(log(x2),y2,5,'filled','MarkerFaceColor',[0.1 0.6 0.1]); hold on; poline = polyfit(log(x2)',y2,1); y3 = polyval(poline,log(x2)); pq = plot(log(x2),y3,'color',[0.1 0.1 0.6]); pq.LineWidth = 1.3;
hold on
make_ellipse (log(x2),y2);rsq = r(log(x2),y2,y3');

% Set the axis labels
hXLabel = xlabel('log(x) [x = CO concentration (micro. g / cu. m)]');
hYLabel = ylabel('Relative Humidity (fraction)');
    
correl = covar(2,1)/sqrt(covar(1,1)*covar(2,2));legend('Reading','Relation','Error Ellipse') 
title(strcat(station{k},{' '},'Relative Humidity vs CO',{' '},'(Correlation =',{' '},num2str(correl),', R sq. =',{' '},num2str(rsq),')'));

%sr
subplot(2,2,3)
%no2
x2 = polyval(pollu(3,k),x1);
y2 = met_avg(:,4);
covar =  cov(x2,y2);
scatter(log(x2),y2,5,'filled','MarkerFaceColor',[0.1 0.6 0.1]); hold on; poline = polyfit(log(x2)',y2,1); y3 = polyval(poline,log(x2)); pq = plot(log(x2),y3,'color',[0.1 0.1 0.6]); pq.LineWidth = 1.3;
hold on
make_ellipse (log(x2),y2);rsq = r(log(x2),y2,y3');

% Set the axis labels
hXLabel = xlabel('log(x) [x = NO2 concentration (micro. g / cu. m)]');
hYLabel = ylabel('Relative Humidity (fraction)');
    
correl = covar(2,1)/sqrt(covar(1,1)*covar(2,2));legend('Reading','Relation','Error Ellipse') 
title(strcat(station{k},{' '},'Relative Humidity vs NO2',{' '},'(Correlation =',{' '},num2str(correl),', R sq. =',{' '},num2str(rsq),')'));

%sr
subplot(2,2,4)
%o3
x2 = polyval(pollu(4,k),x1);
y2 = met_avg(:,4);
covar =  cov(x2,y2);
scatter(log(x2),y2,5,'filled','MarkerFaceColor',[0.1 0.6 0.1]); hold on; poline = polyfit(log(x2)',y2,1); y3 = polyval(poline,log(x2)); pq = plot(log(x2),y3,'color',[0.1 0.1 0.6]); pq.LineWidth = 1.3;
hold on
make_ellipse (log(x2),y2);rsq = r(log(x2),y2,y3');

% Set the axis labels
hXLabel = xlabel('log(x) [x = O3 concentration (micro. g / cu. m)]');
hYLabel = ylabel('Relative Humidity (fraction)');
    
correl = covar(2,1)/sqrt(covar(1,1)*covar(2,2));legend('Reading','Relation','Error Ellipse') 
title(strcat(station{k},{' '},'Relative Humidity vs O3',{' '},'(Correlation =',{' '},num2str(correl),', R sq. =',{' '},num2str(rsq),')'));
saveas(gcf,strcat(station{k},'_','RH Correlation lognormal.jpeg'));
hold off

%precipitation---------------------------------------------------------

figure('units','normalized','outerposition',[0 0 1 1])

subplot(2,2,1)
%pm2.5
x2 = polyval(pollu(1,k),x1);
y2 = met_avg(:,5);
covar =  cov(x2,y2);
scatter(log(x2),y2,5,'filled','MarkerFaceColor',[0.1 0.6 0.1]); hold on; poline = polyfit(log(x2)',y2,1); y3 = polyval(poline,log(x2)); pq = plot(log(x2),y3,'color',[0.1 0.1 0.6]); pq.LineWidth = 1.3;
hold on
make_ellipse (log(x2),y2);rsq = r(log(x2),y2,y3');

% Set the axis labels
hXLabel = xlabel('log(x) [x = PM2.5 concentration (micro. g / cu. m)]');
hYLabel = ylabel('Precipitation (mm)');
    
correl = covar(2,1)/sqrt(covar(1,1)*covar(2,2));legend('Reading','Relation','Error Ellipse') 
title(strcat(station{k},{' '},'Precipitation vs PM2.5',{' '},'(Correlation =',{' '},num2str(correl),', R sq. =',{' '},num2str(rsq),')'));

%sr
subplot(2,2,2)
%co
x2 = polyval(pollu(2,k),x1);
y2 = met_avg(:,5);
covar =  cov(x2,y2);
scatter(log(x2),y2,5,'filled','MarkerFaceColor',[0.1 0.6 0.1]); hold on; poline = polyfit(log(x2)',y2,1); y3 = polyval(poline,log(x2)); pq = plot(log(x2),y3,'color',[0.1 0.1 0.6]); pq.LineWidth = 1.3;
hold on
make_ellipse (log(x2),y2);rsq = r(log(x2),y2,y3');

% Set the axis labels
hXLabel = xlabel('log(x) [x = CO concentration (micro. g / cu. m)]');
hYLabel = ylabel('Precipitation (mm)');
    
correl = covar(2,1)/sqrt(covar(1,1)*covar(2,2));legend('Reading','Relation','Error Ellipse') 
title(strcat(station{k},{' '},'Precipitation vs CO',{' '},'(Correlation =',{' '},num2str(correl),', R sq. =',{' '},num2str(rsq),')'));

%sr
subplot(2,2,3)
%no2
x2 = polyval(pollu(3,k),x1);
y2 = met_avg(:,5);
covar =  cov(x2,y2);
scatter(log(x2),y2,5,'filled','MarkerFaceColor',[0.1 0.6 0.1]); hold on; poline = polyfit(log(x2)',y2,1); y3 = polyval(poline,log(x2)); pq = plot(log(x2),y3,'color',[0.1 0.1 0.6]); pq.LineWidth = 1.3;
hold on
make_ellipse (log(x2),y2);rsq = r(log(x2),y2,y3');

% Set the axis labels
hXLabel = xlabel('log(x) [x = NO2 concentration (micro. g / cu. m)]');
hYLabel = ylabel('Precipitation (mm)');
    
correl = covar(2,1)/sqrt(covar(1,1)*covar(2,2));legend('Reading','Relation','Error Ellipse') 
title(strcat(station{k},{' '},'Precipitation vs NO2',{' '},'(Correlation =',{' '},num2str(correl),', R sq. =',{' '},num2str(rsq),')'));

%sr
subplot(2,2,4)
%o3
x2 = polyval(pollu(4,k),x1);
y2 = met_avg(:,5);
covar =  cov(x2,y2);
scatter(log(x2),y2,5,'filled','MarkerFaceColor',[0.1 0.6 0.1]); hold on; poline = polyfit(log(x2)',y2,1); y3 = polyval(poline,log(x2)); pq = plot(log(x2),y3,'color',[0.1 0.1 0.6]); pq.LineWidth = 1.3;
hold on
make_ellipse (log(x2),y2);rsq = r(log(x2),y2,y3');

% Set the axis labels
hXLabel = xlabel('log(x) [x = O3 concentration (micro. g / cu. m)]');
hYLabel = ylabel('Precipitation (mm)');
    
correl = covar(2,1)/sqrt(covar(1,1)*covar(2,2));legend('Reading','Relation','Error Ellipse') 
title(strcat(station{k},{' '},'Precipitation vs O3',{' '},'(Correlation =',{' '},num2str(correl),', R sq. =',{' '},num2str(rsq),')'));
saveas(gcf,strcat(station{k},'_','Precipitation Correlation lognormal.jpeg'));
hold off
%}



end





function pol = pollu(z,k)
if z == 1
    pol=pm2(k);
elseif z == 2
    pol=co(k);
elseif z == 3
    pol=no2(k);
else
    pol=o3(k);
end
end



function r_sq = r(x,y,f)
siz = numel(x);sstot = 0;ssres = 0;
for i=1:siz
    sstot = (y(i,1) - mean(y(:,1)))^2 + sstot;
    ssres = (y(i,1) - f(i,1))^2 + ssres;
end
r_sq = 1 - ssres/sstot;

end













