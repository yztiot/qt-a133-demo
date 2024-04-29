#ifndef SERIALTHREAD_H
#define SERIALTHREAD_H
#include <QThread>
#include <QtSerialPort/QSerialPort>
#include <QDebug>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <net/if.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <linux/can.h>
#include <linux/can/raw.h>
#include <QCanBus>
#include <QCanBusFrame>
#include <QCanBusDevice>
#include <QtSerialBus>
class SerialThread:public QObject
{
    Q_OBJECT
public:
    SerialThread(QSerialPort  *serialPort);
    int recv_can_msg(int can_id1, int can_id2, int *can_dlc, char **data, int *can_id);
    int send_can_msg(int can_id, int can_dlc, char *data);
signals:
    void sendSerialData(QString str);

public slots:
    void readData();
    void starThread();
    int starCanThread();

private:
    QSerialPort *m_serial;
    QString m_strData;
    QString strWrite = "";
    QString m_strHead;
};

#endif // SERIALTHREAD_H
