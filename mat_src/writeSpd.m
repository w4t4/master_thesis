fileID = fopen('blue.spd','w');

%5R 7/10, 5Y 7/12, 5G 7/10, 5B 7/8
colorIndex = [62 335 589 802];


for i = 380:800
    fprintf(fileID,'%d %.4f\n',i,munsell(i-379,colorIndex(4)));
end

fclose(fileID);