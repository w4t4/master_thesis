p = 7;
l = hdrread(strcat("../envmap/",hdrs(p)));
r = hdrread(strcat("../normalizedEnvmap/",hdrs(p)));
lrgb = tonemap(l);
rrgb = tonemap(r);
montage({lrgb, rrgb});