func iceil(a)
/* DOCUMENT iceil  
 *
 * ceilȡ�����ͤ�long�����������֤�ȡ��.
 */
{
 return long(ceil(a));
};

func ifloor(a)
/* DOCUMENT ifloor -- 
 *
 * floorȡ�����ͤ�long�����������֤�ȡ��.
 */
{
 return long(floor(a));
};

func num2str(n)
/* DOCUMENT num2str -- long����������ʸ������Ѵ�
 *
 * ����: n19str
 */
{
 local N,a;
 N=0; a="";
 if(numberof(n)){
    if(n!=0) N=ifloor(log(n)/log(10));
    for(i=N;i>=0;i--){
        n1=iceil(n/10^i);
        a=a+n19str(n1);};};
 return a;
};

func n19str(n)
/* DOCUMENT n19str -- 1����9�ο���ʸ������Ѵ�
 *
 * ����: num2str
 */
{
 local n1,r,a;
 n1=n/10;
 if(n1==0 || n1>0){
    r=n%10;
    a=string(&char(48+r));}
 else a="";
 return a;
};

func setMPIDigit(digit=)
/* DOCUMENT setMPIDigit -- ¿��Ĺ������ñ�̷�_n���ͤ����ꤹ��.
 *
 * _n��̤����ξ��˰�������ꤷ�ʤ����,��ưŪ��_n=9�����ꤵ���.
 */
{
 extern _n;
 if(digit==nil) {if(_n==nil) _n=9;}
 else _n=digit;
 _n;
};

func L2MPI(a)
/* DOCUMENT L2MPI -- long����������¿��Ĺ�������Ѵ�.
 *
 * ¿��Ĺ����������������γ���ʬ�η��������ѿ�_n�ǻ���.
 */
{
 local tmp,ans,i,k,f;
 f=0; 
 if(a<0){
    f=1;a=-a;};
 if(a==0) k=n;
 else k=ifloor(log10(a)/_n)+4;
 ans=array(k-3,k);
 ans(2)=_n;
 for(i=k;i>3;i--){ans(i)=a/(10^_n)^(i-4); a=a%(10^_n)^(i-4);};
 ans(1)=f;
 return(ans);
};

func MPPIp(a,b)
/* DOCUMENT MPPIp -- 2�Ĥ�¿��Ĺ������Ʊ�Τ��¤�׻�.
 *
 * ������¿��Ĺ�����η��������ѿ�_n�ǻ��ꤵ�줿��Τ˸���
 */
{
 local c,tmp,d,f,k,i;
 if(a(2)==b(2) && a(2)==_n){
    k = max(a(3),b(3));
    d = abs(a(3)-b(3));
    if(!(d==0)){
       tmp = array(0,d);
       if(k>a(3)) a = _(a,tmp);
       if(k>b(3)) b = _(b,tmp);};
     c = array(long,k+3);
     f = array(long,k+1);
     c(1)=0; c(2)=a(2); c(3)=k;
     for(i=1;i<=k;i++){
         tmp   = a(i+3)+b(i+3)+f(i);
         f(i+1)= tmp/10^_n;
         c(i+3)= tmp%10^_n;};
     if(f(k+1)>0){c(3)=c(3)+1; c=_(c,f(k+1));};
     return c;};
};

func printMPI(a)
/* DOCUMENT printMPI -- ¿��Ĺ�������̾�ο��Ȥ���ɽ��
 *
 */
{
 local k,f,i,j,m,s,t;
 t=a(2); s=num2str(t); j=ifloor(54/t);
 f=a(1); k=a(3); m=(j-1)*t;
 write,format="%"+s+"d",linesize=0,a(k+3);
 if(f>0){m=m-t;write,format="$"+s+"s","-";};
 for(i=k+2;i>3;i--){
     m=m-t;
     write,format="%0"+s+"d",linesize=0,a(i);
     if(m<0){m=j*t;write,format="%s\n","\\";};};
 write,format="\n","";
};

func Fib2MPI(n)
/* DOCUMENT Fib2MPI -- ¿��Ĺ������Ȥä�Fibonacci����׻�
 * 
 * �ʤ�, ������n��Yorick���̾��long������������.
 */
{
 local F0,F1,tmp;
 F0=[0,_n,1,0]; F1=[0,_n,1,1];
 if(n==0) F1=F0;
 for(i=2;i<=n;i++){tmp=F1; F1=MPPIp(F0,F1); F0=tmp;};
 return F1;
};
