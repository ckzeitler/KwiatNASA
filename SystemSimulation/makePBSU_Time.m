function [ U ] = makePBSU_Time( HT,HR,VT,VR, fullModeList,polMode,spatialMode,temporalMode)
%%constructs the unitary for a (polarizing) beamsplitter, given a set of
%%probabilities to transmit or reflect each polarization, a labeling of
%%each state (ie, state 1 is spatial mode 1, OAM mode 7, polarization mode
%%H, etc. and a note as to which mode is polarization, and which is the
%%spatial mode being split by the PBS. Assumes that the PBS only couples if
%%all modes are the same, except the spatial mode. For example,if the
%%spatial mode is first, [1 1 2 2] will couple to [1 1 2 2] and [2 1 2 2],
%%but not [1 1 2 1], because it has a different fourth mode.
%%assumes unbalanced paths so the different spatial modes change the time
%%mode as well. This assumes that all the amplitude is in state 1 of the
%%new temporal mode to start (maybe unnecessary?). I'm going to design it
%%so going same->same spatial is early time, and switching modes moves to
%%long time mode. 

U=zeros(size(fullModeList,1));
mustBeSame=ones(1,size(fullModeList,2))==1;
mustBeSame(spatialMode)=~mustBeSame(spatialMode);
mustBeSame(temporalMode)=~mustBeSame(temporalMode);
for i=1:2^size(fullModeList,2);
    for j=1:2^size(fullModeList,2);
        inState=fullModeList(i,:);
        outState=fullModeList(j,:);
        if all(inState(mustBeSame)==outState(mustBeSame)) && outState(spatialMode)==outState(temporalMode) %check if modes couple
            if fullModeList(i,polMode)==1 %Horizontal polarization
                if fullModeList(i,spatialMode)==fullModeList(j,spatialMode) %transmit
                    U(j,i)=sqrt(HT);
                else %reflect
                    U(j,i)=1i*sqrt(HR);
                end
            else %vertical polarization
                if fullModeList(i,spatialMode)==fullModeList(j,spatialMode) %transmit
                    U(j,i)=sqrt(VT);
                else %reflect
                    U(j,i)=1i*sqrt(VR);
                end
            end
        else
            U(j,i)=0;
        end
    end
end
end


