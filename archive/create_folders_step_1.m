% Mapp för simulerad WoodEye data
dir_project='M:\WoodEye5_NyStruktur\Caroline_Musaab_Osama_Testscan_Spruce2\simulation';
Parentdir='M:\WoodEye5_NyStruktur\Caroline_Musaab_Osama_Testscan_Spruce2\organized';

files=dir(dir_project);
files={files.name};
files(1:2)=[];
nboards=length(files)/60;
files=reshape(files,nboards,60);

index=[1 10 100:109 11 110:119 12 120:129 13 130:139 14 140:149 15 150:159 16 160:169 17 170:179 18 180:189 19 190:199 ...
       2 20 200:209 21 210:219 22 220:229 23 230:239 24 240:249 25 250:259 26 260:269 27 270:279 28 280:289 29 290:299 ...
       3 30 300:309 31 310:319 32 320:329 33 330:339 34 340:349 35 350:359 36 360:369 37 370:379 38 380:389 39 390:399 ...
       4 40 400:409 41 410:419 42 420:429 43 430:439 44 440:449 45 450:459 46 460:469 47 470:479 48 480:489 49 490:499 ...
       5 50 500:509 51 510:519 52 520:529 53 530:539 54 540:549 55 550:559 56 560:569 57 570:579 58 580:589 59 590:599 ...
       6 60 600:609 61 610:619 62 620:629 63 630:639 64 640:649 65 650:659 66 660:669 67 670:679 68 680:689 69 690:699 ...
       7 70 700:709 71 710:719 72 720:729 73 730:739 74 740:749 75 750:759 76 760:769 77 770:779 78 780:789 79 790:799 ...
       8 80 800:809 81 810:819 82 820:829 83 830:839 84 840:849 85 850:859 86 860:869 87 870:879 88 880:889 89 890:899 ...
       9 90 900:909 91 910:919 92 920:929 93 930:939 94 940:949 95 950:959 96 960:969 97 970:979 98 980:989 99 990:999];

rm=[];
for k=1:length(index)
   if index(k)>nboards
     rm=[rm k];
   end
end
index(rm)=[];

for k=1:nboards
    if index(k)<10
        newdir=sprintf('B_00%d',index(k));
    elseif index(k)<100
        newdir=sprintf('B_0%d',index(k));
    elseif index(k)<1000
        newdir=sprintf('B_%d',index(k));
    end
    [SUCCESS,MESSAGE,MESSAGEID]=mkdir(Parentdir,newdir);
    for j=1:60
        fn=char(files(k,j));
        fno=fn;
        lfn=length(fn);
        if index(k)<10
            fn=fn(1:(lfn-6));
        elseif index(k)<100
            fn=fn(1:(lfn-7));
        elseif index(k)<1000
            fn=fn(1:(lfn-8));
        end
        destination=sprintf('%s%s%s%s%s',Parentdir,'\',newdir,'\',fn,'.txt');
        source=sprintf('%s%s',dir_project,'\',fno);
        copyfile(source,destination);
    end
end
