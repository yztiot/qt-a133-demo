#include "gpio.h"
#define DEVICE_NAME "/dev/i2c-0"

GPIO::GPIO()
{
    m_sysGPIODir = "/sys/class/gpio";
    // m_strCurrentPath = m_sysGPIODir + "/gpio11";
}

void GPIO::gpioModel(QString model){
    // QString strModel = m_sysGPIODir + "/" + model;

    // QFileInfo dir(strModel);
    // if(dir.isDir()){
    //     m_strCurrentPath = strModel;
    // }else{
    //     QString createName = model.mid(4, model.length());

    //     QString sysOrder = "echo " + createName +" > " + m_sysGPIODir +"/export";

    //     QString sysOutOrder = "echo out > " + m_sysGPIODir +"/" + model + "/direction";
    //     system(sysOrder.toLatin1().data());
    //     system(sysOutOrder.toLatin1().data());

    //     QString strCreate =  QString("创建新的GPIO：") + model;
    //     emit gpioSig(strCreate);
    // }
}

// 设置GPIO的方向
void GPIO::setIODirection(const QString &ioName, const QString &direction) {

    ioNumberMap["PE3"] = 131;
    ioNumberMap["PE4"] = 132;
    ioNumberMap["PE5"] = 133;
    ioNumberMap["PE6"] = 134;
    ioNumberMap["PE7"] = 135;
    ioNumberMap["PE8"] = 136;
    QFile exportFile("/sys/class/gpio/export");
    if (!exportFile.open(QIODevice::WriteOnly | QIODevice::Text)) {
        emit gpioSig("打开/sys/class/gpio/export失败!!!");
        return;
    }
    QTextStream exportStream(&exportFile);
    exportStream << ioNumberMap[ioName] << "\n";
    exportFile.close();

    QFile directionFile("/sys/class/gpio/gpio" + QString::number(ioNumberMap[ioName]) + "/direction");
    qDebug() << "directionFile:" << directionFile.fileName();
    if (!directionFile.open(QIODevice::WriteOnly | QIODevice::Text)) {
        emit gpioSig("打开/sys/class/gpio/export失败!!!");
        return;
    }
    QTextStream directionStream(&directionFile);
    directionStream << direction << "\n";
    directionFile.close();

    emit gpioSig("GPIO:" + ioName + " 设置方向为：" + direction);
}

// 设置GPIO的电平
void GPIO::setHighLowLevel(const QString &ioName, int value) {
    ioNumberMap["PE3"] = 131;
    ioNumberMap["PE4"] = 132;
    ioNumberMap["PE5"] = 133;
    ioNumberMap["PE6"] = 134;
    ioNumberMap["PE7"] = 135;
    ioNumberMap["PE8"] = 136;
    QFile exportFile("/sys/class/gpio/export");
    if (!exportFile.open(QIODevice::WriteOnly | QIODevice::Text)) {
        emit gpioSig("打开/sys/class/gpio/export失败!!!");
        return;
    }
    QTextStream exportStream(&exportFile);
    exportStream << ioNumberMap[ioName] << "\n";
    exportFile.close();

    QFile directionFile("/sys/class/gpio/gpio" + QString::number(ioNumberMap[ioName]) + "/direction");
    qDebug() << "directionFile:" << directionFile.fileName();
    if (!directionFile.open(QIODevice::WriteOnly | QIODevice::Text)) {
        emit gpioSig("Failed to open direction file");
        return;
    }
    QTextStream directionStream(&directionFile);
    directionStream << "out" << "\n"; // 设置为输出模式
    directionFile.close();

    QFile valueFile("/sys/class/gpio/gpio" + QString::number(ioNumberMap[ioName]) + "/value");
    qDebug() << "valueFile:" << valueFile.fileName();
    if (!valueFile.open(QIODevice::WriteOnly | QIODevice::Text)) {
        emit gpioSig("Failed to open value file");
        return;
    }
    QTextStream valueStream(&valueFile);
    valueStream << value << "\n";
    valueFile.close();

    emit gpioSig("GPIO:" + ioName + " 设置电平为：" + QString::number(value));
}
