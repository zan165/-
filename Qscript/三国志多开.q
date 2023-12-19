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
Description=三国志多开
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
设备=2
Dim dm_all(2)//创建5个对象
Set dm = nothing//声明公用对象
Dim hwnd(2)
Dim dm_ret(2)
	
	
sw = 700
sh = 420
Dim myPath		//附件地址
Dim isSignUp  //是否注册成功  
isSignUp = 0
Dim isFindWindow //是否打开窗口
isFindWindow = 0
Dim hwnd, dm_ret
Dim 当前界面
Dim	当前任务,用铜币升级建筑
	当前任务 = "其他"
	用铜币升级建筑 = false
Dim presentLevel
Dim presentOwn
Dim presentEnemy
Dim 主城坐标(1)
Dim 当前坐标(1)
Dim 铺路队伍

铺路队伍 = 2


Dim 目标位置(1)
	目标位置(0) = 439
	目标位置(1) = 230
Dim 当前位置(1)
	当前位置(0) = 434
	当前位置(1) = 240
	铺路等级 = 4
isFindZhuCheng = false

Dim 自动打地等级
	自动打地等级 =5


土地文件 = "D:\ajjl\土地信息.ini"


Dim 缓存土地敌人信息
 	缓存土地敌人信息 ="D:\ajjl\缓存土地敌人信息.ini"

Dim 缓存土地守卫信息
	缓存土地守卫信息="D:\ajjl\缓存土地守卫信息.ini"


Dim 第几次升级建筑

第几次升级建筑 = 0


Call main

////、、、、、、、、、、、、、、、、、、、、、、、、以上都是全局变量、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、
//=====================================================================================================
////、、、、、、、、、、、、、、、、、、、、、、、、以下都是全局配置函数、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、
///////包括 获取系统配置
///////包括 关闭计算机
///////包括 获取当前路径
///////包括 获取剪切板内容
///////包括 获取系统时间
///////包括 注册大漠
///////包括 判断三国志是否已打开
///////包括 配置游戏窗口
///////包括 注册佐晓鹭


Sub 获取系统配置
	//下面这句是获得屏幕分辨率宽度
	ScreenW = Plugin.Sys.GetScRX()
	TracePrint "获得屏幕分辨率宽度："& ScreenW
	//下面这句是获得屏幕分辨率高度
	ScreenH = Plugin.Sys.GetScRY()
	TracePrint "获得屏幕分辨率高度："& ScreenH
	//下面这句是获得屏幕色深度(颜色质量)
	Dev = Plugin.Sys.GetScDep()
	TracePrint "获得屏幕色深度(颜色质量)："& Dev
	//=================================================================================
	//下面这句是设置屏幕分辨率(1024×768)/颜色质量(32位)
//	Call Plugin.Sys.SetSc(1440,900,32)
//	MessageBox "设置屏幕分辨率"
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
		TracePrint "屏幕分辨率改回来"
	End If
End Sub

Sub 关闭计算机
	//=================================================================================
	//下面这句是关机计算机(注销)
	Call Plugin.Sys.ExitOS(0)
End Sub

Sub 获取当前路径
	//下面这句是获得(当前路径)
	Path = Plugin.Sys.GetDir(0)
	MessageBox "获得路径："& Path
	 
	//=================================================================================
End Sub

Sub 获取剪切板内容
	//下面这句是设置剪切板内容
	Call Plugin.Sys.SetCLB("剪切板内容")
	MessageBox "设置剪切板内容"
	//下面这句是获得剪切板内容
	Clipboard = Plugin.Sys.GetCLB()
	MessageBox "获得剪切板内容："& Clipboard
	//=================================================================================
End Sub


Sub 获取系统时间
	//下面这句是精准地计算毫秒时间差
	s = Plugin.Sys.GetTime()
	xs=int(s/1000/60/60)
	fz=int(s/1000/60)-xs*60
	m=Clng(s/1000)-fz*60-xs*60*60
	MessageBox "您的操作系统从启动到目前的时间：" & xs & "小时" & fz & "分钟" & m & "秒"
	//下面这句是得到硬盘第一个分区的序列号
	GetSN = Plugin.Sys.GetHDDSN()
	MessageBox "得到硬盘第一个分区的序列号："& GetSN
	//=================================================================================
End Sub




Sub 注册大漠()
	//记录的注册状态
//	TracePrint isSignUp
//	If isSignUp=1 Then 
//	TracePrint "已经注册成功不用再次注册了"
//		EndScript
//	End If


	myPath = "D:\sgzdk"
	//首先打包dm.dll和RegDIl.dll到附件,当然如果你还有其它资源(字库，图片等)也可以一并打包
	// 这个need_ver作为本脚本需要使用的插件版本.如果要换插件时，记得更改这个值.
	need_ver = "3.1230"
	// 插件需要用到atl系统库,有些XP精简系统会把atl.dll精简掉.为了防止注册失败，这里手动注册
//	Set ws = createobject("Wsqript.Shell")
//	ws.run "regsvr32 atl.dll /s"
//	set ws=nothing
	// 释放附件>>>>>>>>>>>>>>>>>>>
	// 这里选择c盘的test-_game作为插件的基本目录也就是SetPath对应的目录。所以所有资源都释放到这里
	
	PutAttachment myPath, "*.*"
	
	// 这里要用到RegDII来注册插件，所以必须释放到Plugin.但是切记不能把dm.dlI释放到Plugin.
	PutAttachment ".\Plugin", "RegDII.dIl"
	
	// 插件注册开始>>>>>>>>>>>>>>>>>>>
	// 下面开始注册插件,先尝试用RegDII来注册.这里必须使用绝对路径。以免有别人把dm.dll释放在
