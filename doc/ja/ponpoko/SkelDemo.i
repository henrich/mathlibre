extern _Px, _Py, _Q, _Pred;
_Px=1;_Py=1;_Q=1;_Pred=1;
rdline,prompt="�����ե�������ɤ߹��ߤޤ� ";
write,format="%s\n","skel=jpeg_read(\"Kodairi.jpeg\");";
skel=jpeg_read("Kodairi.jpeg");

rdline,prompt="���襦����ɥ���������Ԥ��ޤ�";
write,format="%s\n","window,1,dpi=100;";
window,1,dpi=100;

rdline,prompt="������ɽ��";
write,format="%s\n","pli,skel;"
pli,skel;

rdline,prompt="�����νĲ�����ݤ��ͤ��ѹ����ޤ�";
write,format="%s\n","limits,square=1;"
limits,square=1;

rdline,prompt="������ɽ���Ǿ岼��դˤ��ޤ�";
write,format="%s\n","fma;pli,skel(,,::-1);"
fma;pli,skel(,,::-1);
rdline,prompt="�����ͤ�ź��::-1�ǹԤ��ޤ�";

rdline,prompt="��������ɽ�������������פ��ΤǽĲ�����ݻ���ߤ�ޤ�";
write,format="%s\n","limits,square=0;"
limits,square=0;

rdline,prompt="�Ҹ�ǻ��ꤷ���ΰ���Ф�ȡ���������"
func getDOMAIN(image, p0, pred, option=)
{
 extern _Px, _Py, _Q, _Pred;
 local dnm,i,n,X,Y,Z;
 dnm=dimsof(image); Z=image; n=dnm(1);
 _Px=indgen(1:dnm(3))(,,-:1:dnm(4));
 _Py=transpose(indgen(1:dnm(4))(,,-:1:dnm(3)));
 _Q =p0; predx=pred+" _Px _Py _Q "+option;
 funcdef(predx);
 for(i=1;i<=n;i++) Z(i,,)=Z(i,,)*_Pred;
 return Z;};

write,format="%s\n","func getDOMAIN(image, p0, pred, option=)\n \
{\n \
 extern _Px, _Py, _Q, _Pred;\n \
 local dnm,i,n,X,Y,Z;\n \
 dnm=dimsof(image); Z=image; n=dnm(1);\n \
 _Px=indgen(1:dnm(3))(,,-:1:dnm(4));\n \
 _Py=transpose(indgen(1:dnm(4))(,,-:1:dnm(3)));\n \
 _Q =p0; predx=pred+\" _Px _Py _Q \"+option;\n \
 funcdef(predx);\n \
 for(i=1;i<=n;i++) Z(i,,)=Z(i,,)*_Pred;\n \
 return Z;};";

rdline,prompt="getDOMAINȡ���Ǥ�funcdef���Ѥ���ʸ����Ȥ���Ϳ����줿�Ҹ��ɾ����Ԥ��ޤ�";
rdline,prompt="�Ǥ�, ���˽Ҹ��������ޤ�.";
rdline,prompt="�ǽ�˱߾����ΰ���Ф��٤νҸ졧";
func Pred1(Px,Py,Qxy,r)
{
 extern _Pred;
 _Pred=((Px-Qxy(1))^2+(Py-Qxy(2))^2<=r^2);};
write,format="%s\n","func Pred1(Px,Py,Qxy,r)\n \
{\n \
 extern _Pred;\n \
 _Pred=((Px-Qxy(1))^2+(Py-Qxy(2))^2<=r^2);};";

rdline,prompt="�����������ΰ���Ф��٤νҸ졧";

