au = hdrread("autumn_forest_01_2k.hdr");
imwrite(tonemap(au),"au.png");

co = hdrread("combination_room_2k.hdr");
imwrite(tonemap(co),"co.png");

dr = hdrread("driving_school_2k.hdr");
imwrite(tonemap(dr),"dr.png");

mo = hdrread("moonless_golf_2k.hdr");
imwrite(tonemap(mo),"mo.png");

ph = hdrread("photo_studio_01_2k.hdr");
imwrite(tonemap(ph),"ph.png");