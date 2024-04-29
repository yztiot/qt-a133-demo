#ifndef GPIO_H
#define GPIO_H
#include <QObject>
#include <QDebug>
#include <QDir>
#include <QFileInfo>

// gpio路径 触摸屏用这个
//#define SYS_GPIO_DIR "/sys/class/gpio"



class GPIO: public QObject
{
    Q_OBJECT
public:
    GPIO();

    /*获取gpio模式*/
    Q_INVOKABLE void gpioModel(QString model);
    /*设置gpio方向*/
    Q_INVOKABLE void setIODirection(const QString &ioName, const QString &direction);
    /*设置gpio电平*/
    Q_INVOKABLE void setHighLowLevel(const QString &ioName, int value);

signals:
    void gpioSig(QString data);

private:
    QString m_strLeve;
    QString m_strDirection;
    QString m_sysGPIODir;
    QString m_strCurrentPath;
     QMap<QString, int> ioNumberMap;
};

#endif // GPIO_H
