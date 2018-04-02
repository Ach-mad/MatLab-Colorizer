%%Achmad Baskara
%%10/21/17
%%Black and white photo colorizer

%%Original RGB image
%%Can Change This to prompt for custom image
image = './pencil.jpg';
original_image = imread(image);
imfinfo(image)

%%Convert to black and white (lose R G B layers (if any)) 
%%this will be converted to color by program
b_a_w = rgb2gray(original_image);

%Display original B&w and completed colorized
subplot(1,2, 1);
imshow(original_image);
fontSize = 10;
title('Original Image', 'FontSize', fontSize)


%Convert Greyscale into usable RGB layers
colorized = cat(3, b_a_w, b_a_w, b_a_w);

%Seperate 3 channels of gray RGB image
b_1 = colorized(:,:,1); % Red channel
b_2 = colorized(:,:,2); % Green channel
b_3 = colorized(:,:,3); %Blue channel

%read csv file with red,green,blue; min, max, avg
mRed = csvread('minmaxRED.csv');
mGreen = csvread('minmaxGREEN.csv');
mBlue = csvread('minmaxBLUE.csv');

rng(0,'twister');
avg = mean(mean(mean(original_image)))
avRed=mean(mean(mean(mRed)))
avGreen=mean(mean(mean(mGreen)))
avBlue=mean(mean(mean(mBlue)))
for j=0:255
        %Go through each element of gray image and colorize
        for i=1:numel(b_a_w)
            if b_a_w(i) == j;
                
                b_1(i)  = (mRed(j+1,3)+(mRed(j+1,4)/avRed)*randi([0,mRed(j+1,2)]))+(avRed/4);      %red value
                b_2(i)  = mGreen(j+1,3)+(mGreen(j+1,4)/avGreen)*randi([0,mGreen(j+1,2)])+(avGreen/4);     %green value
                b_3(i)  = (mBlue(j+1,3)+(mBlue(j+1,4)/avBlue)*randi([0,mBlue(j+1,2)]))-(avBlue/4);     %blue value
               
            end
            
        end
end 


%remove the noise

b_1 = medfilt2(b_1);
b_2 = medfilt2(b_2);
b_3 = medfilt2(b_3);


%combinme the red,blue,green channels to one image
colorized = cat(3, b_1, b_2, b_3);


%display the colorized image
subplot(1,2, 2);
imshow(colorized);
title('Colorized', 'FontSize', fontSize)
clear
