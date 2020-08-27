
envmaps = ["au","co","dr","mo","ph"];
len = length(envmaps);

mask = imread("bunny/mask.jpg");
[iy ix iz] = size(mask);

a = zeros(iy,ix,iz,len);
for i = 1:len;
    a(:,:,:,i) = imread("bunny/ag/0.1",strcat(envmaps(i),".jpg"));
end

syn = zeros(iy,ix,iz,len^2);


for n = 1:len
    for m = 1:len
        syn(:,:,:,len*(n-1)+m) = a(:,:,:,n);
        for i = 1:iy
            for j = 1:ix
                if mask(i,j,1) ~= 0
                    syn(i,j,:,len*(n-1)+m) = a(i,j,:,m);
                end
            end
        end
        disp(len*(n-1)+m);
    end
end

montage(syn/255);
save("syn.mat","syn");