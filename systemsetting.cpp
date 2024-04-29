#include "systemsetting.h"
#include <sys/ioctl.h>
#include <fcntl.h>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <unistd.h>
//disp驱动部分命令（与背光相关，内核目录：/include/video/sunxi_display2.h)
#define DISP_LCD_SET_BRIGHTNESS 0x102
#define DISP_LCD_GET_BRIGHTNESS 0x103
#define DISP_LCD_BACKLIGHT_ENABLE 0x104
#define DISP_LCD_BACKLIGHT_DISABLE 0x105

#define BRIGHTNESS_MAX 255 //最大亮度
SystemSetting::SystemSetting()
{
    m_strSystime = "";
    m_timer = nullptr;
    m_timer = new QTimer;
    m_process = new QProcess;
    m_bOpenScreenSave = false;
    m_strSysScreenSave = "";
   // QString path = QCoreApplication::applicationDirPath();
   // qDebug()<<"path::"<< path;
    initScreenSave();
    QString stopAutoTime = "timedatectl set-ntp false";
    system(stopAutoTime.toLatin1().data());
}

SystemSetting::~SystemSetting(){
    delete m_process;
    delete m_timer;
    m_process = nullptr;
    m_timer = nullptr;
}

/*设置系统时间*/
void SystemSetting::setSysTime(QString time){
    QString data ;
    QDebug(&data).nospace() <<"date -s "<< time ;

    std::string str = data.toStdString();
    const char* ch = str.c_str();

    qDebug()<<"date::"<< data;

    QProcess::startDetached(data);
 //   QProcess::startDetached("hwclock -w"); // 同步系统时间
  //  QProcess::startDetached("sync"); // 保存配置

 //   system(ch);

 //   system("hwclock -w");
    emit updateTimeSig();
}

/*设置背光亮度*/
void SystemSetting::setSysLight(QString lightNum){
    const int fb_lcd0 = 0;
    const int disp_max_brightness = BRIGHTNESS_MAX;


    qDebug() << "Received lightNum: " << lightNum;

    int fd = open("/dev/disp", O_RDWR, 0);
    if (fd < 0) {
        perror("Error opening /dev/disp");
        return;
    }

    // Print old LCD brightness
    unsigned long args[3] = {fb_lcd0, 0, 0};
    printf("The old lcd%d brightness is %d\n", args[0], ioctl(fd, DISP_LCD_GET_BRIGHTNESS, args));

    // Set new LCD brightness
    int brightness = lightNum.toInt()*2.55;
    if (brightness < 0 || brightness > disp_max_brightness) {
        printf("ERROR: The range is 0 to %d\n", disp_max_brightness);
        close(fd);
        return;
    }

    args[1] = brightness;
    ioctl(fd, DISP_LCD_SET_BRIGHTNESS, args);

    // Print new LCD brightness
    printf("The new lcd%d brightness is %d\n", args[0], ioctl(fd, DISP_LCD_GET_BRIGHTNESS, args));

    close(fd);
}

/*获取背光亮度*/
int SystemSetting::getSysLight(){
    const int fb_lcd0 = 0;

    int fd = open("/dev/disp", O_RDWR, 0);
    if (fd < 0) {
        perror("Error opening /dev/disp");
        return -1; // or another appropriate error code
    }

    // Get current LCD brightness
    unsigned long args[3] = {fb_lcd0, 0, 0};
    int brightness = ioctl(fd, DISP_LCD_GET_BRIGHTNESS, args);

    // Close /dev/disp device
    close(fd);

    if (brightness < 0) {
        perror("Error getting LCD brightness");
        return -1; // or another appropriate error code
    }

    return brightness / 2.55;
}

/*设置音量*/
void SystemSetting::setSysVol(QString volNum){
    QString order = "pactl set-sink-volume 1 " +  volNum;
    system(order.toLatin1().data());
}

/*
* @brief 设置屏保*
* @param time 屏保时间
* @param openScreenSave 是否开启屏保
*/
void SystemSetting::setScreenSave(int time, bool openScreenSave){
    if(!m_timer){
        m_timer = new QTimer;
    }

    m_bOpenScreenSave = openScreenSave;
    switch (time) {
    case 1:
        m_strSysScreenSave = "0";
        break;
    case 5:
        m_strSysScreenSave = "1";
        break;
    case 10:
        m_strSysScreenSave = "2";
        break;
    case 30:
        m_strSysScreenSave = "3";
        break;
    case 60:
        m_strSysScreenSave = "4";
        break;
    default:
        m_strSysScreenSave = "5";
        break;
    }
    setScreenSaveModel(m_strSysScreenSave);

    connect(m_timer,SIGNAL(timeout()), this, SLOT(onScreenSaveTimeOut()));
    if(!m_bOpenScreenSave){
        m_timer->stop();
    }else{
        m_timer->setInterval(time * 60 * 1000);
        m_timer->start();
    }
}

void SystemSetting::initScreenSave(){
   // QString dir = QDir::currentPath();
    QString filePath = "/tmp/screenSave";
    QFileInfo info(filePath);
    if(info.isFile()){
        QFile file(filePath);
        if(file.open(QIODevice::ReadOnly| QIODevice::Text)){
           QByteArray dateArr = file.readAll();

           QString date = dateArr.simplified();
           m_strSysScreenSave = date;
        }

    }else{
        qDebug()<<"creat tmp::";
        system("echo 5 > /tmp/screenSave");
    }
}

/*设置屏保时间*/
void SystemSetting::setScreenSaveModel(QString model){
  //  QString dir = QDir::currentPath();
    QString filePath = "/tmp/screenSave";
    QFileInfo info(filePath);
    if(info.isFile()){
        QString strOrder = "echo "+ model + " > /tmp/screenSave";
        std::string str = strOrder.toStdString();
        const char* pt = str.c_str();
        system(pt);

    }else{
        qDebug()<<"set light false::";

    }
}

QString SystemSetting::getScreenSaveModel(){
    return m_strSysScreenSave;
}

QString SystemSetting::qtVersion(){
    QString strQtVersion = QT_VERSION_STR;
    qDebug()<<"the strqtVersion is::"<< strQtVersion;
    return strQtVersion;
}

void SystemSetting::onScreenSaveTimeOut(){
    if(m_haveDosth)
    {
        m_haveDosth=false;
        emit screenSaveSig();
    }
}

/*重写鼠标事件，获取鼠标是否在限定时间内进行了位置的改动*/
bool SystemSetting::eventFilter(QObject *ob, QEvent *e)
{
    //  判断如果是鼠标移动事件
    if(e->type()==QEvent::MouseMove)
    {
        //标志是否有过鼠标操作变量
        if(!m_haveDosth)
        {
            m_haveDosth=true;
        }
        //m_timer在这判断是否已经开启.
        if(m_timer->isActive())
        {
            //如果已经开启，并且有鼠标移动事件就需要计时器重新计算
            m_timer->stop();
            if(m_bOpenScreenSave){
                m_timer->start();
            }

            qDebug()<<"m_haveDosthtimer restart";
        }
    }
    //其他事件仍然交给系统处理。这句一定不能少。
    return QObject::eventFilter(ob,e);
}