//	Call Plugin.RegDII.Reg ("D:\ajjl\dm.dll")
	
	
		For i = 0 To 设备
		Set dm_all(i) = createobject("dm.dmsoft")//赋值5个大漠对象
		ver = dm_all(i).Ver()
			TracePrint ver
			If ver <> need_ver Then 
				// 先释放先前创建的dm
				isSignUp = 0
				
				// 再尝试用regsvr32 来注册.这里必须使用绝对路径。以免有别人把dm.dll释放在系统目录.造
				Set ws = createobject("Wscript.Shell")
				ws.run "regsvr32 " & myPath & "\dm.dll /s"
				set ws=nothing
				Delay 1500
				// 再判断插件是否注册成功
				Set dm_all(i) = createobject("dm.dmsoft")
				
				ver=dm_all(i).Ver()
				If ver <> need_ver Then 
				// 这时，已经确认插件注册失败了。弹出一些调试信息，以供分析.
		//		TracePrint "插件版本错误,当前使用的版本是:"
				TracePrint ver
		//		TracePrint"请关闭程序,重新打开本程序再尝试”
				isSignUp = 0
				EndScript
				Else 
				TracePrint "第二次注册成功"
				isSignUp = 1
				End If
			Else 
				TracePrint "第一次就注册成功"
				isSignUp = 1
			End If
		Next
	
	
		For i = 0 To 设备
			Set dm = dm_all(i)
			hwnd(i) =  dm_all(i).FindWindow("EJOY2DX", "三战")
			TracePrint hwnd(i)
			If hwnd(i) = 0 Then 
				hwnd(i) = dm_all(i).FindWindow("", "三国志" & i)
			Else 
				dm_ret(i) = dm.SetWindowText(hwnd(i),"三国志"&i) 
			End If
				
				
		
		Next
	

	
	

//		dm_ret = dm_all(i).FindPic(x1,y1,x2,y2,"D:\sgzdk\前往征战.bmp","000000",0.9,0,intX,intY)
//		TracePrint "  intX  " & intX
//		TracePrint "  intY  " & intY
//		
//		If intX >= 0 and intY >= 0 Then
//    		MessageBox "找到"
//    		Else 
//    		TracePrint "没有找到"
//		End If

	
End Sub



Sub 判断三国志是否已打开
		//前台模式
		
		For i =0 to 设备
			TracePrint hwnd(i)
			If hwnd(i) <= 0 Then 
				MessageBox "没有找到游戏窗口1，请确认游戏窗口1已经打开"
			Else 
		//	dm_ret = dm.SetWindowText(hwnd, "三战01")
			//绑定游戏界面窗口
				dm_ret(i) =dm_all(i).BindWindow(hwnd(i),"dx","windows3","windows",1)
				TracePrint "三国志战略版 电脑版"&i&"已打开"
				isFindWindow = 1
			End If
		Next


// display: 前台 鼠标:前台键盘:前台 模式0
//dm_ret = dm.BindWindow(hwnd,"normal","normal","normal",0)
//
// display: gdi 鼠标:前台 键盘:前台 模式1
//dm_ret = dm.BindWindow(hwnd,"gdi","normal","normal",1)
//
// display: dx 鼠标:前台 键盘:前台 模式0
//dm_ret = dm.BindWindow(hwnd,"dx","normal","normal",0)
//
// display: dx 鼠标:windows后台 键盘:windows后台 模式1
//dm_ret = dm.BindWindow(hwnd,"dx","windows","windows",1)
//
// display: dx 鼠标:dx 后台 键盘: dx后台 模式1
//dm_ret = dm.BindWindow(hwnd,"dx","dx","dx",1) 
//
// display: dx 鼠标:windows3后台 键盘:windows后台 模式1
//dm_ret = dm.BindWindow(hwnd,"dx","windows3","windows",1)


End Sub


Sub 配置游戏窗口

	For i = 0 To 设备
		
			TracePrint hwnd(i)
			If hwnd(i) <= 0 Then 
			 
				MessageBox "没有找到游戏窗口1，请确认游戏窗口1已经打开"
				ExitScript
			Else 
		//	dm_ret = dm.SetWindowText(hwnd, "三战01")
			//绑定游戏界面窗口
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


Sub 注册佐晓鹭

	TracePrint "开始注册佐晓鹭"
	//佐晓鹭完全免费版 不用注册了
//	text = Plugin.ZXLOCR.reg("TEST")
	
//	TracePrint "注册佐晓鹭: "&text
	
	
	TracePrint Plugin.ZXLOCR.Ver
	
//	最新版下载地址
//	TracePrint Plugin.ZXLOCR.GXVer
	
	
//	本地服务器查多行文字
//	text =  Plugin.ZXLOCR.TTOCR(4,77,1158,673,0)
//	TracePrint text
	
//	本地查单行
	
//	TEXT = Plugin.ZXLOCR.LDOCR("F:\OCR插件永久免费版\OCRdat.dll", 6)
//	
//	TracePrint text
//	
//	txt = Plugin.ZXLOCR.MYOCR(400,25,500,54, 0)
//	TracePrint txt
	
	//网络调用ocr
//	txt = Plugin.ZXLOCR.QSOCR(400,25,500,54, 0)
//	TracePrint txt
//	

End Sub



Sub 进入游戏
	
	
		For i = 0 To 设备
		Set dm = dm_all(i)
		TracePrint "sw  "&sw
		TracePrint "sh  "&sh
		TracePrint "sw  "&myPath&"\前往征战.bmp"
		dm_ret = dm_all(i).GetWindowRect(hwnd(i), x1, y1, x2, y2)
		TracePrint "x1  "&x1
		TracePrint "y1  " & y1
		TracePrint "x2  "&x2
		TracePrint "y2  "&y2
//		FindPic  x1, y1, x2, y2,myPath&"\前往征战.bmp",0.9,intX,intY
		If canIfind("前往征战", x1, y1, x2, y2) Then 
			
			Delay 500
    		Else 
    		TracePrint "没有找到"
		End If
		Delay 1000
	
	 Next
	
End Sub


Function canIfind(pName,x1, y1, x2, y2)
		FindPic x1, y1, x2, y2,myPath&"\"&pName&".bmp",0.9,intX,intY
		If intX > 0 And intY > 0 Then 
			TracePrint "找到"&pName
			canIfind = true
			MoveTo intX,intY
    		Else 
    		TracePrint "没有找到"&pName
    		canIfind = False
		End If
End Function


Sub 清理缓存文件
	IsFile = Plugin.File.IsFileExist(缓存土地敌人信息)
	If IsFile Then 
		Call Plugin.File.DeleteFile(缓存土地敌人信息)
	End If
	
	IsFile = Plugin.File.IsFileExist(缓存土地守卫信息)
	If IsFile Then 
		Call Plugin.File.DeleteFile(缓存土地守卫信息)
	End If
	
	
