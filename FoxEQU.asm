;#############################################  �������忪ʼ  #####################################################
STARTSECTOR  EQU  06H						;���ô���洢��Ӳ����ʼ���򣬺�install.exe�еĶ�Ӧ
INCS         EQU  4000H									;�Լ����ô���ε�ַ
;----------------------------------------------------------------------------------
;�ַ�
MAXASCII  = 255
MAXCHINESE = 255
;��ʾģʽ
SYVIDEOMODE  = 0103H
DOSVIDEOMODE = 03H
;SCREEN_WIDTH = 640
SCREEN_HEIGHT = 600

;��ɫ�ĳ�������
BLACK = 0
WHITE = 1
LIGHTGRAY = 2
BLUE = 3
DARKBLACK = 4
LIGHTBLACK = 5
YELLOW = 6
GREEN = 7
RED = 8
DEEPBLUE = 9
;
HZCOUNT = 154     ;��ǰ������ȡ��91��
																;����������ϵͳ��ʾ������Ϣ��������ɫ


;
;ͼ�󳤶� �߶ȳ���
CHARWIDTH = 8
CHARHEIGHT = 16
DEFAULTBUTTONHEIGHT = 32  ;2*CHARHEIGHT
DEFAULTCAPTIONHEIGHT = 26 ;amend for show logo
DEFAULTEDITBOXHEIGHT = 24 ;DEFAULTEDITBOXHEIGHT=DEFAULTBUTTONHEIGHT-CHARHEIGHT/2
;�����ʾ���õĳ���
FRAME_LEFT	=	240
FRAME_TOP		=	170
FRAME_RIGHT	=	590
FRAME_BOTTOM	=	400
BUTTON_TOP_WAI	=	FRAME_TOP	+	70
BUTTON_LEFT_WAI	=	FRAME_LEFT	+	(FRAME_RIGHT-FRAME_LEFT)/2-8*CHARWIDTH
BUTTON_TOP_NEI	=	FRAME_BOTTOM	-	90
BUTTON_LEFT_NEI	=	BUTTON_LEFT_WAI
;AboutҪ�õ��ĳ���
About_Head_Y=FRAME_TOP+CHARHEIGHT*2
About_Head_X=FRAME_LEFT+CHARWIDTH*3
About_MyMes_Y=About_Head_Y+CHARHEIGHT
About_MyMes_X=About_Head_X+HEADPIC_WIDTH+CHARWIDTH*3
About_Thanks_Y=About_Head_Y+HEADPIC_HEIGHT+CHARHEIGHT/2
About_Thanks_X=About_Head_X
;������ϵͳ�õ��ĳ���
MSys_BD_Y=FRAME_TOP+CHARHEIGHT*2+CHARHEIGHT/2
MSys_BD_X=FRAME_LEFT+CHARWIDTH*12
MSys_WPart_Y=MSys_BD_Y+CHARHEIGHT*2+(CHARHEIGHT/4)
MSys_WPart_X=MSys_BD_X
MSys_NPart_Y=MSys_WPart_Y+CHARHEIGHT*2+(CHARHEIGHT/4)
MSys_NPart_X=MSys_BD_X
MSys_MatchC_Y=MSys_NPart_Y+CHARHEIGHT*2+(CHARHEIGHT/4)
MSys_MatchC_X=MSys_BD_X
MSys_SetOK_Y=MSys_MatchC_Y+CHARHEIGHT*2+(CHARHEIGHT/4)
MSys_SetOK_X=MSys_BD_X
MSys_ERR1_Y=FRAME_TOP+CHARHEIGHT*6
MSys_ERR1_X=FRAME_LEFT+CHARWIDTH*5
MSys_ERR2_Y=MSys_ERR1_Y+CHARHEIGHT*2
MSys_ERR2_X=MSys_ERR1_X
;Boundary �����õ��ĳ���
BM_CURRENT_MES_X=FRAME_LEFT+CHARWIDTH*2
BM_CURRENT_MES_Y=FRAME_TOP+CHARHEIGHT*3
BM_SetBD_X=BM_CURRENT_MES_X
BM_SetBD_Y=BM_CURRENT_MES_Y+CHARHEIGHT*4
BM_ACCEPT_X=FRAME_RIGHT-6*CHARWIDTH-6*CHARWIDTH			;��STR_BM_ACCEPT�����й�
BM_ACCEPT_Y=(FRAME_BOTTOM-3*CHARHEIGHT)-(2*CHARHEIGHT+CHARHEIGHT/2)
BM_RE_SET_X=BM_ACCEPT_X
BM_RE_SET_Y=BM_ACCEPT_Y+(2*CHARHEIGHT+CHARHEIGHT/2)
;��ɫ����Ҫ�õ��ĳ���
MCM_SelSol_X=FRAME_LEFT+CHARWIDTH*2
MCM_SelSol_Y=FRAME_TOP+CHARHEIGHT*3
MCM_ACCEPT_X=FRAME_RIGHT-6*CHARWIDTH-6*CHARWIDTH			;��STR_MC_ACCEPT�����й�
MCM_ACCEPT_Y=(FRAME_BOTTOM-3*CHARHEIGHT)-(2*CHARHEIGHT+CHARHEIGHT/2)
MCM_RE_SET_X=BM_ACCEPT_X
MCM_RE_SET_Y=BM_ACCEPT_Y+(2*CHARHEIGHT+CHARHEIGHT/2)
;������������Ҫ�õ��ĳ���
MANG_SYS_FRAME_LEFT	=	FRAME_LEFT-100
MANG_SYS_FRAME_TOP		=	FRAME_TOP-100 
MANG_SYS_FRAME_RIGHT	=	FRAME_RIGHT+100
MANG_SYS_FRAME_BOTTOM	=	FRAME_BOTTOM+68
STR_BOUN_X=MANG_SYS_FRAME_LEFT+CHARWIDTH*2
STR_BOUN_Y=MANG_SYS_FRAME_TOP+CHARHEIGHT*2+CHARHEIGHT/2
STR_HDMAX_X=STR_BOUN_X
STR_HDMAX_Y=STR_BOUN_Y+CHARHEIGHT+CHARHEIGHT/2
STR_PARTMES_X=STR_HDMAX_X+CHARWIDTH
STR_PARTMES_Y=STR_HDMAX_Y+CHARHEIGHT*2
STR_NUM1_X=STR_PARTMES_X+CHARWIDTH
STR_NUM1_Y=STR_PARTMES_Y+CHARHEIGHT*2
ACTIVE_FLAG1_X=STR_NUM1_X+8*CHARWIDTH
ACTIVE_FLAG1_Y=STR_NUM1_Y
EDITBOX_PART1_X=STR_NUM1_X+14*CHARWIDTH
EDITBOX_PART1_Y=STR_NUM1_Y-CHARHEIGHT/2
EDITBOX_PART2_X=EDITBOX_PART1_X
EDITBOX_PART3_X=EDITBOX_PART1_X
EDITBOX_PART4_X=EDITBOX_PART1_X
EDITBOX_PART2_Y=EDITBOX_PART1_Y+2*CHARHEIGHT
EDITBOX_PART3_Y=EDITBOX_PART2_Y+2*CHARHEIGHT
EDITBOX_PART4_Y=EDITBOX_PART3_Y+2*CHARHEIGHT
;
EDITBUT_Y=EDITBOX_PART4_Y+2*CHARHEIGHT
EDITBUT_X=EDITBOX_PART4_X+(12*2+9)*CHARWIDTH ;��Ϊ�������޸���λ��
;
FUN_ASK_Y=EDITBUT_Y+CHARHEIGHT
FUN_ASK_X=STR_NUM1_X
EDIT_ZONE_TOP=FUN_ASK_Y
EDIT_ZONE_LEFT=FUN_ASK_X
EDIT_ZONE_RIGHT=EDITBUT_X-CHARHEIGHT
EDIT_ZONE_BOTTOM=EDITBUT_Y+CHARHEIGHT*6
;logo
LOGO_WIDTH	= 24
LOGO_HEIGHT	= 24
;headpic
HEADPIC_WIDTH=120
HEADPIC_HEIGHT=120
;�����������������������������õĳ����ͺ궨���������������������������������
CTRLREG  EQU  43H							;���ÿ��ƼĴ���
C0ADR    EQU  40H							;������0�˿ڵ�ַ
C1ADR    EQU  41H							;������1�˿ڵ�ַ
C2ADR    EQU  42H							;������2�˿ڵ�ַ
;���ֽ���
HalfPai=5
OnePai=2*HalfPai
TwoPai=4*HalfPai
THREEPAI=6*HalfPai
;
L_IODELAY MACRO 	DelayTime					;����ʱ����ʱ����Ϊ��λ
	PUSHA
	MOV	AX,DelayTime
	CALL	DELAY  
	POPA
  ENDM 
DELAY10MS MACRO 										;��ʱ10ms
	PUSH CX
	MOV	CX,297H
	CALL	WAITF
	POP CX
  ENDM
PlaySound MACRO FregData,TimeData
  PUSHA
  MOV	SI,OFFSET FregData
  MOV	BP,OFFSET TimeData									
  CALL  PLAY_MUSIC
  POPA
  ENDM