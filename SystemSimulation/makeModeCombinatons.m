function [ fullModeList ] = makeModeCombinatons( qubitNumber )
fullModeList=zeros(qubitNumber,2^qubitNumber);
for j=1:2^qubitNumber
for i=1:qubitNumber
    fullModeList(i,j)=mod(j,2*i);
    
    
end

end

