/*
 * ͭ����Ratio�����
 *
 * ͭ�����Ϲ�¤��Ratio���������.
 * 
 */
struct Ratio{
       int  sgn;
       long num, den; };
               
/* 
 * ���פ�Ratio�����
 *
 */
_Zero=array(Ratio);
_Zero.den=1;
_One=array(Ratio);
_One.num=1;
_One.den=1;

/*
 * ɬ�פʥ饤�֥��
 *
 */
require,"FibMP.i";

func is_Ratio(a)
/* DOCUMENT is_Ratio -- Ratio�ο���ȡ��
 *
 * Ratio�Ǥ����1���֤���, ����ʳ�������0���֤�.
 *
 */
{
   if(catch(-1)) return(0);
   local ans,b;
   ans=1;
   if(typeof(a)=="struct_instance"){
         b=a.sgn;
         b=a.num;
         b=a.den;}
   else  ans=0;
   return(ans);
};
    

func is_RI(a)
/* DOCUMENT is_RI -- ͭ�����ο���ȡ��
 * 
 * Yorick�������Ǥ��뤫, Ratio�Ǥ����1, 
 * ����ʳ�������0���֤�ȡ��.
 */
{
  return(is_Ratio(a) || is_integer(a));
};

func I2Ratio(a)
/* DOCUMENT I2Ratio --  Yorick��������Ratio���Ѵ�.
 *  
 * �����������Ǥ����ͭ�������Ѵ���,
 * ������ͭ�����ξ��Ϥ��Τޤ��֤�,��
 * ����ʳ���nil���ֵѤ���. 
 */
{
    local c,b;
    if(is_integer(a)){ 
       c=_One;
       if(a<0){
          c.num=-a; 
          c.sgn=1;}
       else c.num=a;}
    else if(is_Ratio) c=a;
    else c=nil;
    return(c);
};
    
func R2Integer(a)
/* DOCUMENT R2Integer --- Ratio�����������Ѵ�.
 * 
 * ʬ�Ҥ�0�Τ�Τ���ʬ�ˤ�ä�ʬ�줬1�ˤʤä����
 * ���Ф��ƤΤ��Ѵ���Ԥ�.
 *
 */
{
   local ans;
   if(is_integer(a)) ans=a;
   else if(is_Ratio(a)){
      if(a.num==0) ans=0;
      else if(a.den==1) ans=(1-2*a.sgn)*a.num;};
    return(ans);
};

func R2Double(a)
/* DOCUMENT R2Double -- ��ư�����������Ѵ�����ȡ��.
 *
 */
{
   local ans;
   if(is_Ratio(a)) ans=a.num*1.0/a.den;
   else if(is_integer(a)) ans=a*1.0;
   return(ans);
};

func printRATIO(a)
/* DOCUMENT printRATIO -- Ratio��ʸ����Ȥä�ɽ��.
 *
 */
{
    local n,k1,k2,dv,nd,b,g;
    if(is_Ratio(a)){
       if(a.num==0){
          write,format="     %d\n",linesize=0,0;}
       else{
          g=gcd(a.num,a.den);
          a.num=a.num/g;
          a.den=a.den/g;
          if(a.sgn!=0) b="- ";
          else b="";
          n=ifloor(log10(max(a.num,a.den))+1+2*a.sgn);
          k2=num2str(n+1);
          nd="     %"+k2+"hd\n";
          if(a.den==1){
             write,format=nd,linesize=0,(1-2*a.sgn)*a.num;}
          else{
             k1=num2str(n);
             dv="     %"+k1+"hs\n";
             for(i=1;i<n+2;i++){
                 b=b+"-";};
             write,format=nd,linesize=0,a.num;
             write,format=dv,linesize=0,b;
             write,format=nd,linesize=0,a.den;};};}
     else if(is_integer(a)){
          write,format="     %d\n",linesize=0,a;};
};

func RSimp(a)
/* DOCUMENT RSimp -- ͭ��������ʬ��¹�.
 *
 * ͭ��������ʬ��¹Ԥ��뤬, ����ʳ����оݤ�
 * ���Τޤ��ֵѤ���.
 */
{
   local g,b;
   if(is_Ratio(a)){
      b=_Zero;
      if(a.num!=0){
        g=gcd(a.num,a.den);
        b.sgn=a.sgn;
        b.num=a.num/g;
        b.den=a.den/g;};}
   else b=a;
   return(b);
};

func REq(a,b)
/* DOCUMENT REq -- ͭ������Ʊ�����򸡾�
 *
 * 
 */
{
  local ans,a1,b1;
  ans=0;
  if(is_RI(a) && is_RI(b)){
     a1=RSimp(a); b1=RSimp(b);
     if(a1==b1) ans=1;};
  return(ans);
};

