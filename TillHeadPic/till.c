//��ȡͷ��LOGO������
//�����Լ���logoͼ����640x480 256ɫͼ�����½ǣ�logoͼ����Χ��logo��û�е���ɫ��䣬����������ɫ��
//��ȡ�������ļ���logopal.bin��logopic.binΪ��ɫ��ͼ����Ϣ
//����SYBIOS��������ʮ����ɫ�����Ե�ǰ��ȡͼ����Ϣʱע��ÿ�����ص�ֵҪ��10
//�ӵ�SYBIOS��ʱ��ע���޸�����ֵ��
//															LOGO_WIDTH,LOGO_HEIGHT,Ϊ��ʾlogo��SYBIOS�еļ�������Ҳ������Ӧ���޸�
//														PUTWINDOW,����ȱʡ�ı������ĸ߶�Ҳ�޸���
//2005-7-12 luobing 20:41
#include<io.h>
#include<stdio.h>
#include<dos.h>
#include<string.h>
#include<math.h>
#include<stdio.h>
#include<bios.h>
#include<mem.h>
#include<fcntl.h>
#include<stdlib.h>
#include<conio.h>

//�ڴ˴��޸���ȡ��logoͼ�Ĵ�С
#define	LOGO_WIDTH	120
#define	LOGO_HEIGHT	120
#define	USED_COLOR_COUNT	10
/*�꼰ȫ�ֱ���*/
#define SCREEN_HEIGHT 480
#define SCREEN_WIDTH 640

#define PALETTE_MASK 0x3c6
#define PALETTE_REGISTER_RD 0x3c7
#define PALETTE_REGISTER_WR 0x3c8
#define PALETTE_DATA 0x3c9

#define VGA256 0x13
#define SVGA256 0x0101
#define TEXT_MODE 0x03

unsigned char far *video_buffer=(char far *)0xA0000000L;
/*---END---*/

/*BMP�����ݽṹ 320*200 256ɫ*/
typedef struct BMP_file						/*�ļ���Ϣ��*/
{
	unsigned int bfType;						/*�ļ����� "BM"*/
	unsigned long bfSize;						/*�ļ�����*/
	unsigned int Reserved1;
	unsigned int Reserved2;
	unsigned long bfOffset;					/*�ļ����������ȣ�16ɫ118��256ɫ1024*/
}bitmapfile;	

typedef struct BMP_info						/*ͼ����Ϣ��*/
{
	unsigned long biSize;						/*ͼ�γߴ�*/
	unsigned long biWidth;					/*ͼ�ο���*/
	unsigned long biHeight;					/*ͼ�θ߶�*/
	unsigned int biPlanes;
	unsigned int biBitCount;				/*ÿ������ռ������λ��*/
	unsigned long biCompression;		/*�Ƿ�ѹ����ʽ*/
	unsigned long biSizeImage;
	unsigned long biXpolsPerMeter;
	unsigned long biYpelsPerMeter;
	unsigned long biClrUsed;
	unsigned long biClrImportant;
}bitmapinfo;

typedef struct RGB_BMP_typ				/*��ɫ����*//*256ɫ=256x4byte*/				
{
	unsigned char blue;
	unsigned char green;
	unsigned char red;
	unsigned char reserved;
}RGB_BMP,*RGB_BMP_ptr;

typedef struct bmp_picture_typ
{
	bitmapfile file;
	bitmapinfo info;
	RGB_BMP palette[256];
	unsigned	char far *buffer;
} bmp_picture, *bmp_picture_ptr;
/*---END---*/
/*��������*/
void	distill_pal(void);
void	distill_pic(void);
/*---END---*/
char	szHelp[]=\
"Syntax is : distill.exe\n"
" You must make sure sylogo.bmp exist.--luobing";
int	main(int	argc,char	*argv[])
{
	int	i=0;
	if(argc==1)
	{
		distill_pal();
		distill_pic();
	}
	if(argc>1)
	{
		for(i=1;i<argc;i++)
		{
			if((argv[i][0] == '/')||(argv[i][0] == '-'))
			{
				switch(argv[i][1])
				{
					case	'?':
					case	'H':
					case	'h':
						printf(szHelp);
						break;
					default:
						printf("Command error.");
						break;
					}
				}
			}
		}
	//
	getch();
	return 0;
}

void	distill_pal(void)
{
	int	i=0;
	FILE	*in,*out;
	RGB_BMP	logopal;
	//Set_SVGA_Mode(SVGA256); 
	//BMP_Load_Screen("sylogo.bmp");
	//
	if((in=fopen("sylogo.bmp","rb"))==NULL)
	{
		printf("Cannot open file:sylogo.bmp.\n");
		exit(1);
	}
	if((out=fopen("logopal.bin","w"))==NULL)
	{
		printf("Cannot creat file:logopal.bin\n");
		exit(1);
	}
	//
	fprintf(out,"logopalatte");
	if(fseek(in,54,0))		//�ƶ�����ɫ����
 	{
 		printf("fseek fail");
 		getch();
 	}
 	for(i=0;i<256;i++)
 	{
 		fread(&logopal,sizeof(logopal),1,in);
 		fprintf(out,"\n						db 0%02xH,",logopal.red);
 		fprintf(out," 0%02xH,",logopal.green);
 		fprintf(out," 0%02xH",logopal.blue);
 	}
 	fclose(in);
 	fclose(out);
}

void	distill_pic(void)
{
	int	i=0,j=0,k=0;
	long	int	logopos;
	unsigned	char	buf;
	unsigned char wchar;
	unsigned char prechar,charcount;
	unsigned char vcount[16];					/*�м�����*/
	unsigned char vi,vj;
	FILE	*in,*out;
	RGB_BMP	logopal;
	//
	if((in=fopen("sylogo.bmp","rb"))==NULL)
	{
		printf("Cannot open file:sylogo.bmp.\n");
		exit(1);
	}
	if((out=fopen("logopic.bin","w"))==NULL)
	{
		printf("Cannot creat file:logopic.\n");
		exit(1);
	}
	//
	fprintf(out,"logopic");
	vi=0;
	prechar=0;
 	charcount=0;
	for(i=LOGO_HEIGHT-1;i>=0;i--)
	{
 		logopos=i*LOGO_WIDTH+1078;
 		if(fseek(in,logopos,0))		//�ƶ���ͼ����
 		{
 			printf("fseek fail.");
 			getch();
 		}
 		for(j=0;j<(LOGO_WIDTH/8);j++)
 		{	
 			wchar=0;
 			for(k=0;k<8;k++)
 			{
 				fread(&buf,sizeof(buf),1,in);
 				if(buf==0x01)
 					wchar|=(1<<k);
 			}
 			if(i==0)
 			{
 				prechar=wchar;				/*��һ�Σ���ʼ��*/
 			}
 			if(wchar==prechar)
 			{
 				charcount++;
 				if(charcount==240)
 				{
 					printf("too much canot compress!");
 					return;
 				}
 			}
 			else
 			{
 				vcount[vi]=prechar;
 				vcount[++vi]=charcount;
 				++vi;
 				/*������ͬ,�õ���ͬ���ַ�������Ŀ*/
 				prechar=wchar;			
 				charcount=1;
 			}
 			if(vi==16)/*���ˣ�д*/
 			{
 				fprintf(out,"\n						db");
 				for(vj=0;vj<15;vj++)
 				{
 					fprintf(out," 0%02xH,",vcount[vj]);
 				}
 				fprintf(out," 0%02xH",vcount[15]);
 				vi=0;
 			}
 		}
 	}
 	fclose(in);
 	fclose(out);
}