func Pred2(Px,Py,Qxy,r)
{
 extern _Pred;
 Px=Px-Qxy(1); Py=Py-Qxy(2); th=pi*2/5;
 L1=(1-cos(2*th))/sin(2*th)*Px+r-Py;
 L2=(cos(4*th)-cos(2*th))/(sin(2*th)-sin(4*th))*
    (Px+r*sin(2*th))+r*cos(2*th)-Py;
 L3=r*cos(th)-Py;
 L4=(cos(3*th)-cos(th))/(sin(th)-sin(3*th))*
    (Px+r*sin(th))+r*cos(th)-Py;
 L5=(1-cos(3*th))/sin(3*th)*(Px+r*sin(3*th))+r*cos(3*th)-Py;
 pL1=(L1>=0); mL1=(L1<=0); pL2=(L2>=0); mL2=(L2<=0);
 pL3=(L3>=0); mL3=(L3<=0); pL4=(L4>=0); mL4=(L4<=0);
 pL5=(L5>=0); mL5=(L5<=0); 
 R1=pL1*pL5*mL3; R2=pL3*mL4*mL1; R3=pL1*mL2*pL4;
 R4=pL2*mL4*pL5; R5=pL3*mL2*mL5; R6=pL1*pL3*pL5*mL2*mL4;
 _Pred=((R1+R2+R3+R4+R5+R6)>0);};

write,format="%s\n","func Pred2(Px,Py,Qxy,r)\n \
{\n \
 extern _Pred;\n \
 Px=Px-Qxy(1); Py=Py-Qxy(2); th=pi*2/5;\n \
 L1=(1-cos(2*th))/sin(2*th)*Px+r-Py;\n \
 L2=(cos(4*th)-cos(2*th))/(sin(2*th)-sin(4*th))*\n \
    (Px+r*sin(2*th))+r*cos(2*th)-Py;\n \
 L3=r*cos(th)-Py;\n \
 L4=(cos(3*th)-cos(th))/(sin(th)-sin(3*th))*\n \
    (Px+r*sin(th))+r*cos(th)-Py;\n \
 L5=(1-cos(3*th))/sin(3*th)*(Px+r*sin(3*th))+r*cos(3*th)-Py;\n \
 pL1=(L1>=0); mL1=(L1<=0); pL2=(L2>=0); mL2=(L2<=0);\n \
 pL3=(L3>=0); mL3=(L3<=0); pL4=(L4>=0); mL4=(L4<=0);\n \
 pL5=(L5>=0); mL5=(L5<=0); \n \
 R1=pL1*pL5*mL3; R2=pL3*mL4*mL1; R3=pL1*mL2*pL4;\n \
 R4=pL2*mL4*pL5; R5=pL3*mL2*mL5; R6=pL1*pL3*pL5*mL2*mL4;\n \
 _Pred=((R1+R2+R3+R4+R5+R6)>0);};";

rdline,prompt="�Ǥϼ¹����";
write,format="%s\n","Hero1=getDOMAIN(skel(,,::-1),[1500,777],\"Pred2\", option=\"200\");\n \
Hime=getDOMAIN(skel(,,::-1),[500,1300],\"Pred1\",option=\"300\")\n \
Hero=getDOMAIN(skel(,,::-1),[1500,777],\"Pred2\",option=\"200\")\n \
Maru=getDOMAIN(skel(,,::-1),[2000,500],\"Pred2\",option=\"200\")\n \
Gai=getDOMAIN(skel(,,::-1),[1750,1300],\"Pred1\",option=\"400\")\n \
fma;pli,Hime+Hero+Maru+Gai";
winkill,1;
window,1,dpi=150;
Hero=getDOMAIN(skel(,,::-1),[1500,777],"Pred2", option="200");
fma;pli,Hero;
rdline,prompt="����";

Hime=getDOMAIN(skel(,,::-1),[500,1300],"Pred1",option="300");
fma;pli,Hime;
rdline,prompt="���뺵ɱ";

Maru=getDOMAIN(skel(,,::-1),[2000,500],"Pred2",option="200");
fma;pli,Maru;
rdline,prompt="�겼";

Gai=getDOMAIN(skel(,,::-1),[1750,1300],"Pred1",option="400");
fma;pli,Gai;
rdline,prompt="����";

rdline,prompt="�Ǥ�,�����륹�����ǡ�";
fma;pli,Hime+Hero+Maru+Gai