func RGr(a,b)
/* DOCUMENT RSimp -- ͭ�������羮�ط���Ƚ��.
 *
 * RGr(a,b) ==1 <-> a>b �ξ��
 * RGr(a,b) ==0 <-> a<=b�ξ��
 */
{
  local ans,a1,b1;
  ans=0; a1=a; b1=b;
  if(is_integer(a) && is_integer(b)) return(a>b);
  else if(is_integer(a)) a1=I2Ratio(a);
  else if(is_integer(b)) b1=I2Ratio(b);
  if(is_Ratio(a1)&& is_Ratio(b1)){
     if(a1.sgn+b1.sgn==1){
        if(a1.sgn==0) ans=1;}
     else{
          ans=(1-2*a1.sgn)*a1.num*b1.den>
              (1-2*b1.sgn)*a1.den*b1.num;};}
  return(ans);
};


func RLs(a,b)
/* DOCUMENT RSimp -- ͭ�������羮�ط���Ƚ��.
 *
 * RLs(a,b) ==1 <-> a<b �ξ��
 * RLs(a,b) ==0 <-> a>=b�ξ��
 */
{
  local ans,a1,b1;
  ans=0; a1=a; b1=b;
  if(is_integer(a) && is_integer(b)) return(a<b);
  else if(is_integer(a))a1=I2Ratio(a);
  else if(is_integer(b))b1=I2Ratio(b);
  if(is_Ratio(a1)&& is_Ratio(b1)){
     if(a1.sgn+b1.sgn==1){
       if(a1.sgn==0) ans=1;}
     else{
          ans=(1-2*a1.sgn)*a1.num*b1.den<
              (1-2*b1.sgn)*a1.den*b1.num;};}
  return(ans);
};

func RAdd(a,b)
/* DOCUMENT RAdd -- ͭ�������¤�׻�
 *
 */
{
   local c,a1,b1,g,g1,g2;
   a1=RSimp(a); b1=RSimp(b);
   if(is_integer(a)&& is_integer(b)) c=a+b;
   else if(is_integer(a)) a1=I2Ratio(a);
   else if(is_integer(b)) b1=I2Ratio(b);
   if(is_Ratio(a1)&& is_Ratio(b1)){
      c=_Zero;
      g1=gcd(a1.num,b1.num);
      g2=gcd(a1.den,b1.den);
      if(g1==0)g1=1;
      c.num=(1-2*a1.sgn)*(a1.num/g1)*(b1.den/g2)+
            (a1.den/g2)*(1-2*b1.sgn)*(b1.num/g1);
      c.den=(a1.den/g2)*(b1.den/g2);
      c.num=c.num*g1;
      c.den=c.den*g2;
      if(c.num<0){
         c.sgn=1;
         c.num=-c.num;};};
   return(RSimp(c));
};

func RNeg(a)
/* DOCUMENT RNeg -- ͭ�������¤εո���׻�
 *
 */
{
   local c;
   if(is_Ratio(a)){
      c=a; c.sgn=(a.sgn+1)%2;}
   else if(is_integer(a)) c=-a;
   return(c);
};

func RRev(a)
/* DOCUMENT RRev -- ͭ�����εտ���׻�
 *
 * 0���Ф��Ƥ�nil���֤�.
 *
 */
{
   local c,a1;
   a1=a;
   if(is_integer(a)) a1=I2Ratio(a);
   if(is_Ratio(a1)){
      c=_One;
      if(c.num==0) c=nil;
      else{
         c=a1;
         c.num=a1.den;
         c.den=a1.num;};};
   return(c);
};

func RSub(a,b)
/* DOCUMENT RSub -- ͭ�����θ���
 *
 * ����Ū��RNeg��RAdd������
 *
 */
{
   local c,b1;
   b1=RNeg(b);
   return(RAdd(a,b1));
};

func RTimes(a,b)
/* DOCUMENT RTimes -- ͭ��������
 *
 */
{
    local c,a1,b1,g1,g2;
    a1=RSimp(a); b1=RSimp(b);
    if(is_integer(a) && is_integer(b)) c=a*b;
    else if(is_integer(a)) a1=I2Ratio(a);
    else if(is_integer(b)) b1=I2Ratio(b);
    if(a1==_Zero || b1==_Zero) c=_Zero;
    else if(is_Ratio(a1)&& is_Ratio(b1)){
       c=_Zero;
       if(a1!=c && b1!=c){
          g1=gcd(a1.num,b1.den);
          g2=gcd(a1.den,b1.num);
          c.sgn=(a1.sgn+b1.sgn)%2;
          c.num=(a1.num/g1)*(b1.num/g2);
          c.den=(a1.den/g2)*(b1.den/g1);};};
    return(c);
};
    
func RDiv(a,b)
/* DOCUMENT RDiv -- ͭ�����ξ���׻�
 *
 * ����Ū��RTimes��RRev������.
 * ��2������0������������nil���֤�.
 *
 */
{
    local c;
    if(is_RI(a)&& is_RI(b)){
       if(RSimp(b)==_Zero || b==0) c=nil;
       else c=RTimes(a,RRev(b));};
    return(c);
};
   
