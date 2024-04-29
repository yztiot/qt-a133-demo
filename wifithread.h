#ifndef WIFITHREAD_H
#define WIFITHREAD_H
#include <QObject>
#include <QTimer>
#include <QDebug>
#include <QFile>
#include <QFileInfo>
#include <QList>
#include <QVector>
#include <QMap>
#include <QString>
#include <QtGlobal>
#include <stdio.h>
#include <QProcess>
#include <QStringList>


class WiFiThread: public QObject
{
    Q_OBJECT
public:

    explicit WiFiThread();
    ~WiFiThread();

    void connectWiFi(QString wifiName, QString passWord);

    void wifiStatus();

signals:
    void wifiNameSig(QStringList name);
    void wifiConnectSuccessfulSig(QString name);
    void disConnectCurrentWiFiSig();
    void closeWiFiThreadSig();


public slots:
    /*搜索wifi，打开wifi进行初始化*/
    void createWifiFile();
    void onConnectWiFiSig(QString name,QString password);
    void onDisConnectWiFiSig();
    void onCloseWifiSig();
    void onScanWifi();
 //   void onScanWifiSig();


private:
    QProcess *m_ptrProcess;


};

#endif // WIFITHREAD_H
