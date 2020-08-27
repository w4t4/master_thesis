p = imread("mask.jpg");
a = imread("ph.jpg");
[iy ix iz] = size(p);
for i = 1:iy
    for j = 1:ix
        if p(i,j,1) > 10
            a(i,j,:) = [0 0 0];
        end
    end
end

imshow(a)
