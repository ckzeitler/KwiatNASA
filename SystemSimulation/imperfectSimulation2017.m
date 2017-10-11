
H=[1;0];
V=[0;1];
D=[1;1]/sqrt(2);
A=[1;-1]/sqrt(2);
R=[1;1i]/sqrt(2);
L=[1;-1i]/sqrt(2);
t1=[1;0];
t2=[0;1];

AQWP1Setting=0;
AHWP1Setting=0;
AHWP2Setting=22.5;
AQWP2Setting=0;
BQWP1Setting=0;
BHWP1Setting=0;
BHWP2Setting=22.5;
BQWP2Setting=0;

LC0Phase=0;
LC0Rot=0;
LC1Phase=0;
LC1Rot=0;
LC2Phase=0;
LC2Rot=0;

interferometerSpatialShort=[1;0];
inteferometerSpatialModeLong=[0;1];
measurementSpatialReflected=[0;1];
measurementSpatialTransmitted=[1;0];

%%data from Alice side
NPBSA_HR=106/234;
NPBSA_VT=101/223;
NPBSA_HT=112/234;
NPBSA_VR=107/223;

PBSA_HT1=110/112;
PBSA_VR1=98/101;
PBSA_HR1=0.9/112;
PBSA_VT1=1/101;
PBSA_HT2=89/92;
PBSA_VR2=90/92;
PBSA_HR2=0.8/92;
PBSA_VT2=0.7/92;

DMA1_HT=234/237;
DMA1_VT=223/237;
DMA2_HT=86/89;
DMA2_VT=90/98;

%%data for Bob side
NPBSB_HR=9/18.6;
NPBSB_VT=9.33/18.3;
NPBSB_HT=9.4/18.6;
NPBSB_VR=8.7/18.3;

PBSB_HT1=9.2/9.4;
PBSB_VR1=9.05/9.33;
%PBSB_HR1=0.0016/9.4;
PBSB_HR1=0.03;
PBSB_VT1=0.005/9.33;
PBSB_HT2=7.65/7.7;
PBSB_VR2=7.5/7.55;
PBSB_HR2=0.03;
%PBSB_HR2=0.037/7.7;
PBSB_VT2=0.014/7.55;

DMB1_HT=18.6/19.1;
DMB1_VT=18.3/19.1;
DMB2_HT=7.3/7.65;
DMB2_VT=8.9/9.05;

inputStateTerm1=kron(kron(kron(kron(kron(interferometerSpatialShort,measurementSpatialTransmitted),kron(H,t1)),t1),kron(kron(interferometerSpatialShort,measurementSpatialTransmitted),kron(H,t1))),t1);
inputStateTerm2=kron(kron(kron(kron(kron(interferometerSpatialShort,measurementSpatialTransmitted),kron(H,t2)),t1),kron(kron(interferometerSpatialShort,measurementSpatialTransmitted),kron(H,t2))),t1);
inputStateTerm3=kron(kron(kron(kron(kron(interferometerSpatialShort,measurementSpatialTransmitted),kron(V,t2)),t1),kron(kron(interferometerSpatialShort,measurementSpatialTransmitted),kron(V,t2))),t1);
inputStateTerm4=kron(kron(kron(kron(kron(interferometerSpatialShort,measurementSpatialTransmitted),kron(V,t1)),t1),kron(kron(interferometerSpatialShort,measurementSpatialTransmitted),kron(V,t1))),t1);

inputState=(inputStateTerm1+inputStateTerm2+inputStateTerm3+inputStateTerm4)/2;
fullModeList=makeModeCombinations(5); %5 qubits per photon
%polarization is mode 3, interferometer spatial is mode 1, second
%interferometer mode time mode is mode 5
NPBSUA=makePBSU_Time(NPBSA_HT,NPBSA_HR,NPBSA_VT,NPBSA_VR,fullModeList,3,1,5);
NPBSUAlice=kron(NPBSUA,eye(32));
NPBSUB=makePBSU_Time(NPBSB_HT,NPBSB_HR,NPBSB_VT,NPBSB_VR,fullModeList,3,1,5);
NPBSUBob=kron(eye(32),NPBSUB);

PBSUA=makePBSU(PBSA_HT1,PBSA_HR1,PBSA_VT1,PBSA_VR1,PBSA_HT2,PBSA_HR2,PBSA_VT2,PBSA_VR2,fullModeList,3,1);
interferometerPBSUAlice=kron(PBSUA,eye(32));

PBSUB=makePBSU(PBSB_HT1,PBSB_HR1,PBSB_VT1,PBSB_VR1,PBSB_HT2,PBSB_HR2,PBSB_VT2,PBSB_VR2,fullModeList,3,1);
interferometerPBSUBob=kron(eye(32),PBSUB);

