
% envmaps = ["au","bl","co","dr","le","ly","me","mo","no","ph","sn"];
envmaps = ["au","bl","co"]
len = length(envmaps);

mask = imread("../images/bunny/mask/au.jpg");
[iy ix iz] = size(mask);

masks = zeros(iy,ix,iz,len);
for i = 1:len
    masks(:,:,:,i) = imread(strcat("../render/image/mask/",envmaps(i),".jpg"));
end

pics = zeros(iy,ix,iz,len);
for i = 1:len
    pics(:,:,:,i) = imread(strcat("../render/image/",envmaps(i),".jpg"));
end

cmps = zeros(iy,ix,iz);
check = zeros(iy,ix);
r1 = randi(2);
r2 = 2 - r1;
blackThr = 5;
semiBlackThr = 160;

% srr = [-1 0 1 -1 1 -1 -0 1; 1 1 1 0 0 -1 -1 -1];
srr = [0 -1 1 0 -1 1 -1 1; 1 0 0 -1 1 1 -1 -1];

comb = combnk(1:len,2);

% for n = 1:len
for n = 2:2
%     for m = 1:nchoosek(len,2)
    for m = 2:3
        lr = randi(2);
        
        for ptn = 1:2
            cmps(:,:,:) = masks(:,:,:,n);
            check = zeros(iy,ix);
            
            if ptn == 1
                indexl = comb(m,lr);
                indexr = comb(m,3-lr);
            else
                indexl = comb(m,3-lr);
                indexr = comb(m,lr);
            end
            
            for i = 480 : 770
                for j = 540 : 1000
                    if masks(i,j,1,n) <= blackThr
                        cmps(i,j,:) = pics(i,j,:,indexl);
                        check(i,j) = 1;
                        for k = 1:8
                            if check(i+srr(1,k),j+srr(2,k)) == 0
                                if k <= 4
                                    cmps(i+srr(1,k),j+srr(2,k),:) = pics(i+srr(1,k),j+srr(2,k),:,indexl);
                                    check(i+srr(1,k),j+srr(2,k)) = 1;
                                else
                                    if check(i+srr(1,k),j+srr(2,k)) == 0
                                        cmps(i+srr(1,k),j+srr(2,k),:) = (pics(i+srr(1,k),j+srr(2,k),:,indexl)+masks(i+srr(1,k)*2,j+srr(2,k)*2,:,n))/2;
                                    end
                                end
                            end
                        end
                    end
                end
            end
            disp((nchoosek(len,2)-1)*(n-1)+m);
            imshow(cmps/255);
            save(strcat("../stimuli/pattern",num2str(ptn),"/bunny/ag/0.01/ba01_",num2str(n),"_",num2str(m),".mat"),"cmps");
        end
    end
end

% imshow(syn(:,:,:,2)/255);
% save("syn.mat","syn");