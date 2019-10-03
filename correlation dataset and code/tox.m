function [a_co, a_no2, a_o3] = tox()

%toxicity table pm2.5 co no2 o3
c = [30, 60, 90, 120, 250; 
    1000, 2000, 10000, 17000, 34000; 
    40, 80, 180, 280, 400; 
    50, 100, 168, 208, 748];


a_co = c(1,:)'\c(2,:)'
a_no2 = c(1,:)'\c(3,:)'
a_o3 = c(1,:)'\c(4,:)'
rate = {'Good';'Satisfactory';'Moderate';'Poor';'Very Poor'};


figure('units','normalized','outerposition',[0 0 1 1])
subplot(2,2,1)
y0 = [0 1.5 * max(c(2,:))];

for m = 1:5
        x0 = [c(1,m) c(1,m)];
       
            line(x0, y0,'Color',[.4 .4 .4]);

       
            t = text(c(1,m)+3,y0(1) + y0(2)/1.3,rate{m},'HorizontalAlignment','left','FontSize',8);
       set(t,'Rotation',90);
            hold on
end


x1 = 0:320;
%y1 = polyval(pol_co,x1);
p1 = plot(c(1,:),c(2,:),'-o','Color',[0.2 0.6 0.2]);
p1.LineWidth = 1.5;
hold on
p2 = plot(x1,a_co*x1,'-','Color',[0.2 0.2 0.6]);
p2.LineWidth = 1.5;

xlabel('Conc. of Pm2.5 (micro. g / cu. m)')
ylabel('Conc. of CO (micro. g / cu. m)')
legend([p1 p2],'Actualy','Approx.');
title(strcat('CO vs. pm2.5 Toxicity Relation (slope =',{' '},num2str(a_co),')'));
hold off%-------------------------------------------------------------------


subplot(2,2,2)
y0 = [0 1.5 * max(c(3,:))];

for m = 1:5
        x0 = [c(1,m) c(1,m)];
       
            line(x0, y0,'Color',[.4 .4 .4]);

       
            t = text(c(1,m)+3,y0(1) + y0(2)/1.3,rate{m},'HorizontalAlignment','left','FontSize',8);
       set(t,'Rotation',90);
            hold on
end


x1 = 0:320;
%y1 = polyval(pol_co,x1);
p1 = plot(c(1,:),c(3,:),'-o','Color',[0.2 0.6 0.2]);
p1.LineWidth = 1.5;
hold on
p2 = plot(x1,a_no2*x1,'-','Color',[0.2 0.2 0.6]);
p2.LineWidth = 1.5;

xlabel('Conc. of Pm2.5 (micro. g / cu. m)')
ylabel('Conc. of NO2 (micro. g / cu. m)')
legend([p1 p2],'Actualy','Approx.');
title(strcat('NO2 vs. pm2.5 Toxicity Relation (slope =',{' '},num2str(a_no2),')'));
hold off%-------------------------------------------------------------------

subplot(2,2,3)
y0 = [0 1.5 * max(c(4,:))];

for m = 1:5
        x0 = [c(1,m) c(1,m)];
       
            line(x0, y0,'Color',[.4 .4 .4]);

       
            t = text(c(1,m)+3,y0(1) + y0(2)/1.3,rate{m},'HorizontalAlignment','left','FontSize',8);
       set(t,'Rotation',90);
            hold on
end


x1 = 0:320;
%y1 = polyval(pol_co,x1);
p1 = plot(c(1,:),c(4,:),'-o','Color',[0.2 0.6 0.2]);
p1.LineWidth = 1.5;
hold on
p2 = plot(x1,a_o3*x1,'-','Color',[0.2 0.2 0.6]);
p2.LineWidth = 1.5;

xlabel('Conc. of Pm2.5 (micro. g / cu. m)')
ylabel('Conc. of O3 (micro. g / cu. m)')
legend([p1 p2],'Actualy','Approx.');
title(strcat('O3 vs. pm2.5 Toxicity Relation (slope =',{' '},num2str(a_o3),')'));
hold off%-------------------------------------------------------------------


saveas(gcf,'Toxicity Relation.jpeg');



%c = [40,80,180,280,400]; %edit no2
%c = [30,60,90,120,250]; %edit pm2.5
%c = [50,100,250,350,430]; %edit pm10
%c = [40,80,380,800,1600]; %edit so2
%c = [50,100,168,208,748]; %edit o3
%c = [1,2,10,17,34] * 1000; %edit co

%}

end