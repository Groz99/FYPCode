% Script to attempt data logging function using MATLAB
clear all


% For stuck unavailable condition
%fclose(instrfindall);
%delete(instrfindall);

%COM5 is the right USB port on RB laptop
ser = serial('COM5');
set(ser,'BaudRate',9600);
fopen(ser);

nsamples = 1000;
datasave = cell(1000,1);
tic
for n = 1 : nsamples
    readard = fscanf(ser);
    %dataparse = split(readard,',');
    datasave{n} = readard;
end    

toc
disp(['Time taken: ' num2str(toc)])
csvwrite('testlog.csv', datasave)
fclose(ser);