AliceDM1U=kron(makePolLossyU(DMA1_HT,DMA1_VT,fullModeList,3,0,0),eye(32));
AliceDM2U=kron(makePolLossyU(DMA2_HT,DMA2_VT,fullModeList,3,1,1),eye(32));

BobDM1U=kron(eye(32),makePolLossyU(DMB1_HT,DMB1_VT,fullModeList,3,0,0));
BobDM2U=kron(eye(32),makePolLossyU(DMB2_HT,DMB2_VT,fullModeList,3,1,1));

PBSUMeasureA=makePBSU(PBSA_HT1,PBSA_HR1,PBSA_VT1,PBSA_VR1,PBSA_HT2,PBSA_HR2,PBSA_VT2,PBSA_VR2,fullModeList,3,2);
PBSUMeasureAlice=kron(PBSUMeasureA,eye(32));

PBSUMeasureB=makePBSU(PBSB_HT1,PBSB_HR1,PBSB_VT1,PBSB_VR1,PBSB_HT2,PBSB_HR2,PBSB_VT2,PBSB_VR2,fullModeList,3,2);
PBSUMeasureBob=kron(eye(32),PBSUMeasureB);


detectorProjector(:,:,1)=kron(kron([1 0; 0 0],[1 0; 0 0]),eye(2^3));
detectorProjector(:,:,2)=kron(kron([1 0; 0 0],[0 0; 0 1]),eye(2^3));
detectorProjector(:,:,3)=kron(kron([0 0; 0 1],[1 0; 0 0]),eye(2^3));
detectorProjector(:,:,4)=kron(kron([0 0; 0 1],[0 0; 0 1]),eye(2^3));

earlyTimeModeProjector=kron(eye(2^3),kron([1 0; 0 0],[1 0; 0 0]));
lateTimeModeProjector=kron(eye(2^3),kron([0 0; 0 1],[0 0; 0 1]));
middleTimeModeProjector1=kron(eye(2^3),kron([1 0; 0 0],[0 0; 0 1]));
middleTimeModeProjector2=kron(eye(2^3),kron([0 0; 0 1],[1 0; 0 0]));

AliceQWP1U=kron(kron(kron(eye(4),QWP(AQWP1Setting)),eye(4)),eye(32));
AliceHWP1U=kron(kron(kron(eye(4),HWP(AHWP1Setting)),eye(4)),eye(32));
AliceHWP2U=kron(kron(kron(eye(4),HWP(AHWP2Setting)),eye(4)),eye(32));
AliceQWP2U=kron(kron(kron(eye(4),QWP(AQWP2Setting)),eye(4)),eye(32));

BobQWP1U=kron(kron(kron(eye(32),eye(4)),QWP(BQWP1Setting)),eye(4));
BobHWP1U=kron(kron(kron(eye(32),eye(4)),HWP(BHWP1Setting)),eye(4));
BobHWP2U=kron(kron(kron(eye(32),eye(4)),HWP(BHWP2Setting)),eye(4));
BobQWP2U=kron(kron(kron(eye(32),eye(4)),QWP(BQWP2Setting)),eye(4));

LC0U=kron(kron(kron(eye(4),LCRot(LC0Phase,LC0Rot)),eye(4)),eye(32));
LC1U=kron(makeLCU(LC1Phase,LC1Rot,fullModeList,3,1,0),eye(32));
LC2U=kron(makeLCU(LC2Phase,LC2Rot,fullModeList,3,1,1),eye(32));

outputStateAfterAlice=PBSUMeasureAlice*AliceQWP2U*AliceHWP2U*interferometerPBSUAlice*LC2U*LC1U*NPBSUAlice*LC0U*AliceDM1U*AliceHWP1U*AliceQWP1U*inputState;
outputState=PBSUMeasureBob*BobQWP2U*BobHWP2U*interferometerPBSUBob*NPBSUBob*BobHWP1U*BobQWP1U*outputStateAfterAlice;
%%calculate extreme bin singles

AliceMeasuresEarly=kron(earlyTimeModeProjector,eye(32))*outputState;
AliceMeasuresLate=kron(lateTimeModeProjector,eye(32))*outputState;
AliceMeasuresMiddle1=kron(middleTimeModeProjector1,eye(32))*outputState;
AliceMeasuresMiddle2=kron(middleTimeModeProjector2,eye(32))*outputState;
BobMeasuresEarly=kron(eye(32),earlyTimeModeProjector)*outputState;
BobMeasureLate=kron(eye(32),lateTimeModeProjector)*outputState;
BobMeasuresMiddle1=kron(eye(32),middleTimeModeProjector1)*outputState;
BobMeasuresMiddle2=kron(eye(32),middleTimeModeProjector2)*outputState;

