#include "wifi.h"

WiFi::WiFi(){

    m_wifiThread = nullptr;
    m_thread = nullptr;
    b_OpenWifi = false;
    initWiFi();
}

WiFi::~WiFi(){

}

//初始化wifi信息
void WiFi::initWiFi(){
      if(m_wifiThread == nullptr){
          m_wifiThread = new WiFiThread;
      }
      if(m_thread == nullptr){
          m_thread = new QThread;
      }

      m_wifiThread->moveToThread(m_thread);

      connect(this, SIGNAL(startSig()), m_wifiThread, SLOT(createWifiFile()));
      connect(this, SIGNAL(scanWifiSig()), m_wifiThread, SLOT(onScanWifi()));
      connect(this, SIGNAL(connectWiFiSig(QString,QString)), m_wifiThread, SLOT(onConnectWiFiSig(QString,QString)));
      connect(this, SIGNAL(closeWiFiSig()), m_wifiThread, SLOT(onCloseWifiSig()));

      connect(m_wifiThread, SIGNAL(wifiNameSig(QStringList)), this, SLOT(onWifiNameSig(QStringList)));
      connect(m_wifiThread, SIGNAL(wifiConnectSuccessfulSig(QString)), this, SLOT(onWifiConnectSuccessfulSig(QString)));
      m_thread->start();
      emit startSig();

}

//这里要用这种方式调用函数，不然会炸掉界面
void WiFi::runScanWiFi()
{
    scanWiFi();
}

/*扫描wifi*/
void WiFi::scanWiFi(){

    emit scanWifiSig();
}

//返回获取的wifi名列表
void WiFi::onWifiNameSig(QStringList name){
   b_OpenWifi = true;
   emit wifiNameQml(name);
}

/* 连接成功返回*/
void WiFi::onWifiConnectSuccessfulSig(QString name){
    emit connectCurrentNameSig(name);
}

/* 连接wifi*/
void WiFi::connectWiFi(QString name, QString password){
    emit connectWiFiSig(name, password);
}

/*关闭wifi*/
void WiFi::closeWiFi(){
    b_OpenWifi = false;
    emit closeWiFiSig();
}

/*断开wifi*/
void WiFi::disconnectWiFi(){
}

/*响应断开当前连接从子线程发挥来的数据*/
void WiFi::onDisConnectCurrentWiFiSig(){
}

//设置wifi状态
void WiFi::setWifiCurrentState(bool state){
}

/*获取当前是否打开wifi状态*/
bool WiFi::getWifiCurrentState(){
    return b_OpenWifi;
}

void WiFi::disconnectSignalsAndSlots() {
}

void WiFi::onCloseWiFiThreadSig() {
}
