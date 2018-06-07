extern "C"
#include "dianutils.h"
#include "palservice.h"
#include "runnable.h"
#include "workthread.h"

#include <QGuiApplication>
#include <QDebug>
#include <http_request.h>
#include <QQmlApplicationEngine>
#include <httprequest.h>
#include <QNetworkAccessManager>
#include <QTextCodec>
#include <QJsonDocument>
#include <QJsonObject>
#include <QThread>
#include <QThreadPool>
#include <QTimer>
#include "runnable.h"
#include <QtQml>
#include <iostream>
#include <c_udp.h>
#include <voicethread.h>
#include <inc/tts.h>
#include <QDateTime>
#include <inc/awaken.h>
#include <inc/aisound.h>
extern int start_tts(tts_session_params *param, char *text, char *filename);



int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QString str = QString::number(0xE0);
    qDebug() << str;
//jiejue乱码问题
//    QTextCodec *codec = QTextCodec::codecForName("UTF-8");//情况2
 //   QTextCodec::setCodecForLocale(codec);

//login
    login_aisound();
    //开启后台线程请求网络数据
    QThread threadWork;
    //开启刷手后台线程
    QThread threadPal;
    QThread threadVoice;
    QThread threadVoiceAsr;

    WorkThread work;
    VoiceThread voice;
    VoiceThread voiceAsr;
    PalService palService;

    threadWork.start();
    threadPal.start();
    threadVoiceAsr.start();
    threadVoice.start();

    work.moveToThread(&threadWork);
    palService.moveToThread(&threadPal);
    voice.moveToThread(&threadVoice);
    voiceAsr.moveToThread(&threadVoiceAsr);


    C_UDP udpthread;
    udpthread.start();



    //展示二维码图片
//    QTimer::singleShot(0,&work,SLOT(getQRCode()));
    //定时扫描手脉

    QTimer *palTimer = new QTimer();
    QObject::connect(palTimer,SIGNAL(timeout()), &palService, SLOT(changeValueByCode()),Qt::QueuedConnection);
    palTimer->start(2000);

    GLOBAL_USER_ID="2088712800736204";


    QTimer *voiceTimer = new QTimer();
    QObject::connect(voiceTimer,SIGNAL(timeout()), &voice, SLOT(initScan()),Qt::DirectConnection);
    voiceTimer->start(3000);

     QTimer::singleShot(0,&voiceAsr,SLOT(initASR()));



    //主信号

    qmlRegisterType<WorkThread>("blue.deep.work",1,0,"WorkThread");
    qmlRegisterType<PalService>("blue.deep.palm",1,0,"PalService");
    qmlRegisterType<VoiceThread>("blue.deep.voice",1,0,"VoiceThread");
    qmlRegisterType<C_UDP>("blue.deep.cudp",1,0,"C_UDP");
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));


    if (engine.rootObjects().isEmpty())
        return -1;

    //找到文档的父节点
      QList<QObject*> rootObjects = engine.rootObjects();
      QObject *root  = rootObjects[0];// get the first one
      QVariant returnedValueWork;
      QVariant message = "Hello from C++";
      QMetaObject::invokeMethod(root, "workFunction", Q_RETURN_ARG(QVariant, returnedValueWork), Q_ARG(QVariant, message));


//logout
//      logout_aisound();
    return app.exec();
}


