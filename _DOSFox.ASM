
;#############################################  �������忪ʼ  #####################################################
INCLUDE FOXEQU.ASM
;#############################################  �����������  #####################################################
;#############################################  �ṹ���忪ʼ  #####################################################
;Ӳ�̹�����ϵͳ�õ������ݽṹ
PartStruc	 struc
	PartActive	 db 		?		;LinkPointer:points to next T/Q descriptor or indicates termination by T-flag
	PartType     db     ?
	PartStart		 dw 		?		;presents the actual length (11 bit ) = and 2047
	PartEnd 		 dw 		?		;presents the Status
	;PartCap			 dw     ?   ;Ӳ������
	PartValid		 db     ?		;�����Ƿ���Ч ���Լ��ã�
PartStruc ends
;��ʵ�ķ����ṹ
Part_Entry struc
	part_flag		 db     ?
  beg_head     db     ?
  beg_sector   db     ?
  beg_cylinder db     ?
  file_system  db     ?
  end_head     db     ?
  end_sector   db     ?
  end_cylinder db     ?
  first_sector dd     ?
	sector_count dd     ?
Part_Entry ends

;#############################################  �ṹ�������  #####################################################
;
    .MODEL SMALL
    .486
    .STACK 200H
.DATA
;#############################################  ���ݶο�ʼ  #####################################################
;���ݶΣ���ʾ�����������ݣ�Ӳ�̿�����������(�ṹ)����ʾ��Ϣ�����ַ���
DATABEGIN LABEL BYTE
;===============================�ַ���============================================
INCLUDE FOXDATA.ASM
;ORG 200h
MBRBUF     				  DB 446 DUP (0)
  BUF_PART1					Part_Entry <0,0,0,0,0,0,0,0,00,00>
	BUF_PART2					Part_Entry <0,0,0,0,0,0,0,0,00,00>
	BUF_PART3					Part_Entry <0,0,0,0,0,0,0,0,00,00>
	BUF_PART4					Part_Entry <0,0,0,0,0,0,0,0,00,00>
					          DW 0AA55H				
;ORG 400H
FOXWAI     				  DB 446 DUP (0)												;�����Լ�Ҫ�õ�����MBR
	FOXW_PART1				Part_Entry <0,0,0,0,0,0,0,0,00,00>
	FOXW_PART2				Part_Entry <0,0,0,0,0,0,0,0,00,00>
	FOXW_PART3				Part_Entry <0,0,0,0,0,0,0,0,00,00>
	FOXW_PART4				Part_Entry <0,0,0,0,0,0,0,0,00,00>
					          DW 0AA55H
;ORG 600H 
FOXNEI     				  DB 446 DUP (0)												;�����Լ�Ҫ�õ�����MBR
	FOXN_PART1				Part_Entry <0,0,0,0,0,0,0,0,00,00>
	FOXN_PART2				Part_Entry <0,0,0,0,0,0,0,0,00,00>
	FOXN_PART3				Part_Entry <0,0,0,0,0,0,0,0,00,00>
	FOXN_PART4				Part_Entry <0,0,0,0,0,0,0,0,00,00>
					          DW 0AA55H
;ORG 800H
FOXBUF LABEL BYTE
	My_SetupFlag		  DB 'LUOB';DB 4 DUP(0)														;�ַ���'LUOB'��ʾ�Ѿ���װ
										DB 12 DUP(0)
  include FoxSeeC.inc   																	;��ɫ������ѡ��							
;ORG 0A00H
ENDDATA         DW  0AA55H      ;������־
;#############################################  ���ݶν���  #####################################################
;
;#############################################  ����ο�ʼ  #####################################################
;+++++++++++++++++++++++++++++++ ������ʼ ++++++++++++++++++++++++++++++++++++++++++
.CODE
START:
 MOV AX,@DATA
 MOV DS,AX 
 MOV ES,AX
 CALL MAIN_MOUDLE
 ;
 MOV  AX,4C00H
 INT 21H
;+++++++++++++++++++++++++++++++ ��������� ++++++++++++++++++++++++++++++++++++++++++
;
;;+++++++++++++++++++++++++++++++ �ӳ���ʼ ++++++++++++++++++++++++++++++++++++++++++
;�ӳ������������֣�1 ��ʾ�����ӳ���  2 Ӳ�̿����ӳ���  3 ���ƿ����ӳ��� 
;          4 ��ȡCMOS��Ϣ(Ϊ���Ժ���չ����ӵ��ӳ���Ҳ�����������)
;          5 Ϊ������ֱ�ӵ��õĽ����ӳ���
;          6 ����ģ��
;------------------����ģ�� ��ʼ------------------------------------
MAIN_MOUDLE PROC NEAR
 ;��ʾ�ĳ�ʼ������
 CALL INITVIDEO    ;��ʾģʽ����ɫ�Ĵ���׼�����
 ;CALL	DISP_MAIN_SEL
 ;CALL BoundaryMangment
 ;CALL GetDiskPara
 CALL FOXMAIN
; CALL AboutDIS
; XOR AX,AX
; INT 16H
 ;MOV	DX,OFFSET STR_OUTTER_PARTSYS
 ;CALL PartMangment
 ;CALL MatchCMangment	
	
MAINEXIT:
 ;���ص�3����ʾģʽ
 MOV AX,0003H
 INT 10H
 RET
MAIN_MOUDLE ENDP
;------------------����ģ�� ����------------------------------------
INCLUDE FOXSVGA.ASM
INCLUDE FOXPM.ASM
INCLUDE FOXAbout.ASM
INCLUDE FOXSetBD.ASM
INCLUDE FOXSTDIO.ASM
INCLUDE FOXHD.ASM
INCLUDE FOXMainM.ASM
INCLUDE FOXMAIN.ASM
INCLUDE FOXMCM.asm
INCLUDE FOXMUSIC.ASM
;------------------��ʾ�����ӳ��� ����------------------------------------------------------------
;;+++++++++++++++++++++++++++++++ �ӳ������ ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
END START