file_names = {'Delhi','Banglore','Chennai','Colombo','Dhaka','Kanpur','Kathmandu','Lahore'};
citycode = 1;
year = 1997;
%met_data(file_names{citycode},year);

for i = 1:8
    for j = 2005:2014
        met_data(file_names{i},j);
    end
end
