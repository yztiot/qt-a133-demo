#ifndef WIFI_H
#define WIFI_H
#include <QDebug>
#include <QNetworkAccessManager>
#include <QNetworkConfiguration>
#include <QNetworkConfigurationManager>
#include <QObject>
#include <QList>
#include <QFile>
#include <QFileInfo>
#include <QThread>
#include <QEventLoop>
#include <QMetaObject>
#include "wifithread.h"

class WiFi: public QObject
{
    Q_OBJECT
public:
    WiFi();
    ~WiFi();
    Q_INVOKABLE void scanWiFi();
    Q_INVOKABLE void connectWiFi(QString name, QString password);
    Q_INVOKABLE void runScanWiFi();
    Q_INVOKABLE void closeWiFi();
    Q_INVOKABLE void disconnectWiFi();
    Q_INVOKABLE void setWifiCurrentState(bool state);
    Q_INVOKABLE bool getWifiCurrentState();
    Q_INVOKABLE void disconnectSignalsAndSlots();
    Q_INVOKABLE QStringList getWifiNameList(){return m_wifiNameList;}

    void initWiFi();

signals:
    void startSig();
    void scanWifiSig();
    void wifiNameQml(QStringList name);
    void connectWiFiSig(QString name, QString password);
    void connectCurrentNameSig(QString name);
    void disconnectWiFiSig();
    void disCurrentWifiSigQml();
    void closeWiFiSig();

public slots:
    void onWifiNameSig(QStringList name);
    void onWifiConnectSuccessfulSig(QString name);
    void onDisConnectCurrentWiFiSig();
    void onCloseWiFiThreadSig();

private:
    QStringList m_wifiNameList;

    WiFiThread *m_wifiThread;
    QThread *m_thread;
    bool b_OpenWifi;

};

#endif // WIFI_H