earlyAliceSingles=zeros(1,4);
lateAliceSingles=zeros(1,4);
earlyBobSingles=zeros(1,4);
lateBobSingles=zeros(1,4);
AliceDetectorCouplingEfficiency=[.83,.8,.78,.83];
for i=1:4
    tempState=kron(squeeze(detectorProjector(:,:,i)),eye(32))*AliceMeasuresEarly;
    earlyAliceSingles(i)=AliceDetectorCouplingEfficiency(i)*(tempState'*tempState);
end
for i=1:4
    tempState=kron(squeeze(detectorProjector(:,:,i)),eye(32))*AliceMeasuresLate;
    lateAliceSingles(i)=AliceDetectorCouplingEfficiency(i)*(tempState'*tempState);
end
for i=1:4
    tempState=kron(eye(32),squeeze(detectorProjector(:,:,i)))*BobMeasuresEarly;
    earlyBobSingles(i)=tempState'*tempState;
end
for i=1:4
    tempState=kron(eye(32),squeeze(detectorProjector(:,:,i)))*BobMeasuresEarly;
    lateBobSingles(i)=tempState'*tempState;
end

middleAliceSingles=zeros(1,4);
middleBobSingles=zeros(1,4);
for i=1:4
    middleStateAtDetector=kron(squeeze(detectorProjector(:,:,i)),eye(32))*outputState;
    combinedStateMiddleAlice=combineMiddleTimeBins(middleStateAtDetector,makeModeCombinations(10),4,5,pi);
    
    middleAliceSingles(i)=AliceDetectorCouplingEfficiency(i)*(combinedStateMiddleAlice'*combinedStateMiddleAlice);
end

for i=1:4
    middleStateAtDetector=kron(eye(32),squeeze(detectorProjector(:,:,i)))*outputState;
    combinedStateMiddleBob=combineMiddleTimeBins(middleStateAtDetector,makeModeCombinations(10),9,10,0);
    
    middleBobSingles(i)=combinedStateMiddleBob'*combinedStateMiddleBob;
end


%%i indexes the time of Alice's detection, j the time of Bob's detection, k
%%the Alice detector that fires, and l the bob detector that fires

tic
coincidenceMatrix=zeros(3,3,4,4);
for i=1:3
    for j=1:3
        for k=1:4
            for l=1:4
                detectorProjectedState=kron(squeeze(detectorProjector(:,:,k)),squeeze(detectorProjector(:,:,l)))*outputState;
                if i==1
                    AliceTimeProjector=earlyTimeModeProjector;
                else if i==3
                        AliceTimeProjector=lateTimeModeProjector;
                    else
                        AliceTimeProjector=eye(32); %%deal with combining middle later
                    end
                end
                if j==1
                    BobTimeProjector=earlyTimeModeProjector;
                else if j==3
                        BobTimeProjector=lateTimeModeProjector;
                    else
                        BobTimeProjector=eye(32); %%deal with combining middle later
                    end
                end
                timeAndDetectorProjectedState=kron(AliceTimeProjector,BobTimeProjector)*detectorProjectedState;
                BobTemporalModeLabels=[9 10];
                BobTemporalModeList=makeModeCombinations(10);
                if i==2
                    timeAndDetectorProjectedState=combineMiddleTimeBins(timeAndDetectorProjectedState,makeModeCombinations(10),4,5,pi);
                    BobTemporalModeLabels=BobTemporalModeLabels-2;
                    BobTemporalModeList=makeModeCombinations(8);
                end
                if j==2
                    timeAndDetectorProjectedState=combineMiddleTimeBins(timeAndDetectorProjectedState,BobTemporalModeList,BobTemporalModeLabels(1),BobTemporalModeLabels(2),0);
                end
                coincidenceMatrix(i,j,k,l)= AliceDetectorCouplingEfficiency(k)*(timeAndDetectorProjectedState'*timeAndDetectorProjectedState);
            end
        end
    end
end

maskExtreme=[1 1 0 0; 1 1 0 0; 0 0 1 1; 0 0 1 1]==1;
maskMiddle=[1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1]==1;

goodProb=0;
for i=1:3
    
    if  i~=2
        mask=maskExtreme;
    else
        mask=maskMiddle;
    end
    goodProb=goodProb+sum(sum(squeeze(coincidenceMatrix(i,i,mask))));
end
badProb=0;
for i=1:3
    for j=1:3
        if abs(i-j)==1
            continue
        end
        if abs(j-1)==2
            mask=ones(4,4)==1;
        end
        if i==j
            if i~=2
                mask=~maskExtreme;
            else
                mask=~maskMiddle;
            end           
        end
        badProb=badProb+sum(sum(squeeze(coincidenceMatrix(i,j,mask))));
    end
end




toc