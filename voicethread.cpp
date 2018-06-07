#include "voicethread.h"
#include <QAudioFormat>
#include <QAudioOutput>
#include <QByteArray>
#include <QFile>
#include <stdio.h>
#include <QSound>
std::string voiceStr="0";
std::string oldVoiceStr="0";
VoiceThread::VoiceThread(QObject *parent) : QObject(parent)
{

}

VoiceThread::~VoiceThread()
{

}

void VoiceThread::receiveDataFromUI(QString voice)
{
   voiceStr=voice.toStdString();
   qDebug()<<"player_push"+voice;
}

QString VoiceThread::readFileFromLocal(QString name){
    QFile file(name);
    QString displayStr;
    if(!file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        qDebug()<<"Can't open the file!"<<endl;
    }
    while(!file.atEnd())
    {
        QString line ;
        line = file.readLine();
        displayStr+=line;
    }
    return displayStr;

}


void VoiceThread::initScan()
{
//    QSoundEffect effect;//
    if(voiceStr!="0"&&voiceStr!=oldVoiceStr){
        QByteArray bytevoiceStr=QString::fromStdString(voiceStr).toUtf8();
        int n=bytevoiceStr.length();
        qDebug()<<n+"***********111";
        char* txt2 = new char[n+1];
        qDebug()<<"***********222";
        memcpy(txt2, voiceStr.c_str(), n);
        qDebug()<<"***********"+QString::fromStdString(voiceStr);
        QString path="/home/robot/"+getCurrentTime()+".wav";
        QByteArray pathbytes=path.toUtf8();
        oldVoiceStr=voiceStr;
        voiceStr="0";
        int status= start_tts(NULL, txt2, pathbytes.data());
        delete txt2;
        if(status==0){
               QSound::play(path);
       }
    }else{
         oldVoiceStr="0";
    }

}


void VoiceThread:: playerTTS(QString value)
{
    qDebug()<<"player   "+value;
    QSoundEffect effect;
    effect.setSource(QUrl::fromLocalFile("/home/robot/robotblue/text/"+value+".wav"));
    //循环播放
    effect.setVolume(0.8f);
    effect.play();
}

CallBackFunc mycallback()
{
    voiceStr="hi你好，很高兴认识你。购物请按屏幕指示操作。";
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

QString VoiceThread::getShopCart()
{
  return resultMsg;
}

void VoiceThread::setShopCart(QString msg)
{
  resultMsg=msg;
}


QString VoiceThread::setInStoreTime()
{
    QDateTime time = QDateTime::currentDateTime();
    QString str = time.toString("yyyy/MM/dd hh:mm:ss");
    inStoreTime= str;
}
QString VoiceThread::setOffStoreTime()
{
    QDateTime time = QDateTime::currentDateTime();
    QString str = time.toString("yyyy/MM/dd hh:mm:ss");
    offStoreTime= str;
}
QString VoiceThread::getInStoreTime()
{
    if(inStoreTime.length()<2){
        QDateTime time = QDateTime::currentDateTime();
        QString str = time.toString("yyyy/MM/dd hh:mm:ss");
        return str;
    }
    return inStoreTime;
}

QString VoiceThread::getOffStoreTime()
{
    if(offStoreTime.length()<2){
        QDateTime time = QDateTime::currentDateTime();
        QString str = time.toString("yyyy/MM/dd hh:mm:ss");
        return str;
    }
    return offStoreTime;
}

