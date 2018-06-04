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

#include <inc/tts.h>
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
    QTextCodec *codec = QTextCodec::codecForName("UTF-8");//情况2
    QTextCodec::setCodecForLocale(codec);


    //开启后台线程请求网络数据
    QThread threadWork;
    //开启刷手后台线程
    QThread threadPal;

    WorkThread work;
    PalService palService;

    threadWork.start();
    threadPal.start();

    work.moveToThread(&threadWork);
    palService.moveToThread(&threadPal);



    C_UDP udpthread;
    udpthread.start();



    //展示二维码图片
//    QTimer::singleShot(0,&work,SLOT(getQRCode()));
    //定时扫描手脉

    QTimer *palTimer = new QTimer();
    QObject::connect(palTimer,SIGNAL(timeout()), &palService, SLOT(changeValueByCode()),Qt::QueuedConnection);
    palTimer->start(1000);

    GLOBAL_USER_ID="201709999";

//    QTimer::singleShot(0,&palService,SLOT(init()));

//    Runnable *r = new Runnable();
//    QThreadPool::globalInstance()->start(r);
//    QThreadPool::globalInstance()->waitForDone();

//    QThread* backgroundThread = new QThread;
//    backgroundThread->start();
//    task->moveToThread(backgroundThread);

    //主信号
//    QObject::connect(&work,SIGNAL(signa()),&app,SLOT(quit()));

    qmlRegisterType<WorkThread>("blue.deep.work",1,0,"WorkThread");
    qmlRegisterType<PalService>("blue.deep.palm",1,0,"PalService");

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



    return app.exec();
}

