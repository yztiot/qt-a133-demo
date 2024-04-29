#include "wifithread.h"
#include "HeadDefine.h"

WiFiThread::WiFiThread()
{
    m_ptrProcess = nullptr;
    createWifiFile();
}

WiFiThread::~WiFiThread(){
    delete m_ptrProcess;
    m_ptrProcess = nullptr;

}

/*搜索wifi，打开wifi进行初始化*/
void WiFiThread::createWifiFile(){
    if(m_ptrProcess == nullptr){
        m_ptrProcess = new QProcess(this);
    }
}

//扫描wifi获取wifi列表
void WiFiThread::onScanWifi(){
    if(m_ptrProcess == nullptr){
        m_ptrProcess = new QProcess(this);
    }

    QString openWifi = "nmcli radio wifi on";
    m_ptrProcess->start(openWifi);
    m_ptrProcess->waitForStarted(-1);
    m_ptrProcess->waitForFinished(-1);
    m_ptrProcess->close();

    QByteArray output = m_ptrProcess->readAllStandardOutput();
    QByteArray errorOutput = m_ptrProcess->readAllStandardError();
    // 打印执行结果
   // qDebug() << "Output:" << output;
    //qDebug() << "Error Output:" << errorOutput;

    QString scanwifi = "nmcli";
    m_ptrProcess->start(scanwifi, QStringList() << "-f"<< "SSID"<< "dev"<< "wifi");
    m_ptrProcess->waitForStarted(-1);
    m_ptrProcess->waitForFinished(-1);

    QString strOutput  = m_ptrProcess->readAllStandardOutput();
  //  qDebug()<<"the wifi list is::"<< strOutput;

    QStringList wifilist = strOutput.split("\n", QString::SkipEmptyParts);
    wifilist = wifilist.toSet().toList();
    QStringList sendWifiList;
    sendWifiList.clear();
  //  qDebug() << "wifi list:";
    for(QString wifi : wifilist){
        wifi = wifi.simplified();
        if(wifi != "--" && wifi != "SSID" && wifi != "__"){
            sendWifiList.append(wifi);
        }
    }
    if(sendWifiList.length() > 0){
        emit wifiNameSig(sendWifiList);
    }
}


//连接wifi
void WiFiThread::onConnectWiFiSig(QString wifiName, QString passWord){
    if(m_ptrProcess == nullptr){
        m_ptrProcess = new QProcess(this);
    }

    // 构建nmcli连接WiFi的命令
    QString nmcliCommand = "nmcli device wifi connect " + wifiName + " password "+ passWord;

    // 执行nmcli命令
    m_ptrProcess->start(nmcliCommand);
    m_ptrProcess->waitForFinished();

    // 获取nmcli命令执行结果
    QByteArray output = m_ptrProcess->readAllStandardOutput();
    QByteArray errorOutput = m_ptrProcess->readAllStandardError();

    // 打印执行结果
  //  qDebug() << "Output:" << output;
  //  qDebug() << "Error Output:" << errorOutput;

    // 判断连接是否成功
    if (errorOutput.isEmpty())
    {
        qDebug() << "WiFi connection successful!";
        emit wifiConnectSuccessfulSig(wifiName);
    }
    else
    {
        qDebug() << "WiFi connection failed!";
    }
}


/*断开当前连接的wifi*/
void WiFiThread::onDisConnectWiFiSig(){

}

void WiFiThread::onCloseWifiSig(){
    QString closeWifi = "nmcli radio wifi off";
    m_ptrProcess->start(closeWifi);
    m_ptrProcess->waitForStarted(-1);
    m_ptrProcess->waitForFinished(-1);
}

/*检测当前wifi连接的状态*/
void WiFiThread::wifiStatus(){

}
