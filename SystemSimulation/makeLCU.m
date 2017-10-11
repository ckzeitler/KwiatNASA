function [ U ] = makeLCU( phase,rotation, fullModeList,polMode,spatialMode,spatialModeValue)
%% tested, seems to work correctly
U=zeros(size(fullModeList,1));
simpleU=LCRot(phase,rotation);
mustBeSame=ones(1,size(fullModeList,2))==1;
mustBeSame(polMode)=~mustBeSame(polMode);
for i=1:2^size(fullModeList,2);
    for j=1:2^size(fullModeList,2);
        inState=fullModeList(i,:);
        outState=fullModeList(j,:);
        if all(inState(mustBeSame)==outState(mustBeSame))
            if inState(spatialMode)==spatialModeValue %%in the spatial mode with the LC
                if inState(polMode)==0 && outState(polMode)==0
                    U(j,i)=simpleU(1,1);
                else if inState(polMode)==0 && outState(polMode)==1
                        U(j,i)=simpleU(1,2);
                    else if inState(polMode)==1 && outState(polMode)==0
                            U(j,i)=simpleU(2,1);
                        else
                            U(j,i)=simpleU(2,2);
                        end
                    end
                end
            else
                if inState(polMode)==outState(polMode)
                    U(j,i)=1;
                else
                    U(j,i)=0;
                end
            end
        end
    end
end

end


