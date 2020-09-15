
envmaps = ["au","bl","co","dr","le","ly","me","mo","no","ph","sn"];
len = length(envmaps);

mask = imread("../images/bunny/mask/au.jpg");
[iy ix iz] = size(mask);

masks = zeros(iy,ix,iz,len);
for i = 1:len
    masks(:,:,:,i) = imread(strcat("../images/bunny/mask/",envmaps(i),".jpg"));
end

pics = zeros(iy,ix,iz,len);
for i = 1:len
    pics(:,:,:,i) = imread(strcat("../images/bunny/ag/0.01/",envmaps(i),".jpg"));
end

cmps = zeros(iy,ix,iz);
check = zeros(iy,ix);
r1 = randi(2);
r2 = 2 - r1;
blackThr = 5;
semiBlackThr = 160;

% srr = [-1 0 1 -1 1 -1 -0 1; 1 1 1 0 0 -1 -1 -1];
srr = [0 -1 1 0 -1 1 -1 1; 1 0 0 -1 1 1 -1 -1];

for n = 1:len
    for m = 1:len
        cmps(:,:,:) = masks(:,:,:,n);
        check = zeros(iy,ix);
        for i = 480 : 770
            for j = 330 : 540
                if masks(i,j,1,n) <= blackThr
                    cmps(i,j,:) = pics(i,j,:,m);
%                     cmps(i,j,:) = [255,255,255];
                    check(i,j) = 1;
                    for k = 1:8
                        if check(i+srr(1,k),j+srr(2,k)) == 0
                            if k <= 4
                                cmps(i+srr(1,k),j+srr(2,k),:) = pics(i+srr(1,k),j+srr(2,k),:,m);
%                                 cmps(i+srr(1,k),j+srr(2,k),:) = [255,0,0];
                                check(i+srr(1,k),j+srr(2,k)) = 1;
                            else
                                if check(i+srr(1,k),j+srr(2,k)) == 0
                                    cmps(i+srr(1,k),j+srr(2,k),:) = (pics(i+srr(1,k),j+srr(2,k),:,m)+masks(i+srr(1,k)*2,j+srr(2,k)*2,:,n))/2;
%                                     cmps(i+srr(1,k),j+srr(2,k),:) = [0,255,0];
                                end
                            end
                        end
                    end
                end
            end
        end
        for i = 480 : 700
            for j = 920 : 1100
                if masks(i,j,1,n) <= blackThr
                    cmps(i,j,:) = pics(i,j,:,len+1-m);
%                     cmps(i,j,:) = [255,255,255];
                    check(i,j) = 1;
                    for k = 1:8
                        if check(i+srr(1,k),j+srr(2,k)) == 0
                            if k <= 4
                                cmps(i+srr(1,k),j+srr(2,k),:) = pics(i+srr(1,k),j+srr(2,k),:,len+1-m);
%                                 cmps(i+srr(1,k),j+srr(2,k),:) = [255,0,0];
                                check(i+srr(1,k),j+srr(2,k)) = 1;
                            else
                                if check(i+srr(1,k),j+srr(2,k)) == 0
                                    cmps(i+srr(1,k),j+srr(2,k),:) = (pics(i+srr(1,k),j+srr(2,k),:,len+1-m)+masks(i+srr(1,k)*2,j+srr(2,k)*2,:,n))/2;
%                                     cmps(i+srr(1,k),j+srr(2,k),:) = [0,255,0];
                                end
                            end
                        end
                    end
                end
            end
        end
        disp(len*(n-1)+m);
        imshow(cmps/255);
        save(strcat("../stimuli/bunny/ag/0.01/ba01_",num2str(n),"_",num2str(m),".mat"),"cmps");
    end
end

% imshow(syn(:,:,:,2)/255);
% save("syn.mat","syn");