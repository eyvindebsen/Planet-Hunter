!- Planet Hunter v0.4
!-
!-  todo: there are gosub bugs - fixed!
!-   a mishandled gosub would accumulate and cause
!-   an out of memory error over time
!-
!-  todo: the "antenna data read" takes too long time - fixed!
!-   Quick ASM code in file "fastantennadata.asm"
!-   turned into small hex data and a reader at line 600
!-
1 rem planet hunter v0.4 game
2 gosub600:rem get the asm code for fast antenna data
3 poke53280,11:poke53281,0:s=1024:c=55296-s
5 forx=.to23:r$=r$+"{down}":next:gosub450
7 a$="IJKU ":rem old a$="IJKU {sh asterisk}{125}";arabic like?
8 ts=0:r=0:og=0:printr$:gosub300:print:gosub400
10 getz$:ifz$<>""then10:rem clear keyboard buffer
18 z$="":print"{green}level"r+1:print"{light blue}ready.{light green}":poke19,65:inputz$
19 ifz$="hi"thengosub500:goto10
20 ifz$="help"thenprint:gosub300:print:gosub400:goto10
21 print:printr$"{blue}planet scanner v1 init";
22 forx=.to3:fory=.to234*rnd(1)*x:next:print".";:next:x=rnd(-ti)
24 print"{light gray}{clear}":sys49166
25 rem forx=.to959:printmid$(a$,1+rnd(.)*5,1);:next:tt=0
26 rem forq=.to3:q$(q)="":forx=.to239:q$(q)=q$(q)+mid$(a$,1+rnd(1)*5,1):next:print".";:next
28 tt=0:rem print"{home}{light gray}";:forq=.to3:printq$(q);:next:tt=0
30 rem the above will precalculate 4 strings, to display fast
31 rem printing a char at a time, will give an advantage to the ply
33 printr$"{white}scanning... {light green}how many planets? (0-9): ";
35 rem pokel,0:pokem,24:sysw:print"{white}scanning... {light green}how many planets? (0-9): ";
40 z$="":p=0:ip=1:for x=stos+959:f=0
42 ifip=1thengetz$:ifz$<>""thentt=ti:ifz$>="0"andz$<="9"thenip=0:print"{green}"z$;:rem check for input
45 o=peek(c+x):pokec+x,1
50 ifpeek(x)=85thenifpeek(x+1)=73thenifpeek(x+40)=74thenifpeek(x+41)=75thenf=1
60 iff=0then80
70 p=p+1:d=1+15*rnd(1):pokec+x,d:pokec+x+1,d:pokec+x+40,d:pokec+x+41,d:o=d
80 pokec+x,o:next
82 rt=ti:rem how long time did the scan take
83 forx=2023to1984step-1:pokex,255:wait53265,128:pokex,32:next:rem clear last line effect
85 ifp=0thenprint"{home}"r$"{pink}no planets found!";:goto91
90 print"{home}"r$"{white}found"p"planet";:ifp>1thenprint"s";
91 print"{light green}, you input "z$;:ifz$=""thentt=rt
93 ifval(z$)=pthenprint"{yellow} correct!";:goto96
94 print"{red} wrong!":gosub130:goto8:rem wrong answer, game over!
96 forq=.to2999:next:rem wait a bit
97 sc=rt-tt:print:print"you scored"sc"points!":ts=ts+sc
98 if sc>1600thenprint"{light gray}wow! thats fast!":goto103
100 if sc<1100thenprint"{dark gray}a bit slow..."
103 print"{yellow}total points:"ts
104 r=r+1:ifr=3orr=7orr=13orr=16orr=17thengosub118:ifog=1then8:rem rumors
105 goto10:rem continue game
118 print"{gray}rumor: a hal computer claims"
119 print"there is an error with the scanner!?"
124 if r=7then print"maybe it should be replaced?"
125 if r=13then print"something shakes...":x=int(rnd(1)*2):ifx>0thengosub140:r=r+x
127 if r=16thenifsx=0thengosub145:sx=1
128 if r=17then print"the planet scanner has failed...":gosub130:og=1
129 return
130 print"{down}{red}game over"
135 print"{yellow}total points: "ts"{light blue}"
136 ifts>h(8)then gosub530:goto138:rem made hiscore
137 print"you did not make the hiscore!"
138 forx=.to3999:next:return:rem new game
139 rem special event
140 print"{red}a huge explosion is heard !":print"{white}you loose a level!":return
145 print"{light gray}{down}?syntax  error in 127":print"{green}ready.":poke19,65:inputz$
147 print:print"{white}just kidding!":forx=.to3999:next:return
299 rem game logo
300 print" {green}{cm a}DIT  UDIUDI{cm a}DIF{cm r}D  G H{cm g} {cm m}UDID{cm r}FUDI{cm a}DI"
302 print" {light green}{125} H{cm g}  G H{125} {125}{cm q}F  G   {cm q}D{cm w}T YG H H {cm q}D {cm q}F{cm w}"
304 print" {yellow}{cm q}FK{cm g}  {cm q}F{cm w}G HG   {125}   H {125}G HT Y Y G  G J"
306 print" {white}{125}  LRRG HT Y{cm z}FK H   {125} HJFK{cm g} {cm m} H JFKT"
308 printspc(13)"{dark gray}a game by eyvind ebsen 2025":return
399 rem game intro text
400 print"{yellow}greetings!":?:print"{white}i am the {purple}v0.1 planet scanner."
411 print"{light green}{down}my task is to scan tons of data,":print"searching for planets."
412 print"{down}{light blue}can you find the number of{light gray} UI"
413 print"{light blue}planets faster than me?{light gray}    JK{white}{arrow left} a planet"
415 print"{white}{yellow}{down}a fast response yields a higher score."
416 print"{down}{pink}you only get to choose once! (0-9){down}"
420 return
449 rem init hiscore
450 forx=.to9:h$(x)="..........":h(x)=17000-x*875:next
460 h$(0)="  eyvind  "
461 h$(1)="    was   "
462 h$(2)="   here   "
464 h$(3)="   2025   "
480 return
499 rem show hi-score
500 print:printspc(14)"{white}top players"
505 printspc(11)"{light gray}------------------":print
510 forx=.to8
511 if xand1thenpoke646,14:goto513
512 poke646,6
513 ifx=.thenpoke646,7:rem gold
514 ifx=1thenpoke646,11:rem silver
516 ifx=2thenpoke646,9:rem bronze
520 printspc(10)x+1;h$(x);h(x):print:next
525 return
530 pl=9:forx=8to.step-1:rem made the hiscore
550 if ts>h(x)thenpl=x
560 next
565 pl=pl+1
570 print"{yellow}you made"pl"place!":print
575 print"{light blue}tip: type 'hi' at prompt for hiscore{down}"
580 forx=8toplstep-1:h(x)=h(x-1):h$(x)=h$(x-1):next:rem move down
582 input"your name";na$
584 iflen(na$)>10thenna$=left$(na$,10):goto590
586 iflen(na$)<10thenna$=na$+".":goto586
590 h(pl-1)=ts:h$(pl-1)=na$
592 gosub500
594 return
599 rem load a fast "antenna data reader" asm
600 reada$
610 forx=1tolen(a$)step2:a=0:b$=mid$(a$,x,2):ifb$="zz"then665
615 fory=1to2
620 d=asc(mid$(b$,y,1)):ifd>64thend=d-55:goto630
625 d=d-48
630 ify=1thena=d*16:goto650
640 a=a+d
650 next
660 poke49152+ad,a:ad=ad+1:next:goto600
665 sys49152:return
670 data a9ff8d0ed48d0fd4a9808d12d460a200ad1bd4290fc90ff0f7a8b933c09d0004ee1fc0
680 data ad1fc0c908d0e6a9048d1fc0e8d0de60494a4b5520494a4b5520494a4b552000zz
