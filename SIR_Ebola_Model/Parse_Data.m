function[infect,deaths,days] = Parse_Data(num,txt)

dates = txt(:,1);
dates(1) = [];

%initial conditions
CCC = 2; %cummulative confirmed cases column number
CCD = 3; %CCD = cummulative confirmed deaths column number

[rows,columns] = size(num);

SIR = zeros(rows,3);
j = 1;
offset = 0;
for i = rows:-1:1
    
    if ( isnan(num(i,CCC)) || isnan(num(i,CCD)) )
        offset = offset + 1;
    else 
        SIR(j - offset,1) = j;
        SIR(j - offset,2) = num(i,CCC);
        SIR(j - offset,3) = num(i,CCD);
    end
    
    j = j + 1;
end

i = rows;
while (SIR(i,1) == 0)
    SIR(i,:) = [];
    i = i - 1;
end

infect = SIR(:,2) - SIR(:,3);
deaths = SIR(:,3);
days = SIR(:,1);

return;