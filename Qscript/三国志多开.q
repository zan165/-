[General]
SyntaxVersion=2
BeginHotkey=121
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=cd81c44b-f90a-4777-89c1-e53e82b40dff
Description=����־�࿪
Enable=1
AutoRun=0
[Repeat]
Type=0
Number=1
[SetupUI]
Type=1
QUI=Form1
[Relative]
SetupOCXFile=
[Comment]

[Script]
�豸=2
Dim dm_all(2)//����5������
Set dm = nothing//�������ö���
Dim hwnd(2)
Dim dm_ret(2)
	
	
sw = 700
sh = 420
Dim myPath		//������ַ
Dim isSignUp  //�Ƿ�ע��ɹ�  
isSignUp = 0
Dim isFindWindow //�Ƿ�򿪴���
isFindWindow = 0
Dim hwnd, dm_ret
Dim ��ǰ����
Dim	��ǰ����,��ͭ����������
	��ǰ���� = "����"
	��ͭ���������� = false
Dim presentLevel
Dim presentOwn
Dim presentEnemy
Dim ��������(1)
Dim ��ǰ����(1)
Dim ��·����

��·���� = 2


Dim Ŀ��λ��(1)
	Ŀ��λ��(0) = 439
	Ŀ��λ��(1) = 230
Dim ��ǰλ��(1)
	��ǰλ��(0) = 434
	��ǰλ��(1) = 240
	��·�ȼ� = 4
isFindZhuCheng = false

Dim �Զ���صȼ�
	�Զ���صȼ� =5


�����ļ� = "D:\ajjl\������Ϣ.ini"


Dim �������ص�����Ϣ
 	�������ص�����Ϣ ="D:\ajjl\�������ص�����Ϣ.ini"

Dim ��������������Ϣ
	��������������Ϣ="D:\ajjl\��������������Ϣ.ini"


Dim �ڼ�����������

�ڼ����������� = 0


Call main

////���������������������������������������������������϶���ȫ�ֱ�����������������������������������������������������������������������
//=====================================================================================================
////���������������������������������������������������¶���ȫ�����ú�����������������������������������������������������������������������
///////���� ��ȡϵͳ����
///////���� �رռ����
///////���� ��ȡ��ǰ·��
///////���� ��ȡ���а�����
///////���� ��ȡϵͳʱ��
///////���� ע���Į
///////���� �ж�����־�Ƿ��Ѵ�
///////���� ������Ϸ����
///////���� ע��������


Sub ��ȡϵͳ����
	//��������ǻ����Ļ�ֱ��ʿ��
	ScreenW = Plugin.Sys.GetScRX()
	TracePrint "�����Ļ�ֱ��ʿ�ȣ�"& ScreenW
	//��������ǻ����Ļ�ֱ��ʸ߶�
	ScreenH = Plugin.Sys.GetScRY()
	TracePrint "�����Ļ�ֱ��ʸ߶ȣ�"& ScreenH
	//��������ǻ����Ļɫ���(��ɫ����)
	Dev = Plugin.Sys.GetScDep()
	TracePrint "�����Ļɫ���(��ɫ����)��"& Dev
	//=================================================================================
	//���������������Ļ�ֱ���(1024��768)/��ɫ����(32λ)
//	Call Plugin.Sys.SetSc(1440,900,32)
//	MessageBox "������Ļ�ֱ���"
	shouldchange = 0
	If ScreenW<>1440 Then
		shouldchange=1
	End If
	If ScreenH<>900 Then
		shouldchange=1
	End If
	If Dev<>32 Then
		shouldchange=1
	End If
	If shouldchange =1 Then
		Call Plugin.Sys.SetSc(1440,900,32)
		TracePrint "��Ļ�ֱ��ʸĻ���"
	End If
End Sub

Sub �رռ����
	//=================================================================================
	//��������ǹػ������(ע��)
	Call Plugin.Sys.ExitOS(0)
End Sub

Sub ��ȡ��ǰ·��
	//��������ǻ��(��ǰ·��)
	Path = Plugin.Sys.GetDir(0)
	MessageBox "���·����"& Path
	 
	//=================================================================================
End Sub

Sub ��ȡ���а�����
	//������������ü��а�����
	Call Plugin.Sys.SetCLB("���а�����")
	MessageBox "���ü��а�����"
	//��������ǻ�ü��а�����
	Clipboard = Plugin.Sys.GetCLB()
	MessageBox "��ü��а����ݣ�"& Clipboard
	//=================================================================================
End Sub


Sub ��ȡϵͳʱ��
	//��������Ǿ�׼�ؼ������ʱ���
	s = Plugin.Sys.GetTime()
	xs=int(s/1000/60/60)
	fz=int(s/1000/60)-xs*60
	m=Clng(s/1000)-fz*60-xs*60*60
	MessageBox "���Ĳ���ϵͳ��������Ŀǰ��ʱ�䣺" & xs & "Сʱ" & fz & "����" & m & "��"
	//��������ǵõ�Ӳ�̵�һ�����������к�
	GetSN = Plugin.Sys.GetHDDSN()
	MessageBox "�õ�Ӳ�̵�һ�����������кţ�"& GetSN
	//=================================================================================
End Sub




Sub ע���Į()
	//��¼��ע��״̬
//	TracePrint isSignUp
//	If isSignUp=1 Then 
//	TracePrint "�Ѿ�ע��ɹ������ٴ�ע����"
//		EndScript
//	End If


	myPath = "D:\sgzdk"
	//���ȴ��dm.dll��RegDIl.dll������,��Ȼ����㻹��������Դ(�ֿ⣬ͼƬ��)Ҳ����һ�����
	// ���need_ver��Ϊ���ű���Ҫʹ�õĲ���汾.���Ҫ�����ʱ���ǵø������ֵ.
	need_ver = "3.1230"
	// �����Ҫ�õ�atlϵͳ��,��ЩXP����ϵͳ���atl.dll�����.Ϊ�˷�ֹע��ʧ�ܣ������ֶ�ע��
//	Set ws = createobject("Wsqript.Shell")
//	ws.run "regsvr32 atl.dll /s"
//	set ws=nothing
	// �ͷŸ���>>>>>>>>>>>>>>>>>>>
	// ����ѡ��c�̵�test-_game��Ϊ����Ļ���Ŀ¼Ҳ����SetPath��Ӧ��Ŀ¼������������Դ���ͷŵ�����
	
	PutAttachment myPath, "*.*"
	
	// ����Ҫ�õ�RegDII��ע���������Ա����ͷŵ�Plugin.�����мǲ��ܰ�dm.dlI�ͷŵ�Plugin.
	PutAttachment ".\Plugin", "RegDII.dIl"
	
	// ���ע�Ὺʼ>>>>>>>>>>>>>>>>>>>
	// ���濪ʼע����,�ȳ�����RegDII��ע��.�������ʹ�þ���·���������б��˰�dm.dll�ͷ���
