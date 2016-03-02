rdline,prompt="Volterra-Lotka����ʬ��������򤯥ץ����"

func Volterra(A, B, K1,K2, X0, Y0, t1, h){
     local X, Y, Xt, Yt, i, n;
     n = ceil(t1*1/h);
     X=X0; Y=Y0;
     for(i=1;i<n;i++){
        X=h*(A-K1*Y)*X+X;
        Y=h*(K2*X-B)*Y+Y;};
     return([X,Y]);};

write,format="%s\n","func Volterra(A, B, K1,K2, X0, Y0, t1, h){\n \
     local X, Y, Xt, Yt, i, n;\n \
     n = ceil(t1*1/h);\n \
     X=X0; Y=Y0;\n \
     for(i=1;i<n;i++){\n \
        X=h*(A-K1*Y)*X+X;\n \
        Y=h*(K2*X-B)*Y+Y;};\n \
     return([X,Y]);};"

write,format="%s\n","Volterra(1,2,1,1,4,6,0,0.01)"
Volterra(1,2,1,1,4,6,0.0,0.01)
write,format="%s\n","Volterra(1,2,1,1,4,6,0.1,0.01)"
Volterra(1,2,1,1,4,6,0.1,0.01)
write,format="%s\n","Volterra(1,2,1,1,4,6,0.2,0.01)"
Volterra(1,2,1,1,4,6,0.2,0.01)
write,format="%s\n","Volterra(1,2,1,1,4,6,0.3,0.01)"
Volterra(1,2,1,1,4,6,0.3,0.01)
rdline,prompt="����Ǥ����򤯤ʤ��Τǵ�ƻ��300����������,�����ɽ���ˤ��ޤ��礦��"

func drawVolterra(A, B, K1, K2, X0, Y0, h, color=)
{
 local i;
 X=X0; Y=Y0;
 for(i=1;i<301;i++){
     X=h*(A-K1*Y)*X+X;
     Y=h*(K2*X-B)*Y+Y;
     pldj,X0,Y0,X,Y,color=color;
     X0=X;
     Y0=Y;};
}

write,format="%s\n","func drawVolterra(A, B, K1, K2, X0, Y0, h, color=)\n \
{\n \
 local i;\n \
 X=X0; Y=Y0;\n \
 for(i=1;i<301;i++){\n \
     X=h*(A-K1*Y)*X+X;\n \
     Y=h*(K2*X-B)*Y+Y;\n \
     pldj,X0,Y0,X,Y,color=color;\n \
     X0=X;\n \
     Y0=Y;};\n \
}";

window,10,dpi=100;
write,format="%s\n","drawVolterra(1,2,1,1,4,6,0.05,color=\"red\")}}"
drawVolterra(1,2,1,1,4,6,0.05,color="red")
rdline,prompt="����ͤ�1���������Ϳ����Ȳ򤬰��٤������׻��Ǥ��ޤ�";
write,format="%s\n","fma;drawVolterra(1,2,1,1,[2,2,4,2,1],[1.5,2,4,6,8],0.05,color=\"red\")"
fma;drawVolterra(1,2,1,1,[2,2,4,2,1],[1.5,2,4,6,8],0.05,color="red")

rdline,prompt="pauseȡ����Ȥäư°פʥ��˥᡼���������ޤ�:"
func animVolterra(A, B, K1, K2, X0, Y0, h, color=)
{
 local i;
 X=X0; Y=Y0;
 for(i=1;i<301;i++){
     X=h*(A-K1*Y)*X+X;
     Y=h*(K2*X-B)*Y+Y;
     pause,50;
     pldj,X0,Y0,X,Y,color=color;
     X0=X;
     Y0=Y;};
}

write,format="%s\n","func drawVolterra(A, B, K1, K2, X0, Y0, h, color=)\n \
{\n \
 local i;\n \
 X=X0; Y=Y0;\n \
 for(i=1;i<301;i++){\n \
     X=h*(A-K1*Y)*X+X;\n \
     Y=h*(K2*X-B)*Y+Y;\n \
     pause,50;\n \
     pldj,X0,Y0,X,Y,color=color;\n \
     X0=X;\n \
     Y0=Y;};\n \
}";

write,format="%s\n","fma;animVolterra(1,2,1,1,[2,2,4,2,1],[1.5,2,4,6,8],0.05,color=\"green\")"
fma;animVolterra(1,2,1,1,[2,2,4,2,1],[1.5,2,4,6,8],0.05,color="green")






