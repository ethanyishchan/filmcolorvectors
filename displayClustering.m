numCat1 = sum((idx == 1));
numCat2 = sum((idx == 2));

currentCounter = 1;
for i = 1:numCat1
    while(idx(currentCounter) ~= 1)
        currentCounter = currentCounter + 1;
    end
    imgName = (strcat(cellstr(movieNames(currentCounter)),'.png'));
    img = imread(imgName{1});
    subplot(3, 4, i);
    imshow(img);
    title(movieNames(currentCounter));
    currentCounter = currentCounter + 1;
end

figure;
currentCounter = 1;
for i = 1:numCat2
    while(idx(currentCounter) ~= 2)
        currentCounter = currentCounter + 1;
    end
    imgName = (strcat(cellstr(movieNames(currentCounter)),'.png'));
    img = imread(imgName{1});
    subplot(3, 4, i);
    imshow(img);
    title(movieNames(currentCounter));
    currentCounter = currentCounter + 1;
end