//	Call Plugin.RegDII.Reg ("D:\ajjl\dm.dll")
	
	
		For i = 0 To �豸
		Set dm_all(i) = createobject("dm.dmsoft")//��ֵ5����Į����
		ver = dm_all(i).Ver()
			TracePrint ver
			If ver <> need_ver Then 
				// ���ͷ���ǰ������dm
				isSignUp = 0
				
				// �ٳ�����regsvr32 ��ע��.�������ʹ�þ���·���������б��˰�dm.dll�ͷ���ϵͳĿ¼.��
				Set ws = createobject("Wscript.Shell")
				ws.run "regsvr32 " & myPath & "\dm.dll /s"
				set ws=nothing
				Delay 1500
				// ���жϲ���Ƿ�ע��ɹ�
				Set dm_all(i) = createobject("dm.dmsoft")
				
				ver=dm_all(i).Ver()
				If ver <> need_ver Then 
				// ��ʱ���Ѿ�ȷ�ϲ��ע��ʧ���ˡ�����һЩ������Ϣ���Թ�����.
		//		TracePrint "����汾����,��ǰʹ�õİ汾��:"
				TracePrint ver
		//		TracePrint"��رճ���,���´򿪱������ٳ��ԡ�
				isSignUp = 0
				EndScript
				Else 
				TracePrint "�ڶ���ע��ɹ�"
				isSignUp = 1
				End If
			Else 
				TracePrint "��һ�ξ�ע��ɹ�"
				isSignUp = 1
			End If
		Next
	
	
		For i = 0 To �豸
			Set dm = dm_all(i)
			hwnd(i) =  dm_all(i).FindWindow("EJOY2DX", "��ս")
			TracePrint hwnd(i)
			If hwnd(i) = 0 Then 
				hwnd(i) = dm_all(i).FindWindow("", "����־" & i)
			Else 
				dm_ret(i) = dm.SetWindowText(hwnd(i),"����־"&i) 
			End If
				
				
		
		Next
	

	
	

//		dm_ret = dm_all(i).FindPic(x1,y1,x2,y2,"D:\sgzdk\ǰ����ս.bmp","000000",0.9,0,intX,intY)
//		TracePrint "  intX  " & intX
//		TracePrint "  intY  " & intY
//		
//		If intX >= 0 and intY >= 0 Then
//    		MessageBox "�ҵ�"
//    		Else 
//    		TracePrint "û���ҵ�"
//		End If

	
End Sub



Sub �ж�����־�Ƿ��Ѵ�
		//ǰ̨ģʽ
		
		For i =0 to �豸
			TracePrint hwnd(i)
			If hwnd(i) <= 0 Then 
				MessageBox "û���ҵ���Ϸ����1����ȷ����Ϸ����1�Ѿ���"
			Else 
		//	dm_ret = dm.SetWindowText(hwnd, "��ս01")
			//����Ϸ���洰��
				dm_ret(i) =dm_all(i).BindWindow(hwnd(i),"dx","windows3","windows",1)
				TracePrint "����־ս�԰� ���԰�"&i&"�Ѵ�"
				isFindWindow = 1
			End If
		Next


// display: ǰ̨ ���:ǰ̨����:ǰ̨ ģʽ0
//dm_ret = dm.BindWindow(hwnd,"normal","normal","normal",0)
//
// display: gdi ���:ǰ̨ ����:ǰ̨ ģʽ1
//dm_ret = dm.BindWindow(hwnd,"gdi","normal","normal",1)
//
// display: dx ���:ǰ̨ ����:ǰ̨ ģʽ0
//dm_ret = dm.BindWindow(hwnd,"dx","normal","normal",0)
//
// display: dx ���:windows��̨ ����:windows��̨ ģʽ1
//dm_ret = dm.BindWindow(hwnd,"dx","windows","windows",1)
//
// display: dx ���:dx ��̨ ����: dx��̨ ģʽ1
//dm_ret = dm.BindWindow(hwnd,"dx","dx","dx",1) 
//
// display: dx ���:windows3��̨ ����:windows��̨ ģʽ1
//dm_ret = dm.BindWindow(hwnd,"dx","windows3","windows",1)


End Sub


Sub ������Ϸ����

	For i = 0 To �豸
		
			TracePrint hwnd(i)
			If hwnd(i) <= 0 Then 
			 
				MessageBox "û���ҵ���Ϸ����1����ȷ����Ϸ����1�Ѿ���"
				ExitScript
			Else 
		//	dm_ret = dm.SetWindowText(hwnd, "��ս01")
			//����Ϸ���洰��
				Set dm =  dm_all(i)
				dm_ret(i) = dm.SetWindowSize(hwnd(i), sw, sh)
				 x = int(i mod 2) * sw
//				
				 y = (int(i/2) *sh)-20
//				

				TracePrint "x ==" & x
				TracePrint "y ==" & y
				
				TracePrint "ScreenW ==" & sw
				TracePrint "ScreenH ==" & sh
				dm.MoveWindow hwnd(i),x,y
//

			End If
	Next
	
//	dm_ret = dm.GetWindowRect(hwnd, x1, y1, x2, y2)
//	TracePrint "x1 ==" & x1
//	TracePrint "y1 ==" & y1
//	TracePrint "x2 ==" & x2
//	TracePrint "y2 ==" & y2
//	gScreenW = x2-x1
//	gScreenH = y2-y1
//	TracePrint "gScreenW ==" & gScreenW
//	TracePrint "gScreenH ==" & gScreenH
	
//	dm.MoveWindow hwnd,-10,-30
//	dm2.MoveWindow hwnd,710,-30
End Sub


Sub ע��������

	TracePrint "��ʼע��������"
	//��������ȫ��Ѱ� ����ע����
//	text = Plugin.ZXLOCR.reg("TEST")
	
//	TracePrint "ע��������: "&text
	
	
	TracePrint Plugin.ZXLOCR.Ver
	
//	���°����ص�ַ
//	TracePrint Plugin.ZXLOCR.GXVer
	
	
//	���ط��������������
//	text =  Plugin.ZXLOCR.TTOCR(4,77,1158,673,0)
//	TracePrint text
	
//	���ز鵥��
	
//	TEXT = Plugin.ZXLOCR.LDOCR("F:\OCR���������Ѱ�\OCRdat.dll", 6)
//	
//	TracePrint text
//	
//	txt = Plugin.ZXLOCR.MYOCR(400,25,500,54, 0)
//	TracePrint txt
	
	//�������ocr
//	txt = Plugin.ZXLOCR.QSOCR(400,25,500,54, 0)
//	TracePrint txt
//	

End Sub



Sub ������Ϸ
	
	
		For i = 0 To �豸
		Set dm = dm_all(i)
		TracePrint "sw  "&sw
		TracePrint "sh  "&sh
		TracePrint "sw  "&myPath&"\ǰ����ս.bmp"
		dm_ret = dm_all(i).GetWindowRect(hwnd(i), x1, y1, x2, y2)
		TracePrint "x1  "&x1
		TracePrint "y1  " & y1
		TracePrint "x2  "&x2
		TracePrint "y2  "&y2
//		FindPic  x1, y1, x2, y2,myPath&"\ǰ����ս.bmp",0.9,intX,intY
		If canIfind("ǰ����ս", x1, y1, x2, y2) Then 
			
			Delay 500
    		Else 
    		TracePrint "û���ҵ�"
		End If
		Delay 1000
	
	 Next
	
End Sub


