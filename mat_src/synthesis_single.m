
envmaps = ["au","co","dr","mo","ph"];

mask = imread("bunny/mask3.jpg");
[iy ix iz] = size(mask);

a = zeros(iy,ix,iz);
a(:,:,:) = imread("bunny/ag/f/dr.jpg");

s = zeros(iy,ix,iz);
s(:,:,:) = imread("bunny/ag/f/mo.jpg");


for i = 1:iy
    for j = 1:ix
        if mask(i,j,1) > 10
            s(i,j,:) = a(i,j,:);
        end
    end
end

imshow(s(:,:,:)/255);