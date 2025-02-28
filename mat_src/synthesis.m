
envmaps = ["au","co","dr","ha","le","ly","me","mo","no","ph","pr","sn"];
% envmaps = ["au","bl","co","dr","mo"]
len = length(envmaps);
color = "yellow";

mask = imread("../render/image/mask/raw/au.png");
[iy ix iz] = size(mask);

masks = zeros(iy,ix,iz,len);
for i = 1:len
    masks(:,:,:,i) = imread(strcat("../render/image/mask/raw/",envmaps(i),".png"));
end

pics = zeros(iy,ix,iz,len);
for i = 1:len
    pics(:,:,:,i) = imread(strcat("../render/image/plastic/raw/",color,"/",envmaps(i),".png"));
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
for n = 1:len
%     for m = 1:nchoosek(len,2)
    for m = 1:len
       
        cmps(:,:,:) = pics(:,:,:,n);
        check = zeros(iy,ix);

        for i = 400 : 700
            for j = 200 : 400
                if masks(i,j,1,n) <= blackThr
                    cmps(i,j,:) = pics(i,j,:,m);
                    check(i,j) = 1;
                    for k = 1:8
                        if check(i+srr(1,k),j+srr(2,k)) == 0
                            if k <= 4
                                cmps(i+srr(1,k),j+srr(2,k),:) = pics(i+srr(1,k),j+srr(2,k),:,m);
                                check(i+srr(1,k),j+srr(2,k)) = 1;
                            else
                                if check(i+srr(1,k),j+srr(2,k)) == 0
                                    cmps(i+srr(1,k),j+srr(2,k),:) = (pics(i+srr(1,k),j+srr(2,k),:,m)+masks(i+srr(1,k)*2,j+srr(2,k)*2,:,n))/2;
                                end
                            end
                        end
                    end
                end
            end
        end
        disp((nchoosek(len,2)-1)*(n-1)+m);
        imshow(cmps/255);
        imwrite(cmps/255,strcat("../stimuli/plastic/",color,"/",num2str(n),"_",num2str(m),".png"));
%         save(strcat("../stimuli/pattern",num2str(ptn),"/bunny/ag/0.01/ba01_",num2str(n),"_",num2str(m),".mat"),"cmps");
    end
end

% imshow(syn(:,:,:,2)/255);
% save("syn.mat","syn");