Function canIfind(pName,x1, y1, x2, y2)
		FindPic x1, y1, x2, y2,myPath&"\"&pName&".bmp",0.9,intX,intY
		If intX > 0 And intY > 0 Then 
			TracePrint "�ҵ�"&pName
			canIfind = true
			MoveTo intX,intY
    		Else 
    		TracePrint "û���ҵ�"&pName
    		canIfind = False
		End If
End Function


Sub �������ļ�
	IsFile = Plugin.File.IsFileExist(�������ص�����Ϣ)
	If IsFile Then 
		Call Plugin.File.DeleteFile(�������ص�����Ϣ)
	End If
	
	IsFile = Plugin.File.IsFileExist(��������������Ϣ)
	If IsFile Then 
		Call Plugin.File.DeleteFile(��������������Ϣ)
	End If
	
	
End Sub


Function ��ȡ������Ϣ(Command,Val)
	//��������Ƕ�ȡһ�������ļ�����(С������"Command" ��ֵ����"Val")�õ�����(Text )
	Text = ��ȡ(Command, Val, ��������������Ϣ)
	TracePrint "��ȡ������Ϣ��ֵΪ��" & Text
	��ȡ������Ϣ = Text
End Function

Function д��������Ϣ(Command,Val,����)
	//��������Ǳ���һ�������ļ�����(С������"Command" ��ֵ����"Val" д�����ݣ�"����")
	Call д��(Command, Val, ����, ��������������Ϣ)
	TracePrint "����һ�������ļ���ֵ"
	
End Function



Function ��ȡ������Ϣ(Command,Val)
	//��������Ƕ�ȡһ�������ļ�����(С������"Command" ��ֵ����"Val")�õ�����(Text )
	Text = ��ȡ(Command, Val, �������ص�����Ϣ)
	TracePrint "��ȡ������Ϣ��ֵΪ��" & Text
	��ȡ������Ϣ = Text
End Function

Function д�������Ϣ(Command,Val,����)
	//��������Ǳ���һ�������ļ�����(С������"Command" ��ֵ����"Val" д�����ݣ�"����")
	Call д��(Command, Val, ����, �������ص�����Ϣ)
	TracePrint "����һ�������ļ���ֵ"
	
End Function



Function ��ȡ������Ϣ(Command,Val)
	//��������Ƕ�ȡһ�������ļ�����(С������"Command" ��ֵ����"Val")�õ�����(Text )
	Text = ��ȡ(Command, Val, �����ļ�)
	TracePrint "��ȡ������Ϣ��ֵΪ��" & Text
	��ȡ������Ϣ = Text
End Function

Function д��������Ϣ(Command,Val,����)
	//��������Ǳ���һ�������ļ�����(С������"Command" ��ֵ����"Val" д�����ݣ�"����")
	Call д��(Command, Val, ����, �����ļ�)
	TracePrint "����һ�������ļ���ֵ"
	
End Function


Function ��ȡ(Command, Val, path)
	//��������Ƕ�ȡһ�������ļ�����(С������"Command" ��ֵ����"Val")�õ�����(Text )
	Text = Plugin.File.ReadINI(Command, Val, path)
	��ȡ = Text
End Function

Function д��(Command, Val, ����, path)
	//��������Ǳ���һ�������ļ�����(С������"Command" ��ֵ����"Val" д�����ݣ�"����")
	Call Plugin.File.WriteINI(Command, Val, ����, path)
End Function

//=====================================================================================================
////���������������������������������������������������¶��ǹ��ߺ�����������������������������������������������������������������������
///////���� SZFindPic

/**
*ƴ���ַ�������
*/
 Function mapNames(names, headStr, tailStr, spStr)
 	strAllName = ""
	
	For Each name In names
		If strAllName = "" Then 
		 		strAllName = headStr & "\" & name & tailStr
			Else 
		 		strAllName = "||" & headStr & "\" & name & tailStr
		End If
       	
    Next
    
    mapNames = strAllName
    
 End Function
 

 
   /**
*���ߺ��� ���� �� ����ֵ ˵��
*/
 Function canDmFind(dm,����1, ����2, ����3, ����4,��Դ��)
 	ret = SZFindPic(dm,����1, ����2, ����3, ����4, ��Դ��)
 	If ret(1) > 0 and ret(2) > 0 Then 
 			TracePrint "ȷ�����ҵ�"&��Դ��
 			canDmFind = True
 		Else 
 			canDmFind =False
 	End If
    	
 End Function
 
 
  /**
*���ߺ��� ���� �� ����ֵ ˵��
*/
 Function SZFindPic(dm ,����1,����2,����3,����4, ��Դ��)
