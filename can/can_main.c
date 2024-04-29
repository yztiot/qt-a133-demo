#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <net/if.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <linux/can.h>
#include <linux/can/raw.h>

#define CAN_DEVICE "can0"    // CAN设备名称
#define CAN_BITRATE "500000" // 波特率500kbps
#define CAN_ID1 0x123        // 可接收的CAN ID
#define CAN_ID2 0x111        // 可接收的CAN ID
void canInit()
{
    // 初始化CAN设备, 设置波特率
    char cmd[125];
    memset(cmd, 0, sizeof(cmd));
    snprintf(cmd, sizeof(cmd), "ifconfig %s down && canconfig %s bitrate %s ctrlmode triple-sampling on && ifconfig %s up", CAN_DEVICE, CAN_DEVICE, CAN_BITRATE, CAN_DEVICE);
    system(cmd);
}

int send_can_msg(int can_id, int can_dlc, char *data)
{
    int s, nbytes;
    struct sockaddr_can addr;
    struct ifreq ifr;
    struct can_frame frame = {0};
    s = socket(PF_CAN, SOCK_RAW, CAN_RAW); // 创建套接字
    strcpy(ifr.ifr_name, CAN_DEVICE);
    ioctl(s, SIOCGIFINDEX, &ifr); // 指定can0 设备
    addr.can_family = AF_CAN;
    addr.can_ifindex = ifr.ifr_ifindex;
    bind(s, (struct sockaddr *)&addr, sizeof(addr)); // 将套接字与can0 绑定
    // 禁用过滤规则，本进程不接收报文，只负责发送
    setsockopt(s, SOL_CAN_RAW, CAN_RAW_FILTER, NULL, 0);
    // 生成报文
    frame.can_id = can_id;
    frame.can_dlc = can_dlc;
    memcpy(frame.data, data, can_dlc);
    // 发送报文
    nbytes = write(s, &frame, sizeof(frame));
    if (nbytes != sizeof(frame))  {
        printf("Send Error!\n");
        close(s);
        return -1; // 发送错误
    }
    close(s);
    return 0;
}

int recv_can_msg(int can_id1, int can_id2, int *can_dlc, char **data, int *can_id)
{
    int s;
    struct sockaddr_can addr;
    struct ifreq ifr;
    struct can_frame frame;
    struct can_filter rfilter[2];

    s = socket(PF_CAN, SOCK_RAW, CAN_RAW); // 创建套接字
    strcpy(ifr.ifr_name, CAN_DEVICE);
    ioctl(s, SIOCGIFINDEX, &ifr); // 指定can0设备

    addr.can_family = AF_CAN;
    addr.can_ifindex = ifr.ifr_ifindex;
    bind(s, (struct sockaddr *)&addr, sizeof(addr)); // 将套接字与can0绑定

    // 定义接收规则，只接收指定的CAN ID报文
    rfilter[0].can_id = can_id1;
    rfilter[0].can_mask = CAN_SFF_MASK;
    rfilter[1].can_id = can_id2;
    rfilter[1].can_mask = CAN_SFF_MASK;

    // 设置过滤规则
    setsockopt(s, SOL_CAN_RAW, CAN_RAW_FILTER, &rfilter, sizeof(rfilter));

    // 读取CAN报文
    read(s, &frame, sizeof(frame));

    // 检查读取到的数据长度是否符合预期
    *can_dlc = frame.can_dlc;
    *can_id = frame.can_id;

    // 动态分配缓冲区
    *data = (char *)malloc(*can_dlc * sizeof(char));
    memcpy(*data, frame.data, *can_dlc);

    close(s);
    return 0;
}
int main()
{
    canInit();
    char *data_send = "12345678";
    int can_id = 0;
    char *data_recv = NULL;
    int can_dlc = 0;
    int ret_send, ret_recv;
    // 发送CAN报文
    ret_send = send_can_msg(0x12, 8, data_send);
    if (ret_send == -1) {
       printf("Send Error!\n");
        return -1;
    }
    while (1)
    {
        // 接收CAN报文
        ret_recv = recv_can_msg(CAN_ID2, CAN_ID1, &can_dlc, &data_recv, &can_id);
        if (ret_recv == -1)  {
            printf("recv Error!\n");
            return -1;
        }
        // 显示接收到的报文数据
        printf("接收到的数据 (ID=0x%x):", can_id);
        for (int i = 0; i < can_dlc; i++)   {
            printf("%02X ", data_recv[i]);
        }
        printf("\n");

        // 释放缓冲区内存
        free(data_recv);
    }

    return 0;
}



