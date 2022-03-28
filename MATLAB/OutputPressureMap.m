% This will only run on the laptop where the appropriate support package is
% installed

clear all
x`;
cycles = 200000;

for n = 1 : cycles

    writeDigitalPin(ard,'D52',1);
    a = readVoltage(ard,'A8');
    b = readVoltage(ard,'A9');
    c = readVoltage(ard,'A10');
    d = readVoltage(ard,'A11');
    Pressuremap(1,:) = [a b c d];
    writeDigitalPin(ard,'D52',0);

    writeDigitalPin(ard,'D50',1);
    a = readVoltage(ard,'A8');
    b = readVoltage(ard,'A9');
    c = readVoltage(ard,'A10');
    d = readVoltage(ard,'A11');
    Pressuremap(2,:) = [a b c d];
    writeDigitalPin(ard,'D50',0);

    writeDigitalPin(ard,'D48',1);
    a = readVoltage(ard,'A8');
    b = readVoltage(ard,'A9');
    c = readVoltage(ard,'A10');
    d = readVoltage(ard,'A11');
    Pressuremap(3,:) = [a b c d];
    writeDigitalPin(ard,'D48',0);

    writeDigitalPin(ard,'D46',1);
    a = readVoltage(ard,'A8');
    b = readVoltage(ard,'A9');
    c = readVoltage(ard,'A10');
    d = readVoltage(ard,'A11');
    Pressuremap(4,:) = [a b c d];
    writeDigitalPin(ard,'D46',0);

    %Pressuremap
    heatmap(Pressuremap,'Colormap',summer)
    caxis([0, 3]);
    drawnow
end