// 	TracePrint "��Դ��  " & ��Դ��
// 	TracePrint "·��  "&myPath&"\"&��Դ��&".bmp"
//	TracePrint "��Χ  ��"&����1 & " , "&����2& " , "&����3& " , "& ����4
 	Dim ret(2)
 	dm_ret = dm.FindPic(����1,����2,����3,����4,myPath&"\"&��Դ��&".bmp","000000",0.8,0,intX,intY)
	ret(0) = dm_ret
	ret(1) = intX
	ret(2) = intY
    SZFindPic = ret
 End Function
 
 
 /**
*���ߺ��� ���� �� ����ֵ ˵��
*/
 Function ���ߺ���(����1, ����2, ����3, ����4)
 	
    
 End Function
 


Function �ƶ���(��λ)
	Delay 1500
	dm_ret = dm.FindPic(0,0,1200,800,"D:\ajjl\"& ��λ &".bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "�ҵ�"&��λ
    	dm.moveTo intX, intY
    	Delay 1000
    	
    	
    Else 
    	TracePrint "û���ҵ�"&��λ
    	
	End If
	Delay 50
End Function


Sub ȥ���(λ��)
	Delay 1500
	dm_ret = dm.FindPic(0,0,1200,800,myPath& λ�� &".bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "�ҵ�"&λ��
    	dm.moveTo intX, intY
    	Delay 1000
    	dm.leftclick 
    	
    Else 
    	TracePrint "û���ҵ�"&λ��
    	
	End If
	Delay 50
End Sub

Sub ����ɫ(��ɫֵ)
	dm_ret = dm.FindColor(0,0,1200,800,��ɫֵ,1.0,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "�ҵ���ɫ"&��ɫֵ
    	dm.moveTo intX, intY
    	Delay 1000
    	dm.leftclick 
	End If
End Sub

Sub ���(λ��)
	�ƶ��� λ��
	dm.leftclick 	
End Sub

Sub �����(����X, ����Y)
	Delay 50
	dm.moveto ����X,����Y
	dm.leftclick 
	Delay 50
End Sub



//=====================================================================================================
////���������������������������������������������������¶�����Ϸ�ڱ�����������������������������������������������������������������������
�������� = 0			 // 0,0,1200,50
	
���ϰ�ť = 1  		 // 0,70,300,135
	
���ӵر� = 2			//950,65,1200,200
 
��Ϸ���� = 3			//0,70,1200,650
	
���°�ť = 4			//0,570,140,800

�м䰴ť = 5			//260,650,900,800
	
��ͼ�������� = 6		//0,530,1200,580
	
	
 


//=====================================================================================================
////���������������������������������������������������¶�����Ϸ�ڲ���������������������������������������������������������������������������
///////���� ��ȡ������
/**
*��ս��һ��ͼ ����true �ɹ� false ʧ��
*/
//Function isSZFindPic(��Χ,��Դ��)
//	Dim ret, intX, intY
//	
//	ret = SZFindPic(��Χ, ��Դ��)
//	intX = ret(1)
//	intY = ret(2) 
//	
//	If intX >= 0 and intY >= 0 Then
//    	TracePrint "�ҵ�ͼƬ" & ��Դ��
//    	isSZFindPic = true
//    	Exit Function
//    Else
//    	TracePrint "û���ҵ�ͼƬ" & ��Դ��
//    	isSZFindPic = False
//    	Exit Function	
//	End If
//End Function
///**
//*��ս��һ��ͼ ���� ���꣨1��
//*/
//Function SZFindPicEx(��Χ, ��Դ��)
//	Dim	����(1)
//	dm_ret = dm.FindPic(��Χ(0),��Χ(1),��Χ(2),��Χ(3),myPath&"\"&��Դ��&".bmp","000000",0.9,0,intX,intY)
//	If intX >= 0 and intY >= 0 Then
//    	TracePrint "�ҵ�ͼƬ" & ��Դ��
//    	����(0) = intX
//    	����(1) = intY
//    	Exit Function
//    Else
//    	TracePrint "û���ҵ�ͼƬ" & ��Դ��
//    	����(0) = -1
//    	����(1) = -1
//    	Exit Function	
//	End If
//End Function
//
///**
//*��ս�Ҷ���ͼ ����true �ɹ� false ʧ��
//*/
//Function isSZFindPics(��Χ, ��Դ��)
//	
//
//	Dim strAllPicNamePath
//	
//	strAllPicNamePath = mapNames(��Դ��, myPath, ".bmp", "||")
//	
//	isSZFindPics = isSZFindPic(��Χ, strAllPicNamePath)
//	
//End Function
//
///**
//*��ս�Ҷ���ͼ�е�һ�� ���� ���꣨1��
//*/
//Function SZFindPicsEx(��Χ, ��Դ��)
//	
//	Dim	����(1)
//	dm_ret = dm.FindPic(��Χ(0),��Χ(1),��Χ(2),��Χ(3),myPath&"\"&��Դ��&".bmp","000000",0.9,0,intX,intY)
//	If intX >= 0 and intY >= 0 Then
//    	TracePrint "�ҵ�ͼƬ" & ��Դ��
//    	����(0) = intX
//    	����(1) = intY
//    	Exit Function
//    Else
//    	TracePrint "û���ҵ�ͼƬ" & ��Դ��
//    	����(0) = -1
//    	����(1) = -1
//    	Exit Function	
//	End If
//End Function


Function ��ȡ������
	
	//�Ƿ���������
	
	dm_ret = dm.FindPic(260,650,900,800,"D:\ajjl\��ļ.bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "�ҵ���ļ"
    	��ǰ���� = "������"
    	Exit Function
	End If
	
    dm_ret = dm.FindPic(0,70,300,135,"D:\ajjl\zc.bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "�ҵ�zc"
    	��ǰ���� = "������"
    	Exit Function
	End If

	
	dm_ret = dm.FindPic(0,0,200,200,"D:\ajjl\rw.bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "�ҵ�����"
    	��ǰ���� = "�������"
    	Exit Function
	End If
	
	dm_ret = dm.FindPic(0,0,200,200,"D:\ajjl\zm.bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "�ҵ�����"
    	��ǰ���� = "��ļ����"
    	Exit Function
	End If
	
	dm_ret = dm.FindPic(0,0,200,200,"D:\ajjl\dt.bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "�ҵ�����"
    	��ǰ���� = "��ͼ����"
    	Exit Function
	End If
	
	dm_ret = dm.FindPic(0,0,200,200,"D:\ajjl\zf.bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "�ҵ�����"
    	��ǰ���� = "ս������"
    	Exit Function
	End If
	
	
	dm_ret = dm.FindPic(0,0,200,200,"D:\ajjl\zf.bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "�ҵ�����"
    	��ǰ���� = "ս������"
    	Exit Function
	End If
	
	
	dm_ret = dm.FindPic(0,0,200,200,"D:\ajjl\jz.bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "�ҵ�����"
    	��ǰ���� = "���ǽ���"
    	Exit Function
	End If
	
	
	

	
	
End Function





//=====================================================================================================
////���������������������������������������������������¶�����������ò���������������������������������������������������������������������������

�������� = 0			 // 0,0,1200,50
	
���ϰ�ť = 1  		 // 0,70,300,135
	
���ӵر� = 2			//950,65,1200,200
 
��Ϸ���� = 3			//0,70,1200,650
	
���°�ť = 4			//0,570,140,800

�м䰴ť = 5			//260,650,900,800
	
��ͼ�������� = 6//0,530,1200,580

Function �����ڲ���(����,����,intX,intY)
	intX = - 1 
	intY = - 1 
	TracePrint ����
	TracePrint ����
	TracePrint intX
	TracePrint intY

	Select Case ����
    	Case ��������
        	dm_ret = dm.FindPic(0,0,1200,50, "D:\ajjl\" & ���� & ".bmp", "000000", 0.9, 0, intX, intY)
		
    	Case ���ϰ�ť
       		dm_ret = dm.FindPic(0,70,300,135, "D:\ajjl\" & ���� & ".bmp", "000000", 0.9, 0, intX, intY)
			
    	Case ���ӵر�
        	dm_ret = dm.FindPic(950,65,1200,200, "D:\ajjl\" & ���� & ".bmp", "000000", 0.9, 0, intX, intY)
			
    	Case ��Ϸ����
            	dm_ret = dm.FindPic(0,70,1200,650, "D:\ajjl\" & ���� & ".bmp", "000000", 0.9, 0, intX, intY)
			
    	Case ���°�ť
        	dm_ret = dm.FindPic(0,570,140,800, "D:\ajjl\" & ���� & ".bmp", "000000", 0.9, 0, intX, intY)
			
    	Case �м䰴ť
        	dm_ret = dm.FindPic(260,650,900,800, "D:\ajjl\" & ���� & ".bmp", "000000", 0.9, 0, intX, intY)
			
    	Case ��ͼ��������
        	dm_ret = dm.FindPic(0,530,1200,580, "D:\ajjl\" & ���� & ".bmp", "000000", 0.9, 0, intX, intY)
			
    	Case Else
        	dm_ret = dm.FindPic(0,0,1200,800, "D:\ajjl\" & ���� & ".bmp", "000000", 0.9, 0, intX, intY)
			
	End Select
	If intX >= 0 and intY >= 0 Then
    	TracePrint "�ҵ�  "&����
    	TracePrint intX
    	TracePrint intY
    	
    	Exit Function
    End If
End Function



Sub �жϵ�ǰ����

	Delay 1000
	
	��ȡ������ 
	
	TracePrint "��ǰ����������"&��ǰ����
	
End Sub

Sub �жϵ�ǰ����
	Delay 1000
	

	
	TracePrint "��ǰ���������� "&��ǰ����
End Sub


Sub ��ת��������
	������ذ�ť
	Delay 1000
	�жϵ�ǰ����
	If ��ǰ���� = "������" Then 
		TracePrint "�ѷ���������"
		
	Else 
		TracePrint "���������棬��Ҫ��ת��������"
		��ת��������
	End If 
End Sub

Sub �����������
	�жϵ�ǰ���� 
	
	If ��ǰ���� = "������" Then 
		TracePrint "������������Ե�����"
		dm.moveto 1111, 88
		Delay 500
		dm.leftclick 
	Else 
		TracePrint "���������棬��Ҫ��ת��������"
		��ת��������
	End If 
End Sub

Sub ������home
	�жϵ�ǰ���� 
	
	If ��ǰ���� = "������" Then 
		TracePrint "������������Ե�home"
		dm.moveto 1111, 88
		Delay 500
		dm.leftclick 
		dm.moveto 1050, 131
		Delay 500
		dm.leftclick
		
	Else 
		TracePrint "���������棬��Ҫ��ת��������"
		��ת��������
	End If 
End Sub


Sub �鵱ǰ�ؿ���Ϣ
	
End Sub

Sub ��ת������(aimx, aimy)
	TracePrint "��ת������"& aimx & " , "& aimy
	//��ʱ��Ȼ��������
	//�����ͼ��ť
	dm_ret = dm.FindPic(0,570,115,615,"D:\ajjl\dtan.bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
//    	TracePrint "�ҵ���ͼ��ť"
    	dm.moveTo intX, intY
    	Delay 1000
    	dm.leftclick
    	
    Else 
    	TracePrint "û���ҵ���ͼ��ť"
    	
	End If
	
	Delay 1000
	dm.moveto 934,558
	Delay 1000
    dm.leftclick 
    Delay 500
    KeyDown "BackSpace", 1
    KeyUp "BackSpace", 1
    Delay 50
    KeyDown "BackSpace", 1
    KeyUp "BackSpace", 1
    Delay 50
    KeyDown "BackSpace", 1
    KeyUp "BackSpace", 1
     Delay 50
    KeyDown "BackSpace", 1
    KeyUp "BackSpace", 1
     Delay 50
    KeyDown "Delete", 1
    KeyUp "Delete", 1
     Delay 50
    KeyDown "Delete", 1
    KeyUp "Delete", 1
     Delay 50
    
	Call Plugin.Bkgnd.SendString(hwnd,aimx)

	Delay 500
	dm.moveto 1057,558
	Delay 1000
    dm.leftclick 
    Delay 500
    KeyDown "BackSpace", 1
    KeyUp "BackSpace", 1
    Delay 50
    KeyDown "BackSpace", 1
    KeyUp "BackSpace", 1
    Delay 50
    KeyDown "BackSpace", 1
    KeyUp "BackSpace", 1
     Delay 50
    KeyDown "BackSpace", 1
    KeyUp "BackSpace", 1
     Delay 50
    KeyDown "Delete", 1
    KeyUp "Delete", 1
     Delay 50
    KeyDown "Delete", 1
    KeyUp "Delete", 1
     Delay 50
    
	Call Plugin.Bkgnd.SendString(hwnd,aimy)

	Delay 500
	
	//���ǰ����ť
	dm_ret = dm.FindPic(1077,534,1166,570,"D:\ajjl\qwan.bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "�ҵ���ͼ��ť"
    	dm.moveTo intX, intY
    	Delay 1000
    	dm.leftclick
    	
    Else 
    	TracePrint "û���ҵ�ǰ����ť"
    	
	End If

	Delay 1500
End Sub


Sub ��ռ(aimx,aimy)
	TracePrint "�ҽ�������"
	TracePrint "��ǰλ��(0) "&��ǰλ��(0)
	TracePrint "��ǰλ��(1) "&��ǰλ��(1)
	TracePrint "aimx "&aimx
	TracePrint "aimy "&aimy
	If ��ǰλ��(0) <> aimx or ��ǰλ��(1) <> aimy Then 
		��ת������ aimx,aimy
	End If
	
	//�صĵȼ�
	//TODO
	//�����ռ��ť
	dm_ret = dm.FindPic(0,0,1166,670,"D:\ajjl\gzan.bmp||D:\ajjl\��.bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "�ҵ���ռ��ť"
    	dm.moveTo intX, intY
    	Delay 1000
    	dm.leftclick
    	
    Else 
    	TracePrint "û���ҵ���ռ��ť"
    	
	End If
	Delay 1500
	
	ȥ��� "ͣ��"
	
	
	
	ȥ��� "ʿ��"
	ȥ��� "����"
	ȥ��� "����"
	ȥ��� "����0"
	
	
	Delay 1500
	
	
	
	dm_ret = dm.FindPic(0,0,1166,670,"D:\ajjl\�Զ��سǰ�ť.bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "�ҵ��Զ��سǰ�ť��ť"
    	dm.moveTo intX, intY
    	Delay 1000
    	dm.leftclick
    	
    Else 
    	TracePrint "û���ҵ��Զ��سǰ�ť��ť"
    	
	End If
	
	Delay 1500
	
	dm_ret = dm.FindPic(0,0,1166,670,"D:\ajjl\��ռ��ť.bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "�ҵ���ռ��ť"
    	dm.moveTo intX, intY
    	Delay 1000
    	dm.leftclick
    	
    Else 
    	TracePrint "û���ҵ���ռ��ť"
    	
	End If
	
	
	Delay 1500
	
	dm_ret = dm.FindPic(0,0,1166,670,"D:\ajjl\������ʾ.bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "�ҵ�������ʾ"
    	dm.moveTo intX, intY
    	Delay 1000
    	dm.leftclick
    	
    Else 
    	TracePrint "û���ҵ�������ʾ"
    	
	End If
	
	
	Delay 1500
	
	dm_ret = dm.FindPic(0,0,1166,670,"D:\ajjl\���.bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "�ҵ����"
    	dm.moveTo intX, intY
    	Delay 1000
    	dm.leftclick
    	
    Else 
    	TracePrint "���"
    	
	End If
	
End Sub



Sub ��ռһ������(aimx,aimy)
	If ��ǰ���� = "������" Then 
		��ռ aimx,aimy
	Else 
		TracePrint "���������棬��Ҫ��ת��������"
		��ת�������� 
		Delay 1000
		��ռһ������ aimx, aimy
	End If
	
End Sub

Sub ָ�����鹥ռ(aimx, aimy, ����)
	If ��ǰ���� = "������" Then 
		��ռ aimx,aimy
	Else 
		TracePrint "���������棬��Ҫ��ת��������"
		��ת�������� 
		Delay 1000
		ָ�����鹥ռ aimx, aimy , ����
	End If
End Sub

Sub ������ռ��һ������(aimx, aimy)
	��ת�������� 
	
	�������һ���� 
	��ת��������
	��ռһ������ aimx, aimy
End Sub

Sub ��������
	��ת�������� 
	
	
	///������
	Do
		Delay 1000
		������home
		ȥ��� "���"
	Loop Until canFind(0, 70, 1200, 800, "jz") 
	
	��ǰ���� = "���ǽ���"
End Sub

Sub �������һ
	�������� 
	��� "һ��"
	
End Sub

Sub �������һ����
	�������һ 
	��� "���ٷֱ�"
	��� "ȷ�Ϸֱ�"
End Sub


Sub ���뽨������
	�жϵ�ǰ����
	If ��ǰ���� <> "��������" Then
		�������� 
		��� "jz"
		��ǰ���� = "��������"
	End If
End Sub

Sub ȫ������
	�������� 
	��� "����"
End Sub


//
Sub һ��������·(nowX,nowY,lastStep,����)
	
	Dim offset 
	offset =0
	Do
		TracePrint "����ѭ��"
		TracePrint offset
		Delay 2000
		offset = offset + 1
		lastStep=lastStep -1
		
		
	
		��ռһ������ nowX + offset, nowY +	Int(offset/2)
 
		If lastStep = 0 Then 
			Exit Do
		End If
		
		Delay 95000
	Loop
	
End Sub

Function ��ȡλ����Ϣ(aimx, aimy)

	Dim ������Ϣ(2)
	
	�ؿ�ȼ� = null
	
	�ؿ����� = null
	�ؿ���� = null
	
	txt= ��ȡ������Ϣ(aimx , aimy)
	
	
	
	
//	��ת������ 381, 1439
	��ת������ aimx, aimy
	Delay 1000
	If  txt <> "" Then 
		
		�ؿ�ȼ� = Int(txt)	
		
	Else
	
			txt = Plugin.ZXLOCR.TTOCR(5, 76, 1176, 668, 0)
			
		//	TracePrint txt
		
			Dim ����(12)
			����(0)="�յ�"
			����(1)="1��"
			����(2)="2��"
			����(3)="3��"
			����(4)="4��"
			����(5)="5��"
			����(6)="6��"
			����(7)="7��"
			����(8)="8��"
			����(9)="9��"
			����(10)="10��"
			����(11)="�������"
			����(12)="ɽ"
		
			index = 0
			For 11
				
		
			If InStr(txt, ����(index)) > 0 Then 
				TracePrint "����"&����(index)&"��"
				�ؿ�ȼ� = index
				Exit For
				
			End If
		
			index=index+1	
			Next
			If �ؿ�ȼ� <= 10 Then 
				д��������Ϣ aimx,aimy,�ؿ�ȼ�
			End If
	End If
	
	If canFind(0, 70, 1200, 800, "ɨ��") or canFind(0, 70, 1200, 800, "ɨ��0") Then
		�ؿ����� = 0
	ElseIf canFind(0, 70, 1200, 800, "���" )or canFind(0, 70, 1200, 800, "����") Then
		�ؿ����� = 0
	ElseIf canFind(0, 70, 1200, 800, "����") Then
		�ؿ����� = 2
	ElseIf canFind(0, 70, 1200, 800, "���") Then
		�ؿ����� = 3
	ElseIf canFind(0, 70, 1200, 800, "gzan") Then
		�ؿ����� = 3
	ElseIf canFind(0, 70, 1200, 800, "�鱨") Then
		�ؿ����� = 3
	ElseIf canFind(0, 70, 1200, 800, "�������") Then
		�ؿ����� = 3
	ElseIf canFind(0, 70, 1200, 800, "����") Then
		�ؿ����� = 1
	End If
	
	
	������Ϣ(0) = �ؿ�����
	������Ϣ(1) = �ؿ�ȼ�
	������Ϣ(2) = �ؿ����
	
	
	
	��ȡλ����Ϣ = ������Ϣ
	
End Function




Sub ��ȡ����Χ�ļ���ص���Ϣ(nowx, nowy)
	//381, 1439
	// ���� 380 1439  ���� 380 1439  �� 381 1440  ����382 1440  ����382 1439  �� 381, 1438  
	��ת�������� 
	
	Dim ����(1), ����(1), ��(1), ����(1), ����(1), ��(1)
	����(0) = nowx - 1
	����(1) = nowy - 1
	
	 ��ȡλ����Ϣ ����(0), ����(1) 
	
	
	����(0) = nowx - 1
	����(1) = nowy
	��ȡλ����Ϣ ����(0) ,����(1)
	
	
	��(0) = nowx
	��(1) = nowy + 1
	��ȡλ����Ϣ ��(0) ,��(1)
	
	
	����(0) = nowx + 1
	����(1) = nowy
	��ȡλ����Ϣ ����(0) ,����(1)
	
	
	����(0) = nowx + 1
	����(1) = nowy - 1

	��ȡλ����Ϣ ����(0) ,����(1)
	
	��(0) = nowx 
	��(1) = nowy - 1
	��ȡλ����Ϣ ��(0) ,��(1)
	
	
	 
	
	
End Sub


Sub �����ļ��ť
	If ��ǰ���� = "������" Then 
		ȥ��� "��ļ"
	End If
	
	
End Sub

Sub ������ذ�ť
	dm_ret = dm.FindPic(1000,0,1190,150,"D:\ajjl\fhan.bmp||D:\ajjl\fhan2.bmp||D:\ajjl\fhan3.bmp||D:\ajjl\fhan4.bmp||D:\ajjl\fhan5.bmp||D:\ajjl\xan.bmp||D:\ajjl\x2an.bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "�ҵ����ذ�ť"
    	dm.moveTo intX, intY
    	Delay 1000
    	dm.leftclick
    	
    Else 
    	TracePrint "û���ҵ����ذ�ť"	
	End If
End Sub


Sub �������ǲֿ�
		TracePrint "�������ǲֿ�"
	///������
	
	���뽨������ 
	
//��4��  ��������
dm.moveto 1000, 600

		Delay 1100
		dm.leftclick 
	

		Delay 1100
		dm.leftclick 
		

		Delay 1100
		dm.leftclick 

		Delay 1100
		dm.leftclick 

	
//	ѡ������
dm.moveto 110, 370

		Delay 1100
		dm.leftclick 
	
	
	ȥ�����������
	Delay 1000
End Sub

Sub ����ũ��ʯͷ
	���뽨������
		
		
//	ѡ��ũ��
dm.moveto 600, 300

		Delay 1100
		dm.leftclick 
	
	
	ȥ�����������
	Delay 1000
	//ѡ��ʯͷ
dm.moveto 760, 300

		Delay 1100
		dm.leftclick 
	
	
	ȥ�����������
	
End Sub

Sub �������������Ľ���
	���뽨������ 
	Delay 1500
	If canFind(0, 70, 1200, 800, "��") Then 
		ȥ��� "��"
		ȥ�����������
	End If
	
	If canFind(0, 70, 1200, 800, "��1") Then 
		ȥ��� "��1"
		ȥ�����������
	End If
End Sub

Sub ȥ�����������
	ȥ��� "����"
	ȥ��� "����"
	If ��ͭ���������� Then 
			ȥ��� "ȷ�ϻ���"
		Else 
			ȥ��� "ȷ�ϲ���"
	End If
End Sub

//Sub ��ȡ�ؿ���Ϣ(x, y)
//	��ת��������
//	����������� 
//	��ת������ x, y
//	
//	While isFindZhuCheng = False
//	
//		//�������ocr
//		txt = Plugin.ZXLOCR.QSOCR(4,63,1200,800, 0)
//		TracePrint txt
//		//���ӵر�����3/3(511,1459
//		
//		
//		 ץȡ���� txt
//		 
//		 
//		If ��ǰ����(0) <> ��������(0) and ��ǰ����(1) <> ��������(1) Then 
//			isFindZhuCheng = true
//			
//		End If
//		TracePrint ��ǰ����(0)
//		 TracePrint ��ǰ����(1)
//	Wend
//	
//	
//End Sub


Sub ��ȡ������Ϣ
	��ת��������
	�����������
	
	While isFindZhuCheng = False
	
		//�������ocr
		txt = Plugin.ZXLOCR.TTOCR(951,63,1177,161, 0)
		TracePrint txt
		//���ӵر�����3/3(511,1459
		
		
		 ץȡ���� txt
		 
		 
		If ��ǰ����(0) <> 0 and ��ǰ����(1) <> 0 Then 
			isFindZhuCheng = true
			��������(0) = ��ǰ����(0)
			��������(1) = ��ǰ����(1)
			
		End If
		TracePrint ��������(0)
		 TracePrint ��������(1)
	Wend
	
	
End Sub

Sub ץȡ����(txt)
		��ǰ����(0) = 0
		��ǰ����(1) = 0
		
		position = InStr(txt, "(")
 		position1 = InStr(txt, ")")
 		
 		position2 = InStr(txt, ",")
 		
 		TracePrint "position == " & position & "  position1 == " & position1 &"  position2== "&position2
 		
 		If position > 0 and position2 > position0 and position1 > position2 Then
    		��ǰ����(0) = Mid(txt, position + 1, position2 - position - 1)
        	��ǰ����(1) = Mid(txt, position2 + 1, position1 - position2 - 1)
        	
    		TracePrint ��ǰ����(0)    		
    		TracePrint ��ǰ����(1)    		
    		
    	Else 
     		TracePrint "û��ץȡ������"
    	
		End If
	
End Sub


//=====================================================================================================
////���������������������������������������������������¶��ǽ���������ò���������������������������������������������������������������������������



//=====================================================================================================
////���������������������������������������������������¶��Ƕ������������������������������������������������������������������������������


//=====================================================================================================
////���������������������������������������������������¶�������������������������������������������������������������������������������

Sub ��������
LogStart "D:\a.log"
TracePrint "����־ս�԰濪ʼ��������"
LogStop


Do
	Delay 300
	If canFind(0, 70, 1200, 650, "һľ�ѷ�") Then 
		��ǰ���� = "��������"
		ȥ��� "һľ�ѷ�"
		LogStart "D:\a.log"
		TracePrint "����־ս�԰��������"
		LogStop
		Exit Do
	End If
	
	ȥ��� "��һ��"
	����� 590, 340
	������ذ�ť
	
	Delay 143
	
	If shouldChou Then 
		
		�����ļ��ť
		If canFind(0,70,1200,650,"��ļ2��")= True Then 
			ȥ��� "��ļ2��"
			shouldChou = False
		End If
	End If
	
	If canFind(0,70,1200,650,"ѡ������")= True Then 
		��������
	End If
	If canFind(0,70,1200,650,"�����������")= True Then 
		��������
	End If
	If canFind(0,70,1200,650,"������в�������")= True Then 
		ȥ��� "����"
		ȥ��� "����"
	End If
	If canFind(0,70,1200,650,"�Ӻ�")= True Then 
		ȥ��� "�Ӻ�"
	End If
	If canFind(0,70,1200,650,"����1")= True Then 
		ȥ��� "����1"
	End If
	If canFind(0,70,1200,650,"����")= True Then 
		ȥ��� "����"
	End If
	If canFind(0,650,1200,800,"���ٷֱ�")= True Then 
		ȥ��� "���ٷֱ�"
	End If
	If canFind(0,600,1200,800,"ȷ�Ϸֱ�")= True Then 
		ȥ��� "ȷ�Ϸֱ�"
	End If
	If canFind(0,70,1200,800,"gzan")= True Then 
		ȥ��� "gzan"
	End If
	If canFind(0,70,1200,800,"��ռ��ť")= True Then 
		ȥ��� "��ռ��ť"
	End If
	If canFind(0,70,1200,800,"����")= True Then 
		ȥ��� "����"
	End If
	If canFind(0,70,1200,800,"�س�")= True Then 
		ȥ��� "�س�"
	End If
	If canFind(0,70,1200,800,"����")= True Then 
		ȥ��� "����"
	End If
	If canFind(0,70,1200,800,"����ѡ��")= True Then 
		ȥ��� "����ѡ��"
	End If
	If canFind(0,70,1200,800,"ǹ��")= True Then 
		ȥ��� "ǹ��"
	End If
	If canFind(0,70,1200,800,"�о�")= True Then 
		ȥ��� "�о�"
	End If
	If canFind(0,70,1200,800,"ʿ��")= True Then 
		ȥ��� "ʿ��"
	End If
	If canFind(0,70,1200,800,"ȷ���о�")= True Then 
		ȥ��� "ȷ���о�"
	End If
	If canFind(0,70,1200,800,"����")= True Then 
		ȥ��� "����"
	End If
	If canFind(0,70,1200,800,"ȷ�ϰ�ť")= True Then 
		ȥ��� "ȷ�ϰ�ť"
	End If
	
	
	

Loop Until ��ǰ���� <> "��������"
	
End Sub

//=====================================================================================================
////���������������������������������������������������¶��������򡢡�����������������������������������������������������������������

Sub ÿ30�����ж�һ��
	
End Sub

Sub ��ʱ����
	
End Sub

Sub ̽���ܱ���Ϣ
	//��������  1436 549
	//������Χ��16������
	
	
	
	
	
End Sub


Sub ��ʱռ��
	Delay 1000
	
	path = "D:\ajjl\Ŀ������.txt"    
	fileHandle=Plugin.File.OpenFile(path)     
	fileline = Plugin.File.ReadLine(fileHandle)
	  
	Call Plugin.File.CloseFile(fileHandle)
	
	Dim lenOfStr
	lenOfStr = Len(fileline)
	
	TracePrint "�ļ���һ�������� " & fileline
	
	
	Join(�ַ�������)

	
	
End Sub


Sub ɨ��(λ��)
	��ת�������� 
	�������һ���� 
	��ת��������
	��ת������ Ŀ��λ��(0) ,Ŀ��λ��(1) 
	ȥ��� "ɨ��"
	ȥ��� "ɨ��0"
	
	ȥ��� "ʿ��"
	ȥ��� "����"
	ȥ��� "ȡ���Զ��سǰ�ť"
	ȥ��� "ȷ��ɨ��"
	ȥ��� "���"
End Sub



Sub ��������
	TracePrint "��������"
	dm.moveR 10, 10
	
	��ת�������� 
	
	Dim lastCheckTime
	lastCheckTime = 30
	Dim checkCount
	checkCount =0
	Do
		TracePrint "��������ѭ����"
		dm.MoveR 10, 30
		Delay 100
		lastCheckTime = lastCheckTime - 30
		TracePrint "lastCheckTime  ::"&lastCheckTime
		If lastCheckTime <= 0 Then 
			�������ǲֿ� 
			����ũ��ʯͷ 
			�������������Ľ��� 
			checkCount =checkCount+1
			lastCheckTime = 60 * checkCount
			TracePrint "��һ����������ʱ��:" & lastCheckTime
//			ȫ������
		End If
	
		Delay 30000
	Loop Until ��ǰ���� <> "��������"
	
End Sub

Sub �Զ���·
	TracePrint "�����Զ���·�ݹ�"
	
			If ��ǰλ��(0) = Ŀ��λ��(0) and ��ǰλ��(1) = Ŀ��λ��(1) Then 
				Exit Sub
			Else
			Dim direction
			Dim strDes
			If Ŀ��λ��(0) < ��ǰλ��(0) Then 
				strDes= "��"
			ElseIf Ŀ��λ��(0) > ��ǰλ��(0) Then
				strDes= "��"
			ElseIf Ŀ��λ��(0) = ��ǰλ��(0) Then
				strDes= ""
			
			End If
			
			
			If Ŀ��λ��(1) < ��ǰλ��(1) Then 
				strDes = strDes & "��"
				
			ElseIf Ŀ��λ��(1) > ��ǰλ��(1) Then
				strDes = strDes & "��"
				
			ElseIf Ŀ��λ��(1) = ��ǰλ��(1) Then
				strDes = strDes & ""
			
			End If
			
			If strDes="����" or strDes = "��" Then 
				direction =0
			ElseIf strDes="����" Then
				direction = 1
			ElseIf strDes = "��" Then
				direction = 2
			ElseIf strDes="����"Then
				direction = 3
			ElseIf  strDes="��"or strDes="����" Then
				direction = 4
			ElseIf  strDes="��" Then
				direction = 5
			End If


			TracePrint "Ŀ��λ��(0)  ====  " & Ŀ��λ��(0)
			TracePrint "Ŀ��λ��(1)  ====  " & Ŀ��λ��(1)
			TracePrint "��ǰλ��(0)  ====  " & ��ǰλ��(0)
			TracePrint "��ǰλ��(1)  ====  "&��ǰλ��(1)
			TracePrint "direction  ====  " & direction
			
//			Randomize
//			//�õ� 1~99999999 ֮���һ�������
//			x = (Int((15 * Rnd) + 1) mod 3 )-1
//			
//			direction=direction+x
			points = getNextPoints(��ǰλ��(0), ��ǰλ��(1), (direction + i) mod 6)
//			TracePrint String.Join(",", points)
			 
			For i = 0 To 5
			If points(i)(0) = Ŀ��λ��(0) and points(i)(1) = Ŀ��λ��(1) Then 
				��ǰλ��(0) = points(i)(0)
				��ǰλ��(1) = points(i)(1)
				Exit For
			End If
			
			 ret = ��ȡλ����Ϣ(points(i)(0), points(i)(1))
			 TracePrint "�ؿ����� " & ret(0) & "  �ؿ�ȼ� " & ret(1)
			 Delay 1000
			 
				If ret(0) = 0 Then 
					
					TracePrint "�ؿ��������Լ� "
					
				ElseIf ret(0) = 3 and ret(1) < ��·�ȼ� Then
				TracePrint "��ǰλ�ñ�� "& points(i)(0) &"��"&points(i)(1)
					��ǰλ��(0) = points(i)(0)
					��ǰλ��(1) = points(i)(1)
					��ռһ������ points(i)(0),points(i)(1)
					
					Delay  120000
					Exit For
				Else 
					TracePrint "�ؿ����� "&ret(0)  &"  �ؿ�ȼ� "&ret(1)
				End If
			Next
				�Զ���·
			End If
			
			 
	
	End Sub
	
	
	
	
	
	Function getNextPoints(x, y, firstDirection)
		////derection :: 0:����  1������ 2���� 3 ���� 4 ����  5 ��
		Dim Points(5)
		Dim Directions(5)
		Directions(0) = firstDirection
		
		Directions(1) = (firstDirection +1) mod 6
		Directions(2) = (firstDirection -1) mod 6
		Directions(3) = (firstDirection +2) mod 6
		Directions(4) = (firstDirection -2) mod 6
		Directions(5) = (firstDirection +3) mod 6
		
		For i = 0 To 5
			derection = Directions(i)
			Dim Point(1)
			Select Case derection
				Case 0
				
					Point(0) = x - 1
				 	If x mod 2 = 0 Then 
				 		Point(1) = y - 1
				 	Else 
				 		Point(1) = y
				 	End If 
				Case 1
				
					Point(0) = x - 1
				 	If x mod 2 = 0 Then 
				 		Point(1) = y 
				 	Else 
				 		Point(1) = y + 1
				 	End If 
				Case 2
				
					Point(0) = x
					Point(1) = y + 1
				
				Case 3
				
					Point(0) = x + 1
				 	If x mod 2 = 0 Then 
				 		Point(1) = y 
				 	Else 
				 		Point(1) = y + 1
				 	End If 
				Case 4
					
					Point(0) = x + 1
					If x mod 2 = 0 Then 
				 		Point(1) = y - 1
				 	Else 
				 		Point(1) = y
				 	End If 
				Case 5
				
					Point(0) = x
					Point(1) = y - 1
			End Select
			Points(i) =Point
		Next
		
		getNextPoints = Points
	End Function
	

//=====================================================================================================
////���������������������������������������������������¶�����������������������������������������������������������������������������

Sub main

///ע��׼��
	ע���Į 
	��ȡϵͳ���� 
	
	�ж�����־�Ƿ��Ѵ� 
	������Ϸ���� 
	
	ע�������� 
		
	������Ϸ
//	�жϵ�ǰ����
//	
//	�жϵ�ǰ���� 
//	
//	
//	�������ļ�
//	
	
	
//	��ȡ����Χ�ļ���ص���Ϣ 381, 1439
	// ���� 380 1439  ���� 380 1439  �� 381 1440  ����382 1440  ����382 1439  �� 381, 1438  
//	��ȡλ����Ϣ
//	��ǰ���� = "����"

//	��ȡ������Ϣ

	
	Do 
	
	If ��ǰ���� = "��������" Then 
			�������� 
			
	End If
	
	If ��ǰ���� = "��������" Then
		��������
	End If
	
	If ��ǰ���� = "�Զ���·" Then
		�Զ���· 
	End If
	
	
	If ��ǰ���� = "ɨ��" Then 
		For 13
			ɨ�� Ŀ��λ��
			Delay 120*1000
		Next
		��ǰ���� = "��������"
	End If
	
	
	If ��ǰ���� = "��ʱռ��" Then 
		For 10
			��ʱռ�� 
		Next
	End If
	
	
	TracePrint "һ���Ӻ����¿�ʼ����"
	Delay 60000
	Loop
	
//	
//ռ��һ������ 510, 1464

	
//	��ȡ������Ϣ 
//	��ȡ�ؿ���Ϣ 507,1459
	
//	//�������ocr
//	txt = Plugin.ZXLOCR.QSOCR(951,63,1177,161, 0)
//	TracePrint txt
//	
	
	
	
End Sub
