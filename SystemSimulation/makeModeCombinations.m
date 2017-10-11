function [ fullModeList ] = makeModeCombinations( qubitNumber )
%works for qubitnumber from 1 to 15
qubitNumber=uint16(qubitNumber);
fullModeList=zeros(2^qubitNumber,qubitNumber);
for j=1:2^qubitNumber
for i=1:qubitNumber
    tempJ=uint16(j);
    tempI=uint16(i);
    fullModeList(j,i)=bitshift(bitshift(tempJ-1,15-qubitNumber+tempI),-15);
end

end

