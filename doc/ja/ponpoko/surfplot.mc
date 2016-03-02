/* MAXIMA */

/* °��������.*/
/* surfg��°������

   surfg�ˤ�ʿ�̶����ȶ��ֶ��̤������ݤ��Ѥ��붦�̤����������ޤ�. 
   root_finder ������׻�����ݤβ�ˡ�λ���.
               d_chain_bisection���Ѥ���ȼ��ʸ򺹤����������ޤ�.
   iterations: ������׻�����ݤη��֤��ξ�¤�����
   width:      �����β���
   height:     �����ι⤵
*/
put(surfg, d_chain_bisection,root_finder);
put(surfg, 0.0000000001,epsilon);
put(surfg, 20000,iterations);
put(surfg, 500,width);
put(surfg, 500,height);

/* surf��°������

   surf�ˤ϶��ֶ��̤������ݤ��Ѥ������������ޤ�.
   surf�ǤϿ��λ����RGB�ǹԤ�, 0����255�ޤǤ���������ꤷ�ޤ�.
   do_background:    �طʿ�
   background_red:   �طʿ��λ���(��)
   background_green: �طʿ��λ���(��)
   background_blue:  �طʿ��λ���(��)
   rot_x:            X�����β�ž����(rad)
   rot_y:            Y�����β�ž����(rad)
   rot_z:            Z�����β�ž����(rad)
   scale_x:          X����������Ψ
   scale_y:          Y����������Ψ
   scale_z:          Z����������Ψ
   transparence:     Ʃ����0-100, 0��solid, 100��Ʃ��

*/
put(surf, yes,do_background);
put(surf, 0,background_red);
put(surf, 0,background_green);
put(surf, 0,background_blue);
put(surf, 0.14,rot_x);
put(surf,-0.3, rot_y);
put(surf, 0.0, rot_z);
put(surf, 1.0, scale_x);
put(surf, 1.0, scale_y);
put(surf, 1.0, scale_z);
put(surf, 0, transparence);
put(surf, ambient_light+diffuse_light+reflected_light+transmitted_light,
          illumination);

