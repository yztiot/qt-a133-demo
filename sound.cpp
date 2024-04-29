#include "sound.h"
#include "include/audio.h"


Sound::Sound()
{
    m_ptrProcess = new QProcess(this);
}

Sound::~Sound(){
    delete m_ptrProcess;
    m_ptrProcess = nullptr;
}

/*寻找当前mp3文件，在运行文件的目录可自行修改*/
void Sound::findSoundFile(){
    /*此路径可自行更改为mp3的所在目录路径*/
    QString path = QDir::currentPath();
    // QString path = "/root/";
    qDebug()<<"current path::"<< path;
    m_strPath = path;
    m_strSoundNameList.clear();
    QFileInfo info = QFileInfo(path);

    if(info.isDir()){
        QDir dir = QDir(path);
        QStringList list = dir.entryList();
        foreach (QString file, list) {
            QFileInfo fileInfo = QFileInfo(file);
            if(fileInfo.isFile()){
                QString strFile(file);
                if(strFile.contains(".mp3") || strFile.contains(".wav")){
                    m_strSoundNameList.append(strFile);
                }
            }
        }
    }else{
        return;
    }
}

/*获取音频文件*/
QStringList Sound::getSoundFile(){
    return m_strSoundNameList;
}

QString Sound::getSoundPath(){
    return m_strPath;
}

void Sound::setPath(){

}

//sound stop
void Sound::musicStop(){
    if (m_ptrProcess->state() == QProcess::Running) {
        m_ptrProcess->terminate(); // 终止进程
        m_ptrProcess->waitForFinished();
        qDebug() << "Audio stopped.";
    }
}

// set sound
void Sound::setSound(QString num){
    qDebug()<<"HHH::";
    QString order = "pactl set-sink-volume 1 " +  num;
    system(order.toLatin1().data());
}

void Sound::musicPlay(QString name){
    QString playMusicFile = name;
    QString strCommand = "mplayer "+ playMusicFile;
    qDebug()<<"the play ::"<< strCommand;
    m_ptrProcess->start(strCommand);
    // 等待aplay启动
    QThread::msleep(500);

    if (m_ptrProcess->state() == QProcess::Running) {
        qDebug() << "Audio playing...";
    } else {
        qDebug() << "Failed to start audio playback.";
    }
}

