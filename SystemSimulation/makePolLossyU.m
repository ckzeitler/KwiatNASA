function [ U ] = makePolLossyU( HT,VT,fullModeList, polMode,spatialMode,spatialModeValue )
U=zeros(size(fullModeList,1));

for i=1:size(fullModeList,1)
    if spatialMode~=0 && fullModeList(i,spatialMode)~=spatialModeValue
        U(i,i)=1;
    else
        if fullModeList(i,polMode)==0
            U(i,i)=sqrt(HT);
        else
            U(i,i)=sqrt(VT);
            
        end
    end
end
end

