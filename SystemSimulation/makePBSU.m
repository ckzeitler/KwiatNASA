function [ U ] = makePBSU( HT1,HR1,VT1,VR1,HT2,HR2,VT2,VR2, fullModeList,polMode,spatialMode)
%%constructs the unitary for a (polarizing) beamsplitter, given a set of
%%probabilities to transmit or reflect each polarization, a labeling of
%%each state (ie, state 1 is spatial mode 1, OAM mode 7, polarization mode
%%H, etc. and a note as to which mode is polarization, and which is the
%%spatial mode being split by the PBS. Assumes that the PBS only couples if
%%all modes are the same, except the spatial mode. For example,if the
%%spatial mode is first, [1 1 2 2] will couple to [1 1 2 2] and [2 1 2 2],
%%but not [1 1 2 1], because it has a different fourth mode.

U=zeros(size(fullModeList,1));
mustBeSame=ones(1,size(fullModeList,2))==1;
mustBeSame(spatialMode)=~mustBeSame(spatialMode);
for i=1:2^size(fullModeList,2);
    for j=1:2^size(fullModeList,2);
        inState=fullModeList(i,:);
        outState=fullModeList(j,:);
        if all(inState(mustBeSame)==outState(mustBeSame)) %check if modes couple
            if fullModeList(i,polMode)==1 %Horizontal polarization
                if fullModeList(i,spatialMode)==fullModeList(j,spatialMode) %transmit
                    if inState(spatialMode)==0
                        U(j,i)=sqrt(HT1);
                    else
                        U(j,i)=sqrt(HT2);
                    end
                else %reflect
                    if inState(spatialMode)==0
                        U(j,i)=1i*sqrt(HR1);
                    else
                        U(j,i)=1i*sqrt(HR2);
                    end
                end
            else %vertical polarization
                if fullModeList(i,spatialMode)==fullModeList(j,spatialMode) %transmit
                    if inState(spatialMode)==0
                        U(j,i)=sqrt(VT1);
                    else
                        U(j,i)=sqrt(VT2);
                    end
                else %reflect
                    if inState(spatialMode)==0
                        U(j,i)=1i*sqrt(VR1);
                    else
                        U(j,i)=1i*sqrt(VR2);
                    end
                end
            end
        else
            U(j,i)=0;
        end
    end
end
end

