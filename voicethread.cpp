#include "voicethread.h"
#include <QByteArray>

std::vector<std::string> voiceVector;

VoiceThread::VoiceThread(QObject *parent) : QObject(parent)
{

}

VoiceThread::~VoiceThread()
{

}

void VoiceThread::receiveDataFromUI(QString voiceStr)
{
   voiceVector.push_back(voiceStr.toStdString());
   qDebug()<<"player_push";
}

void VoiceThread::initScan()
{
  while (true) {
    qDebug()<<"p";
    if(voiceVector.size()==0){
        return;
    }
    std::vector<std::string>::iterator it;
    for(it=voiceVector.begin();it!=voiceVector.end();it++){
        qDebug()<<"tts start";
        QString path="/home/robot/robotBlue.wav";
        QByteArray bytestext=QString::fromStdString(*it).toUtf8();
        QByteArray bytespath=path.toUtf8();
        qDebug()<<QString::fromStdString(*it);
        int status= start_tts(NULL, bytestext.data(), bytespath.data());

        if(status==0){
            qDebug()<<"player";
        //    effect.setSource(QUrl::fromLocalFile("/home/robot/test.wav"));
            //循环播放
            effect.setSource(path);
    //        effect.setLoopCount(QSoundEffect::Infinite);
                //设置音量，0-1
            effect.setVolume(0.8f);
            effect.play();
        }

    }
  }
}



CallBackFunc mycallback()
{
    qDebug()<<("wake up words test successfull!!!!\n");

}

////注册语音唤醒
void VoiceThread::initASR()
{
  qDebug()<<"awake set before";
  int result=create_wakeup_task((CallBackFunc)mycallback);
  if(result<0){
      qDebug()<<"awake set success";
  }
  qDebug()<<"awake set success";
}

void VoiceThread::getCallBackFunc(Func c)
{
    fback=c;
}

QString VoiceThread::getCurrentTime()
{
    QDateTime time = QDateTime::currentDateTime();
    QString str = time.toString("yyyy.MM.dd hh:mm");
    return str;
}


