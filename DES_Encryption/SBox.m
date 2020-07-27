function [sOutput]= SBox (EboxInput)

SBox1=[14 4 13 1 2 15 11 8 3 10 6 12 5 9 0 7;
0 15 7 4 14 2 13 1 10 6 12 11 9 5 3 8 ;
4 1 14 8 13 6 2 11 15 12 9 7 3 10 5 0 ;
15 12 8 2 4 9 1 7 5 11 3 14 10 0 6 13];

rowIndexBin=[EboxInput(1) EboxInput(6)];
rowIndexDec=bi2de(rowIndexBin,'left-msb')+1;

columnIndexBin=[EboxInput(2:5)];
columnIndexDec=bi2de(columnIndexBin,'left-msb')+1;

newDec=SBox1(rowIndexDec,columnIndexDec);

newBin1=de2bi(newDec,4,'left-msb');

SBox2=[15 1 8 14 6 11 3 4 9 7 2 13 12 0 5 10 ;
3 13 4 7 15 2 8 14 12 0 1 10 6 9 11 5 ;
0 14 7 11 10 4 13 1 5 8 12 6 9 3 2 15 ;
13 8 10 1 3 15 4 2 11 6 7 12 0 5 14 9];


rowIndexBin=[EboxInput(7) EboxInput(12)];
rowIndexDec=bi2de(rowIndexBin,'left-msb')+1;

columnIndexBin=[EboxInput(8:11)];
columnIndexDec=bi2de(columnIndexBin,'left-msb')+1;

newDec=SBox2(rowIndexDec,columnIndexDec);
newBin2=de2bi(newDec,4,'left-msb');

SBox3=[10 0 9 14 6 3 15 5 1 13 12 7 11 4 2 8 ;
13 7 0 9 3 4 6 10 2 8 5 14 12 11 15 1 ;
13 6 4 9 8 15 3 0 11 1 2 12 5 10 14 7 ;
1 10 13 0 6 9 8 7 4 15 14 3 11 5 2 12];


rowIndexBin=[EboxInput(13) EboxInput(18)];
rowIndexDec=bi2de(rowIndexBin,'left-msb')+1;

columnIndexBin=[EboxInput(14:17)];
columnIndexDec=bi2de(columnIndexBin,'left-msb')+1;

newDec=SBox3(rowIndexDec,columnIndexDec);
newBin3=de2bi(newDec,4,'left-msb');

SBox4=[7 13 14 3 0 6 9 10 1 2 8 5 11 12 4 15 ;
13 8 11 5 6 15 0 3 4 7 2 12 1 10 14 9 ;
10 6 9 0 12 11 7 13 15 1 3 14 5 2 8 4 ;
3 15 0 6 10 1 13 8 9 4 5 11 12 7 2 14];


rowIndexBin=[EboxInput(19) EboxInput(24)];
rowIndexDec=bi2de(rowIndexBin,'left-msb')+1;

columnIndexBin=[EboxInput(20:23)];
columnIndexDec=bi2de(columnIndexBin,'left-msb')+1;

newDec=SBox4(rowIndexDec,columnIndexDec);
newBin4=de2bi(newDec,4,'left-msb');


SBox5=[2 12 4 1 7 10 11 6 8 5 3 15 13 0 14 9 ;
14 11 2 12 4 7 13 1 5 0 15 10 3 9 8 6 ;
4 2 1 11 10 13 7 8 15 9 12 5 6 3 0 14 ;
11 8 12 7 1 14 2 13 6 15 0 9 10 4 5 3];


rowIndexBin=[EboxInput(25) EboxInput(30)];
rowIndexDec=bi2de(rowIndexBin,'left-msb')+1;

columnIndexBin=[EboxInput(26:29)];
columnIndexDec=bi2de(columnIndexBin,'left-msb')+1;

newDec=SBox5(rowIndexDec,columnIndexDec);
newBin5=de2bi(newDec,4,'left-msb');

SBox6=[12 1 10 15 9 2 6 8 0 13 3 4 14 7 5 11 ;
10 15 4 2 7 12 9 5 6 1 13 14 0 11 3 8 ;
9 14 15 5 2 8 12 3 7 0 4 10 1 13 11 6 ;
4 3 2 12 9 5 15 10 11 14 1 7 6 0 8 13];

rowIndexBin=[EboxInput(31) EboxInput(36)];
rowIndexDec=bi2de(rowIndexBin,'left-msb')+1;

columnIndexBin=[EboxInput(32:35)];
columnIndexDec=bi2de(columnIndexBin,'left-msb')+1;

newDec=SBox6(rowIndexDec,columnIndexDec);
newBin6=de2bi(newDec,4,'left-msb');

SBox7=[4 11 2 14 15 0 8 13 3 12 9 7 5 10 6 1 ;
13 0 11 7 4 9 1 10 14 3 5 12 2 15 8 6 ;
1 4 11 13 12 3 7 14 10 15 6 8 0 5 9 2 ;
6 11 13 8 1 4 10 7 9 5 0 15 14 2 3 12];

rowIndexBin=[EboxInput(37) EboxInput(42)];
rowIndexDec=bi2de(rowIndexBin,'left-msb')+1;

columnIndexBin=[EboxInput(38:41)];
columnIndexDec=bi2de(columnIndexBin,'left-msb')+1;

newDec=SBox7(rowIndexDec,columnIndexDec);
newBin7=de2bi(newDec,4,'left-msb');

SBox8=[13 2 8 4 6 15 11 1 10 9 3 14 5 0 12 7 ;
1 15 13 8 10 3 7 4 12 5 6 11 0 14 9 2 ;
7 11 4 1 9 12 14 2 0 6 10 13 15 3 5 8 ;
2 1 14 7 4 10 8 13 15 12 9 0 3 5 6 11];


rowIndexBin=[EboxInput(43) EboxInput(48)];
rowIndexDec=bi2de(rowIndexBin,'left-msb')+1;

columnIndexBin=[EboxInput(44:47)];
columnIndexDec=bi2de(columnIndexBin,'left-msb')+1;

newDec=SBox8(rowIndexDec,columnIndexDec);
newBin8=de2bi(newDec,4,'left-msb');


sOutput=[newBin1 newBin2 newBin3 newBin4 newBin5 newBin6 ...
    newBin7 newBin8];

end

