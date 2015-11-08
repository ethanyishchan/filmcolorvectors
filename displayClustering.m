directoryName = '../archive/VectorImage/';
for j = 1:k
    figure;
    currentCounter = 1;
    numCat = sum((idx == j));
    spDim = ceil(sqrt(numCat));
    for i = 1:numCat
        while(idx(currentCounter) ~= j)
            currentCounter = currentCounter + 1;
        end
        imgName = (strcat(directoryName, cellstr(movieNames(currentCounter)),'.png'));
        img = imread(imgName{1});
        subplot(spDim, spDim, i);
        imshow(img);
        title(movieNames(currentCounter));
        currentCounter = currentCounter + 1;
    end
end