End Sub


Function 读取守卫信息(Command,Val)
	//下面这句是读取一个配置文件参数(小节名："Command" 键值名："Val")得到内容(Text )
	Text = 读取(Command, Val, 缓存土地守卫信息)
	TracePrint "读取土地信息键值为：" & Text
	读取守卫信息 = Text
End Function

Function 写入守卫信息(Command,Val,内容)
	//下面这句是保存一个配置文件参数(小节名："Command" 键值名："Val" 写入内容："内容")
	Call 写入(Command, Val, 内容, 缓存土地守卫信息)
	TracePrint "保存一个配置文件键值"
	
End Function



Function 读取敌人信息(Command,Val)
	//下面这句是读取一个配置文件参数(小节名："Command" 键值名："Val")得到内容(Text )
	Text = 读取(Command, Val, 缓存土地敌人信息)
	TracePrint "读取土地信息键值为：" & Text
	读取敌人信息 = Text
End Function

Function 写入敌人信息(Command,Val,内容)
	//下面这句是保存一个配置文件参数(小节名："Command" 键值名："Val" 写入内容："内容")
	Call 写入(Command, Val, 内容, 缓存土地敌人信息)
	TracePrint "保存一个配置文件键值"
	
End Function



Function 读取土地信息(Command,Val)
	//下面这句是读取一个配置文件参数(小节名："Command" 键值名："Val")得到内容(Text )
	Text = 读取(Command, Val, 土地文件)
	TracePrint "读取土地信息键值为：" & Text
	读取土地信息 = Text
End Function

Function 写入土地信息(Command,Val,内容)
	//下面这句是保存一个配置文件参数(小节名："Command" 键值名："Val" 写入内容："内容")
	Call 写入(Command, Val, 内容, 土地文件)
	TracePrint "保存一个配置文件键值"
	
End Function


Function 读取(Command, Val, path)
	//下面这句是读取一个配置文件参数(小节名："Command" 键值名："Val")得到内容(Text )
	Text = Plugin.File.ReadINI(Command, Val, path)
	读取 = Text
End Function

Function 写入(Command, Val, 内容, path)
	//下面这句是保存一个配置文件参数(小节名："Command" 键值名："Val" 写入内容："内容")
	Call Plugin.File.WriteINI(Command, Val, 内容, path)
End Function

//=====================================================================================================
////、、、、、、、、、、、、、、、、、、、、、、、、以下都是工具函数、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、
///////包括 SZFindPic

/**
*拼接字符串名字
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
*工具函数 参数 和 返回值 说明
*/
 Function canDmFind(dm,参数1, 参数2, 参数3, 参数4,资源名)
 	ret = SZFindPic(dm,参数1, 参数2, 参数3, 参数4, 资源名)
 	If ret(1) > 0 and ret(2) > 0 Then 
 			TracePrint "确认能找到"&资源名
 			canDmFind = True
 		Else 
 			canDmFind =False
 	End If
    	
 End Function
 
 
  /**
*工具函数 参数 和 返回值 说明
*/
 Function SZFindPic(dm ,参数1,参数2,参数3,参数4, 资源名)
