function [ matrix ] = LCRot(phase,rotation)

matrix=[cosd(rotation) sind(rotation);-sind(rotation) cosd(rotation)]*[1 0;0 exp(1i*phase)]*[cosd(rotation) -sind(rotation);sind(rotation) cosd(rotation)];
end

