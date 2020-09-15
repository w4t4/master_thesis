hdrs = ["autumn_forest_01_2k.hdr",...
    "blue_lagoon_night_2k.hdr",...
    "combination_room_2k.hdr",...
    "driving_school_2k.hdr",...
    "lenong_2_2k.hdr",...
    "lythwood_lounge_2k.hdr",...
    "mealie_road_2k.hdr",...
    "moonless_golf_2k.hdr",...
    "noon_grass_2k.hdr",...
    "photo_studio_01_2k.hdr",...
    "snowy_park_01_2k.hdr"];

C = makecform('xyz2xyl');
lumSums = zeros(1,length(hdrs));

for i = 1:length(hdrs)
    hdr = hdrread(strcat("../envmap/",hdrs(i)));
    [iy ix iz] = size(hdr);
    xyl = applycform(double(hdr),C);
    lumSums(i) = sum(sum(xyl(:,:,3)))/(iy*ix);
    if i == 9
        disp(max(max(hdr)))
    end
end

aveLumSum = sum(lumSums)/length(hdrs);
D = makecform('xyl2xyz');

for i = 1:length(hdrs)
    disp(i)
    hdr = hdrread(strcat("../envmap/",hdrs(i)));
    xyl = applycform(double(hdr),C);
    disp(aveLumSum)
    disp(sum(sum(xyl(:,:,3)))/(iy*ix));
    xyl(:,:,3) = xyl(:,:,3) * aveLumSum / (sum(sum(xyl(:,:,3)))/(iy*ix));
    nhdr = applycform(xyl,D);
    for m = 1:iy
        for n = 1:ix
            for k = 1:3
                if nhdr(m,n,k) <= 0
                    nhdr(m,n,k) = 0;
                end
            end
        end
    end
    hdrwrite(single(nhdr),strcat("../normalizedEnvmap/",hdrs(i)));
end