// 	TracePrint "资源名  " & 资源名
// 	TracePrint "路径  "&myPath&"\"&资源名&".bmp"
//	TracePrint "范围  ："&参数1 & " , "&参数2& " , "&参数3& " , "& 参数4
 	Dim ret(2)
 	dm_ret = dm.FindPic(参数1,参数2,参数3,参数4,myPath&"\"&资源名&".bmp","000000",0.8,0,intX,intY)
	ret(0) = dm_ret
	ret(1) = intX
	ret(2) = intY
    SZFindPic = ret
 End Function
 
 
 /**
*工具函数 参数 和 返回值 说明
*/
 Function 工具函数(参数1, 参数2, 参数3, 参数4)
 	
    
 End Function
 


Function 移动到(定位)
	Delay 1500
	dm_ret = dm.FindPic(0,0,1200,800,"D:\ajjl\"& 定位 &".bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "找到"&定位
    	dm.moveTo intX, intY
    	Delay 1000
    	
    	
    Else 
    	TracePrint "没有找到"&定位
    	
	End If
	Delay 50
End Function


Sub 去点击(位置)
	Delay 1500
	dm_ret = dm.FindPic(0,0,1200,800,myPath& 位置 &".bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "找到"&位置
    	dm.moveTo intX, intY
    	Delay 1000
    	dm.leftclick 
    	
    Else 
    	TracePrint "没有找到"&位置
    	
	End If
	Delay 50
End Sub

Sub 点颜色(颜色值)
	dm_ret = dm.FindColor(0,0,1200,800,颜色值,1.0,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "找到颜色"&颜色值
    	dm.moveTo intX, intY
    	Delay 1000
    	dm.leftclick 
	End If
End Sub

Sub 点击(位置)
	移动到 位置
	dm.leftclick 	
End Sub

Sub 鼠标点击(坐标X, 坐标Y)
	Delay 50
	dm.moveto 坐标X,坐标Y
	dm.leftclick 
	Delay 50
End Sub



//=====================================================================================================
////、、、、、、、、、、、、、、、、、、、、、、、、以下都是游戏内变量、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、
顶部区域 = 0			 // 0,0,1200,50
	
左上按钮 = 1  		 // 0,70,300,135
	
部队地标 = 2			//950,65,1200,200
 
游戏区域 = 3			//0,70,1200,650
	
左下按钮 = 4			//0,570,140,800

中间按钮 = 5			//260,650,900,800
	
地图坐标区域 = 6		//0,530,1200,580
	
	
 


//=====================================================================================================
////、、、、、、、、、、、、、、、、、、、、、、、、以下都是游戏内操作函数、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、
///////包括 获取界面名
/**
*三战找一张图 返回true 成功 false 失败
*/
//Function isSZFindPic(范围,资源名)
//	Dim ret, intX, intY
//	
//	ret = SZFindPic(范围, 资源名)
//	intX = ret(1)
//	intY = ret(2) 
//	
//	If intX >= 0 and intY >= 0 Then
//    	TracePrint "找到图片" & 资源名
//    	isSZFindPic = true
//    	Exit Function
//    Else
//    	TracePrint "没有找到图片" & 资源名
//    	isSZFindPic = False
//    	Exit Function	
//	End If
//End Function
///**
//*三战找一张图 返回 坐标（1）
//*/
//Function SZFindPicEx(范围, 资源名)
//	Dim	坐标(1)
//	dm_ret = dm.FindPic(范围(0),范围(1),范围(2),范围(3),myPath&"\"&资源名&".bmp","000000",0.9,0,intX,intY)
//	If intX >= 0 and intY >= 0 Then
//    	TracePrint "找到图片" & 资源名
//    	坐标(0) = intX
//    	坐标(1) = intY
//    	Exit Function
//    Else
//    	TracePrint "没有找到图片" & 资源名
//    	坐标(0) = -1
//    	坐标(1) = -1
//    	Exit Function	
//	End If
//End Function
//
///**
//*三战找多张图 返回true 成功 false 失败
//*/
//Function isSZFindPics(范围, 资源名)
//	
//
//	Dim strAllPicNamePath
//	
//	strAllPicNamePath = mapNames(资源名, myPath, ".bmp", "||")
//	
//	isSZFindPics = isSZFindPic(范围, strAllPicNamePath)
//	
//End Function
//
///**
//*三战找多张图中的一张 返回 坐标（1）
//*/
//Function SZFindPicsEx(范围, 资源名)
//	
//	Dim	坐标(1)
//	dm_ret = dm.FindPic(范围(0),范围(1),范围(2),范围(3),myPath&"\"&资源名&".bmp","000000",0.9,0,intX,intY)
//	If intX >= 0 and intY >= 0 Then
//    	TracePrint "找到图片" & 资源名
//    	坐标(0) = intX
//    	坐标(1) = intY
//    	Exit Function
//    Else
//    	TracePrint "没有找到图片" & 资源名
//    	坐标(0) = -1
//    	坐标(1) = -1
//    	Exit Function	
//	End If
//End Function


Function 获取界面名
	
	//是否是主界面
	
	dm_ret = dm.FindPic(260,650,900,800,"D:\ajjl\招募.bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "找到招募"
    	当前界面 = "主界面"
    	Exit Function
	End If
	
    dm_ret = dm.FindPic(0,70,300,135,"D:\ajjl\zc.bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "找到zc"
    	当前界面 = "主界面"
    	Exit Function
	End If

	
	dm_ret = dm.FindPic(0,0,200,200,"D:\ajjl\rw.bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "找到界面"
    	当前界面 = "任务界面"
    	Exit Function
	End If
	
	dm_ret = dm.FindPic(0,0,200,200,"D:\ajjl\zm.bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "找到界面"
    	当前界面 = "招募界面"
    	Exit Function
	End If
	
	dm_ret = dm.FindPic(0,0,200,200,"D:\ajjl\dt.bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "找到界面"
    	当前界面 = "地图界面"
    	Exit Function
	End If
	
	dm_ret = dm.FindPic(0,0,200,200,"D:\ajjl\zf.bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "找到界面"
    	当前界面 = "战法界面"
    	Exit Function
	End If
	
	
	dm_ret = dm.FindPic(0,0,200,200,"D:\ajjl\zf.bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "找到界面"
    	当前界面 = "战法界面"
    	Exit Function
	End If
	
	
	dm_ret = dm.FindPic(0,0,200,200,"D:\ajjl\jz.bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "找到界面"
    	当前界面 = "主城界面"
    	Exit Function
	End If
	
	
	

	
	
End Function





//=====================================================================================================
////、、、、、、、、、、、、、、、、、、、、、、、、以下都是主界面调用操作函数、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、

顶部区域 = 0			 // 0,0,1200,50
	
左上按钮 = 1  		 // 0,70,300,135
	
部队地标 = 2			//950,65,1200,200
 
游戏区域 = 3			//0,70,1200,650
	
左下按钮 = 4			//0,570,140,800

中间按钮 = 5			//260,650,900,800
	
地图坐标区域 = 6//0,530,1200,580

Function 界面内查找(区域,名称,intX,intY)
	intX = - 1 
	intY = - 1 
	TracePrint 区域
	TracePrint 名称
	TracePrint intX
	TracePrint intY

	Select Case 区域
    	Case 顶部区域
        	dm_ret = dm.FindPic(0,0,1200,50, "D:\ajjl\" & 名称 & ".bmp", "000000", 0.9, 0, intX, intY)
		
    	Case 左上按钮
       		dm_ret = dm.FindPic(0,70,300,135, "D:\ajjl\" & 名称 & ".bmp", "000000", 0.9, 0, intX, intY)
			
    	Case 部队地标
        	dm_ret = dm.FindPic(950,65,1200,200, "D:\ajjl\" & 名称 & ".bmp", "000000", 0.9, 0, intX, intY)
			
    	Case 游戏区域
            	dm_ret = dm.FindPic(0,70,1200,650, "D:\ajjl\" & 名称 & ".bmp", "000000", 0.9, 0, intX, intY)
			
    	Case 左下按钮
        	dm_ret = dm.FindPic(0,570,140,800, "D:\ajjl\" & 名称 & ".bmp", "000000", 0.9, 0, intX, intY)
			
    	Case 中间按钮
        	dm_ret = dm.FindPic(260,650,900,800, "D:\ajjl\" & 名称 & ".bmp", "000000", 0.9, 0, intX, intY)
			
    	Case 地图坐标区域
        	dm_ret = dm.FindPic(0,530,1200,580, "D:\ajjl\" & 名称 & ".bmp", "000000", 0.9, 0, intX, intY)
			
    	Case Else
        	dm_ret = dm.FindPic(0,0,1200,800, "D:\ajjl\" & 名称 & ".bmp", "000000", 0.9, 0, intX, intY)
			
	End Select
	If intX >= 0 and intY >= 0 Then
    	TracePrint "找到  "&名称
    	TracePrint intX
    	TracePrint intY
    	
    	Exit Function
    End If
End Function



Sub 判断当前界面

	Delay 1000
	
	获取界面名 
	
	TracePrint "当前界面名字是"&当前界面
	
End Sub

Sub 判断当前任务
	Delay 1000
	

	
	TracePrint "当前任务名字是 "&当前任务
End Sub


Sub 跳转回主界面
	点击返回按钮
	Delay 1000
	判断当前界面
	If 当前界面 = "主界面" Then 
		TracePrint "已返回主界面"
		
	Else 
		TracePrint "不在主界面，需要跳转回主界面"
		跳转回主界面
	End If 
End Sub

Sub 主界面点坐标
	判断当前界面 
	
	If 当前界面 = "主界面" Then 
		TracePrint "已在主界面可以点坐标"
		dm.moveto 1111, 88
		Delay 500
		dm.leftclick 
	Else 
		TracePrint "不在主界面，需要跳转回主界面"
		跳转回主界面
	End If 
End Sub

Sub 主界面home
	判断当前界面 
	
	If 当前界面 = "主界面" Then 
		TracePrint "已在主界面可以点home"
		dm.moveto 1111, 88
		Delay 500
		dm.leftclick 
		dm.moveto 1050, 131
		Delay 500
		dm.leftclick
		
	Else 
		TracePrint "不在主界面，需要跳转回主界面"
		跳转回主界面
	End If 
End Sub


Sub 查当前地块信息
	
End Sub

Sub 跳转到坐标(aimx, aimy)
	TracePrint "跳转到坐标"& aimx & " , "& aimy
	//此时必然在主界面
	//点击地图按钮
	dm_ret = dm.FindPic(0,570,115,615,"D:\ajjl\dtan.bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
//    	TracePrint "找到地图按钮"
    	dm.moveTo intX, intY
    	Delay 1000
    	dm.leftclick
    	
    Else 
    	TracePrint "没有找到地图按钮"
    	
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
	
	//点击前往按钮
	dm_ret = dm.FindPic(1077,534,1166,570,"D:\ajjl\qwan.bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "找到地图按钮"
    	dm.moveTo intX, intY
    	Delay 1000
    	dm.leftclick
    	
    Else 
    	TracePrint "没有找到前往按钮"
    	
	End If

	Delay 1500
End Sub


Sub 攻占(aimx,aimy)
	TracePrint "我将发起冲锋"
	TracePrint "当前位置(0) "&当前位置(0)
	TracePrint "当前位置(1) "&当前位置(1)
	TracePrint "aimx "&aimx
	TracePrint "aimy "&aimy
	If 当前位置(0) <> aimx or 当前位置(1) <> aimy Then 
		跳转到坐标 aimx,aimy
	End If
	
	//地的等级
	//TODO
	//点击攻占按钮
	dm_ret = dm.FindPic(0,0,1166,670,"D:\ajjl\gzan.bmp||D:\ajjl\刀.bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "找到攻占按钮"
    	dm.moveTo intX, intY
    	Delay 1000
    	dm.leftclick
    	
    Else 
    	TracePrint "没有找到攻占按钮"
    	
	End If
	Delay 1500
	
	去点击 "停留"
	
	
	
	去点击 "士气"
	去点击 "兵力"
	去点击 "待命"
	去点击 "待命0"
	
	
	Delay 1500
	
	
	
	dm_ret = dm.FindPic(0,0,1166,670,"D:\ajjl\自动回城按钮.bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "找到自动回城按钮按钮"
    	dm.moveTo intX, intY
    	Delay 1000
    	dm.leftclick
    	
    Else 
    	TracePrint "没有找到自动回城按钮按钮"
    	
	End If
	
	Delay 1500
	
	dm_ret = dm.FindPic(0,0,1166,670,"D:\ajjl\攻占按钮.bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "找到攻占按钮"
    	dm.moveTo intX, intY
    	Delay 1000
    	dm.leftclick
    	
    Else 
    	TracePrint "没有找到攻占按钮"
    	
	End If
	
	
	Delay 1500
	
	dm_ret = dm.FindPic(0,0,1166,670,"D:\ajjl\不再提示.bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "找到不再提示"
    	dm.moveTo intX, intY
    	Delay 1000
    	dm.leftclick
    	
    Else 
    	TracePrint "没有找到不再提示"
    	
	End If
	
	
	Delay 1500
	
	dm_ret = dm.FindPic(0,0,1166,670,"D:\ajjl\坚持.bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "找到坚持"
    	dm.moveTo intX, intY
    	Delay 1000
    	dm.leftclick
    	
    Else 
    	TracePrint "坚持"
    	
	End If
	
End Sub



Sub 攻占一块土地(aimx,aimy)
	If 当前界面 = "主界面" Then 
		攻占 aimx,aimy
	Else 
		TracePrint "不在主界面，需要跳转回主界面"
		跳转回主界面 
		Delay 1000
		攻占一块土地 aimx, aimy
	End If
	
End Sub

Sub 指定队伍攻占(aimx, aimy, 队伍)
	If 当前界面 = "主界面" Then 
		攻占 aimx,aimy
	Else 
		TracePrint "不在主界面，需要跳转回主界面"
		跳转回主界面 
		Delay 1000
		指定队伍攻占 aimx, aimy , 队伍
	End If
End Sub

Sub 从主城占领一块土地(aimx, aimy)
	跳转回主界面 
	
	补充队伍一兵力 
	跳转回主界面
	攻占一块土地 aimx, aimy
End Sub

Sub 进入主城
	跳转回主界面 
	
	
	///点主城
	Do
		Delay 1000
		主界面home
		去点击 "入城"
	Loop Until canFind(0, 70, 1200, 800, "jz") 
	
	当前界面 = "主城界面"
End Sub

Sub 进入队伍一
	进入主城 
	点击 "一队"
	
End Sub

Sub 补充队伍一兵力
	进入队伍一 
	点击 "快速分兵"
	点击 "确认分兵"
End Sub


Sub 进入建筑界面
	判断当前界面
	If 当前界面 <> "建筑界面" Then
		进入主城 
		点击 "jz"
		当前界面 = "建筑界面"
	End If
End Sub

Sub 全力征兵
	进入主城 
	点击 "满征"
End Sub


//
Sub 一个方向铺路(nowX,nowY,lastStep,方向)
	
	Dim offset 
	offset =0
	Do
		TracePrint "进入循环"
		TracePrint offset
		Delay 2000
		offset = offset + 1
		lastStep=lastStep -1
		
		
	
		攻占一块土地 nowX + offset, nowY +	Int(offset/2)
 
		If lastStep = 0 Then 
			Exit Do
		End If
		
		Delay 95000
	Loop
	
End Sub

Function 获取位置信息(aimx, aimy)

	Dim 土地信息(2)
	
	地块等级 = null
	
	地块主人 = null
	地块兵种 = null
	
	txt= 读取土地信息(aimx , aimy)
	
	
	
	
//	跳转到坐标 381, 1439
	跳转到坐标 aimx, aimy
	Delay 1000
	If  txt <> "" Then 
		
		地块等级 = Int(txt)	
		
	Else
	
			txt = Plugin.ZXLOCR.TTOCR(5, 76, 1176, 668, 0)
			
		//	TracePrint txt
		
			Dim 土地(12)
			土地(0)="空地"
			土地(1)="1级"
			土地(2)="2级"
			土地(3)="3级"
			土地(4)="4级"
			土地(5)="5级"
			土地(6)="6级"
			土地(7)="7级"
			土地(8)="8级"
			土地(9)="9级"
			土地(10)="10级"
			土地(11)="特殊地形"
			土地(12)="山"
		
			index = 0
			For 11
				
		
			If InStr(txt, 土地(index)) > 0 Then 
				TracePrint "这是"&土地(index)&"地"
				地块等级 = index
				Exit For
				
			End If
		
			index=index+1	
			Next
			If 地块等级 <= 10 Then 
				写入土地信息 aimx,aimy,地块等级
			End If
	End If
	
	If canFind(0, 70, 1200, 800, "扫荡") or canFind(0, 70, 1200, 800, "扫荡0") Then
		地块主人 = 0
	ElseIf canFind(0, 70, 1200, 800, "入城" )or canFind(0, 70, 1200, 800, "筑城") Then
		地块主人 = 0
	ElseIf canFind(0, 70, 1200, 800, "敌人") Then
		地块主人 = 2
	ElseIf canFind(0, 70, 1200, 800, "侦查") Then
		地块主人 = 3
	ElseIf canFind(0, 70, 1200, 800, "gzan") Then
		地块主人 = 3
	ElseIf canFind(0, 70, 1200, 800, "情报") Then
		地块主人 = 3
	ElseIf canFind(0, 70, 1200, 800, "不可侦查") Then
		地块主人 = 3
	ElseIf canFind(0, 70, 1200, 800, "盟友") Then
		地块主人 = 1
	End If
	
	
	土地信息(0) = 地块主人
	土地信息(1) = 地块等级
	土地信息(2) = 地块兵种
	
	
	
	获取位置信息 = 土地信息
	
End Function




Sub 获取地周围的几块地的信息(nowx, nowy)
	//381, 1439
	// 左上 380 1439  左下 380 1439  下 381 1440  右下382 1440  右上382 1439  上 381, 1438  
	跳转回主界面 
	
	Dim 左上(1), 左下(1), 下(1), 右下(1), 右上(1), 上(1)
	左上(0) = nowx - 1
	左上(1) = nowy - 1
	
	 获取位置信息 左上(0), 左上(1) 
	
	
	左下(0) = nowx - 1
	左下(1) = nowy
	获取位置信息 左下(0) ,左下(1)
	
	
	下(0) = nowx
	下(1) = nowy + 1
	获取位置信息 下(0) ,下(1)
	
	
	右下(0) = nowx + 1
	右下(1) = nowy
	获取位置信息 右下(0) ,右下(1)
	
	
	右上(0) = nowx + 1
	右上(1) = nowy - 1

	获取位置信息 右上(0) ,右上(1)
	
	上(0) = nowx 
	上(1) = nowy - 1
	获取位置信息 上(0) ,上(1)
	
	
	 
	
	
End Sub


Sub 点击招募按钮
	If 当前界面 = "主界面" Then 
		去点击 "招募"
	End If
	
	
End Sub

Sub 点击返回按钮
	dm_ret = dm.FindPic(1000,0,1190,150,"D:\ajjl\fhan.bmp||D:\ajjl\fhan2.bmp||D:\ajjl\fhan3.bmp||D:\ajjl\fhan4.bmp||D:\ajjl\fhan5.bmp||D:\ajjl\xan.bmp||D:\ajjl\x2an.bmp","000000",0.9,0,intX,intY)
	If intX >= 0 and intY >= 0 Then
    	TracePrint "找到返回按钮"
    	dm.moveTo intX, intY
    	Delay 1000
    	dm.leftclick
    	
    Else 
    	TracePrint "没有找到返回按钮"	
	End If
End Sub


Sub 升级主城仓库
		TracePrint "升级主城仓库"
	///点主城
	
	进入建筑界面 
	
//点4下  跳过引导
dm.moveto 1000, 600

		Delay 1100
		dm.leftclick 
	

		Delay 1100
		dm.leftclick 
		

		Delay 1100
		dm.leftclick 

		Delay 1100
		dm.leftclick 

	
//	选中主城
dm.moveto 110, 370

		Delay 1100
		dm.leftclick 
	
	
	去升级这个建筑
	Delay 1000
End Sub

Sub 升级农场石头
	进入建筑界面
		
		
//	选中农场
dm.moveto 600, 300

		Delay 1100
		dm.leftclick 
	
	
	去升级这个建筑
	Delay 1000
	//选中石头
dm.moveto 760, 300

		Delay 1100
		dm.leftclick 
	
	
	去升级这个建筑
	
End Sub

Sub 升级可以升级的建筑
	进入建筑界面 
	Delay 1500
	If canFind(0, 70, 1200, 800, "升") Then 
		去点击 "升"
		去升级这个建筑
	End If
	
	If canFind(0, 70, 1200, 800, "升1") Then 
		去点击 "升1"
		去升级这个建筑
	End If
End Sub

Sub 去升级这个建筑
	去点击 "建造"
	去点击 "升级"
	If 用铜币升级建筑 Then 
			去点击 "确认花费"
		Else 
			去点击 "确认不花"
	End If
End Sub

//Sub 获取地块信息(x, y)
//	跳转回主界面
//	主界面点坐标 
//	跳转到坐标 x, y
//	
//	While isFindZhuCheng = False
//	
//		//网络调用ocr
//		txt = Plugin.ZXLOCR.QSOCR(4,63,1200,800, 0)
//		TracePrint txt
//		//部队地标星内3/3(511,1459
//		
//		
//		 抓取坐标 txt
//		 
//		 
//		If 当前坐标(0) <> 主城坐标(0) and 当前坐标(1) <> 主城坐标(1) Then 
//			isFindZhuCheng = true
//			
//		End If
//		TracePrint 当前坐标(0)
//		 TracePrint 当前坐标(1)
//	Wend
//	
//	
//End Sub


Sub 获取主城信息
	跳转回主界面
	主界面点坐标
	
	While isFindZhuCheng = False
	
		//网络调用ocr
		txt = Plugin.ZXLOCR.TTOCR(951,63,1177,161, 0)
		TracePrint txt
		//部队地标星内3/3(511,1459
		
		
		 抓取坐标 txt
		 
		 
		If 当前坐标(0) <> 0 and 当前坐标(1) <> 0 Then 
			isFindZhuCheng = true
			主城坐标(0) = 当前坐标(0)
			主城坐标(1) = 当前坐标(1)
			
		End If
		TracePrint 主城坐标(0)
		 TracePrint 主城坐标(1)
	Wend
	
	
End Sub

Sub 抓取坐标(txt)
		当前坐标(0) = 0
		当前坐标(1) = 0
		
		position = InStr(txt, "(")
 		position1 = InStr(txt, ")")
 		
 		position2 = InStr(txt, ",")
 		
 		TracePrint "position == " & position & "  position1 == " & position1 &"  position2== "&position2
 		
 		If position > 0 and position2 > position0 and position1 > position2 Then
    		当前坐标(0) = Mid(txt, position + 1, position2 - position - 1)
        	当前坐标(1) = Mid(txt, position2 + 1, position1 - position2 - 1)
        	
    		TracePrint 当前坐标(0)    		
    		TracePrint 当前坐标(1)    		
    		
    	Else 
     		TracePrint "没有抓取到坐标"
    	
		End If
	
End Sub


//=====================================================================================================
////、、、、、、、、、、、、、、、、、、、、、、、、以下都是建筑界面调用操作函数、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、



//=====================================================================================================
////、、、、、、、、、、、、、、、、、、、、、、、、以下都是队伍操作函数、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、


//=====================================================================================================
////、、、、、、、、、、、、、、、、、、、、、、、、以下都是新手引导、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、

Sub 新手引导
LogStart "D:\a.log"
TracePrint "三国志战略版开始新手引导"
LogStop


Do
	Delay 300
	If canFind(0, 70, 1200, 650, "一木难扶") Then 
		当前任务 = "升级建筑"
		去点击 "一木难扶"
		LogStart "D:\a.log"
		TracePrint "三国志战略版结束引导"
		LogStop
		Exit Do
	End If
	
	去点击 "下一步"
	鼠标点击 590, 340
	点击返回按钮
	
	Delay 143
	
	If shouldChou Then 
		
		点击招募按钮
		If canFind(0,70,1200,650,"招募2次")= True Then 
			去点击 "招募2次"
			shouldChou = False
		End If
	End If
	
	If canFind(0,70,1200,650,"选择主城")= True Then 
		进入主城
	End If
	If canFind(0,70,1200,650,"点击进入主城")= True Then 
		进入主城
	End If
	If canFind(0,70,1200,650,"点击进行部队配置")= True Then 
		去点击 "编制"
		去点击 "兵力"
	End If
	If canFind(0,70,1200,650,"加号")= True Then 
		去点击 "加号"
	End If
	If canFind(0,70,1200,650,"上阵1")= True Then 
		去点击 "上阵1"
	End If
	If canFind(0,70,1200,650,"上阵")= True Then 
		去点击 "上阵"
	End If
	If canFind(0,650,1200,800,"快速分兵")= True Then 
		去点击 "快速分兵"
	End If
	If canFind(0,600,1200,800,"确认分兵")= True Then 
		去点击 "确认分兵"
	End If
	If canFind(0,70,1200,800,"gzan")= True Then 
		去点击 "gzan"
	End If
	If canFind(0,70,1200,800,"攻占按钮")= True Then 
		去点击 "攻占按钮"
	End If
	If canFind(0,70,1200,800,"跳过")= True Then 
		去点击 "跳过"
	End If
	If canFind(0,70,1200,800,"回城")= True Then 
		去点击 "回城"
	End If
	If canFind(0,70,1200,800,"兵力")= True Then 
		去点击 "兵力"
	End If
	If canFind(0,70,1200,800,"兵种选择")= True Then 
		去点击 "兵种选择"
	End If
	If canFind(0,70,1200,800,"枪兵")= True Then 
		去点击 "枪兵"
	End If
	If canFind(0,70,1200,800,"行军")= True Then 
		去点击 "行军"
	End If
	If canFind(0,70,1200,800,"士气")= True Then 
		去点击 "士气"
	End If
	If canFind(0,70,1200,800,"确认行军")= True Then 
		去点击 "确认行军"
	End If
	If canFind(0,70,1200,800,"下阵")= True Then 
		去点击 "下阵"
	End If
	If canFind(0,70,1200,800,"确认按钮")= True Then 
		去点击 "确认按钮"
	End If
	
	
	

Loop Until 当前任务 <> "新手引导"
	
End Sub

//=====================================================================================================
////、、、、、、、、、、、、、、、、、、、、、、、、以下都功能区域、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、

Sub 每30分钟判断一次
	
End Sub

Sub 定时任务
	
End Sub

Sub 探查周边信息
	//主城坐标  1436 549
	//主城周围有16个方向
	
	
	
	
	
End Sub


Sub 延时占领
	Delay 1000
	
	path = "D:\ajjl\目标坐标.txt"    
	fileHandle=Plugin.File.OpenFile(path)     
	fileline = Plugin.File.ReadLine(fileHandle)
	  
	Call Plugin.File.CloseFile(fileHandle)
	
	Dim lenOfStr
	lenOfStr = Len(fileline)
	
	TracePrint "文件第一行内容是 " & fileline
	
	
	Join(字符串数组)

	
	
End Sub


Sub 扫荡(位置)
	跳转回主界面 
	补充队伍一兵力 
	跳转回主界面
	跳转到坐标 目标位置(0) ,目标位置(1) 
	去点击 "扫荡"
	去点击 "扫荡0"
	
	去点击 "士气"
	去点击 "兵力"
	去点击 "取消自动回城按钮"
	去点击 "确认扫荡"
	去点击 "坚持"
End Sub



Sub 升级建筑
	TracePrint "升级建筑"
	dm.moveR 10, 10
	
	跳转回主界面 
	
	Dim lastCheckTime
	lastCheckTime = 30
	Dim checkCount
	checkCount =0
	Do
		TracePrint "升级建筑循环中"
		dm.MoveR 10, 30
		Delay 100
		lastCheckTime = lastCheckTime - 30
		TracePrint "lastCheckTime  ::"&lastCheckTime
		If lastCheckTime <= 0 Then 
			升级主城仓库 
			升级农场石头 
			升级可以升级的建筑 
			checkCount =checkCount+1
			lastCheckTime = 60 * checkCount
			TracePrint "下一次升级建筑时间:" & lastCheckTime
//			全力征兵
		End If
	
		Delay 30000
	Loop Until 当前任务 <> "升级建筑"
	
End Sub

Sub 自动铺路
	TracePrint "进入自动铺路递归"
	
			If 当前位置(0) = 目标位置(0) and 当前位置(1) = 目标位置(1) Then 
				Exit Sub
			Else
			Dim direction
			Dim strDes
			If 目标位置(0) < 当前位置(0) Then 
				strDes= "左"
			ElseIf 目标位置(0) > 当前位置(0) Then
				strDes= "右"
			ElseIf 目标位置(0) = 当前位置(0) Then
				strDes= ""
			
			End If
			
			
			If 目标位置(1) < 当前位置(1) Then 
				strDes = strDes & "上"
				
			ElseIf 目标位置(1) > 当前位置(1) Then
				strDes = strDes & "下"
				
			ElseIf 目标位置(1) = 当前位置(1) Then
				strDes = strDes & ""
			
			End If
			
			If strDes="左上" or strDes = "左" Then 
				direction =0
			ElseIf strDes="左下" Then
				direction = 1
			ElseIf strDes = "下" Then
				direction = 2
			ElseIf strDes="右下"Then
				direction = 3
			ElseIf  strDes="右"or strDes="右上" Then
				direction = 4
			ElseIf  strDes="上" Then
				direction = 5
			End If


			TracePrint "目标位置(0)  ====  " & 目标位置(0)
			TracePrint "目标位置(1)  ====  " & 目标位置(1)
			TracePrint "当前位置(0)  ====  " & 当前位置(0)
			TracePrint "当前位置(1)  ====  "&当前位置(1)
			TracePrint "direction  ====  " & direction
			
//			Randomize
//			//得到 1~99999999 之间的一个随机数
//			x = (Int((15 * Rnd) + 1) mod 3 )-1
//			
//			direction=direction+x
			points = getNextPoints(当前位置(0), 当前位置(1), (direction + i) mod 6)
//			TracePrint String.Join(",", points)
			 
			For i = 0 To 5
			If points(i)(0) = 目标位置(0) and points(i)(1) = 目标位置(1) Then 
				当前位置(0) = points(i)(0)
				当前位置(1) = points(i)(1)
				Exit For
			End If
			
			 ret = 获取位置信息(points(i)(0), points(i)(1))
			 TracePrint "地块主人 " & ret(0) & "  地块等级 " & ret(1)
			 Delay 1000
			 
				If ret(0) = 0 Then 
					
					TracePrint "地块主人是自己 "
					
				ElseIf ret(0) = 3 and ret(1) < 铺路等级 Then
				TracePrint "当前位置变成 "& points(i)(0) &"，"&points(i)(1)
					当前位置(0) = points(i)(0)
					当前位置(1) = points(i)(1)
					攻占一块土地 points(i)(0),points(i)(1)
					
					Delay  120000
					Exit For
				Else 
					TracePrint "地块主任 "&ret(0)  &"  地块等级 "&ret(1)
				End If
			Next
				自动铺路
			End If
			
			 
	
	End Sub
	
	
	
	
	
	Function getNextPoints(x, y, firstDirection)
		////derection :: 0:左上  1：左下 2：下 3 右下 4 右上  5 上
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
////、、、、、、、、、、、、、、、、、、、、、、、、以下都是主函数、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、、

Sub main

///注册准备
	注册大漠 
	获取系统配置 
	
	判断三国志是否已打开 
	配置游戏窗口 
	
	注册佐晓鹭 
		
	进入游戏
//	判断当前界面
//	
//	判断当前任务 
//	
//	
//	清理缓存文件
//	
	
	
//	获取地周围的几块地的信息 381, 1439
	// 左上 380 1439  左下 380 1439  下 381 1440  右下382 1440  右下382 1439  上 381, 1438  
//	获取位置信息
//	当前任务 = "征兵"

//	获取主城信息

	
	Do 
	
	If 当前任务 = "新手引导" Then 
			新手引导 
			
	End If
	
	If 当前任务 = "升级建筑" Then
		升级建筑
	End If
	
	If 当前任务 = "自动铺路" Then
		自动铺路 
	End If
	
	
	If 当前任务 = "扫荡" Then 
		For 13
			扫荡 目标位置
			Delay 120*1000
		Next
		当前任务 = "升级建筑"
	End If
	
	
	If 当前任务 = "延时占领" Then 
		For 10
			延时占领 
		Next
	End If
	
	
	TracePrint "一分钟后重新开始任务"
	Delay 60000
	Loop
	
//	
//占领一块土地 510, 1464

	
//	获取主城信息 
//	获取地块信息 507,1459
	
//	//网络调用ocr
//	txt = Plugin.ZXLOCR.QSOCR(951,63,1177,161, 0)
//	TracePrint txt
//	
	
	
	
End Sub