/* surfplot  

   ������¿�༰. ¿�༰���ѿ���2�Ĥ�3�ĤǤʤ���Х��顼�ˤʤ�ޤ�.
   �����surf���Ѥ��ޤ���,�� ��ȡ���Ǥ��׻��ե�����Ȥ���surf.tmp��
   surf�Υ�����ץȤ�����, systemȡ���ǲ�����������Ԥ��ޤ�.
   ͱ, ���̤�surfer�������������Ԥ�, ������surf����������������
   Viewer��ɽ�������ޤ�.
*/
surfplot(f):=block(
[
 poly,poly0,vars,lls1:0,lls2:0,
 f:ratsimp(expand(f)),tmp,
 str,target,j,sl,obj,
 ls1:properties(surfg),
 ls2:properties(surf),
 delcmd,drwcmd,cnvcmd,execmd,dspcmd
],
vars:showratvars(float(f)),
n:length(vars),
display2d:false,
if n=2 or n=3 then
  (lls1:length(ls1[1])-1,
   for i:1 thru lls1 do
      (str:ls1[1][i+1],
       (if str=epsilon then tmp:rat(get(surfg,str)) 
           else tmp:get(surfg,str)),
       surf_settings[i]:str=tmp
       ),
   if n=3 then
     (lls2:length(ls2[1])-1,
      for i:1 thru lls2 do
          (str:ls2[1][i+1],
           j:i+lls1,
           surf_settings[j]:str=get(surf,str)
           ),
       /* ȾƩ��ɽ���ΰ٤����� */
       /* �ѿ���������Ԥ��ޤ�.*/
       poly0:subst([vars[1]=surf_tmp_x,vars[2]=surf_tmp_y,
                    vars[3]=surf_tmp_z],f),
       poly:subst([surf_tmp_x=x,surf_tmp_y=y,surf_tmp_z=z],poly0),
       /* ���̤������٤����� */
       target:surface,
       obj:draw_surface)
   else
      (
       /* �ѿ���������Ԥ��ޤ�.*/
       poly0:subst([vars[1]=surf_tmp_x,vars[2]=surf_tmp_y],f),
       poly:subst([surf_tmp_x=x,surf_tmp_y=y],poly0),
       /* �����������٤����� */
       target:curve,
       obj:draw_curve),
  /* ����sl�������,��������ȶ���/���̤�������������̿�������ޤ� */
   j:lls1+lls2,
   array(sl,j+2),
  (for i:0 thru j-1 do
       sl[i]:surf_settings[i+1]),
   sl[j]:target=poly,
   sl[j+1]:obj,
   /* ����,������� */
   print("Surf is now drawing ", poly,". Please wait ...."),
   /* stringoutȡ����,������ץȤμ������ߤޤ�. */
   if n=2 then
     (stringout("surf.tmp",clear_screen,sl[0],sl[1],sl[2],sl[3],
                                        sl[4],sl[5],sl[6]))
   else
     (stringout("surf.tmp",clear_screen,sl[0],sl[1],sl[2],sl[3],
              sl[4],sl[5],sl[6],sl[7],sl[8],sl[9],sl[10],sl[11],
                 sl[12],sl[13],sl[14],sl[15],sl[16],sl[17],sl[18])),
   if n=3 then 
   /* systemȡ����surfer��ư���ޤ�.surf��GUI�դ�ư���ΤǤ����, 
      "surf -x surf.tmp"�Ȥ��Ƥ⹽���ޤ���. */
      system("surfer surf.tmp >surf.log&")
   else
   /* MS-Windows�Ǥ��뤫��, ����ѿ�gnuplot_command���ͤ�Ƚ�Ǥ��ޤ� 
    ���Υץ�����MS-Windows���ư����뤿��ˤ�
    NetPbm for Windows��ImageMagick�Τɤ��餫��,
    surfer�Υ��󥹥ȡ��뤬ɬ�פǤ�. ������.�����Υ��ץꥱ�������ؤ�
    �Ķ��ѿ�Path�����꤬�Բķ�Ǥ�. �ʤ�, �����Ǥ�ImageMagick��
    �Ȥ���������ˤ��Ƥ��ޤ���, NetPbm�ξ���cnvcmd��
    cnvcmd:"ppmtojpeg surf.ppm>surf.jpg"
    ���ѹ��������������פǤ�.
   */
      (if gnuplot_command="wgnuplot" then 
        (delcmd:"del surf.ppm surf.jpg",
         drwcmd:"echo color_file_format=ppm;\
filename=\"surf.ppm\";save_color_image;>>surf.tmp",
         execmd:"surf surf.tmp>surf.log",
         /* ImageMagick�ξ�� */
         cnvcmd:"convert surf.ppm surf.jpg",
         /* NetPbm�ξ�� */
/*       cnvcmd:"ppmtojpeg surf.ppm>surf.jpg", */
         dspcmd:"explorer surf.jpg")
       else 
        (delcmd:"rm surf.jpeg",
         drwcmd:"echo \"color_file_format=jpg;\
filename=\\\"surf.jpeg\\\";save_color_image;\">>surf.tmp",
         execmd:"surf --no-gui surf.tmp>surf.log",
         cnvcmd:"",
         dspcmd:"display surf.jpeg&"),
     /* systemȡ���ˤ����� 
        surf��GUI�դ������Ѳ�ǽ�Ǥ����, �ʲ���systemȡ����
        ���ƺ����, system("surf -x surf.tmp>surf.log&")��
        �ִ����ޤ�.
     */
       system(delcmd),
       system(drwcmd),
       system(execmd),
       system(cnvcmd),
       system(dspcmd)
        )
      )
else
/* ¿�༰��,2�ѿ��Ǥ�3�ѿ��Ǥ�ʤ���Х��顼��ɽ�����ޤ�. */
print("Error!"))$
