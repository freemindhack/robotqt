#ifndef C_UDP_H
#define C_UDP_H
#include <QThread>
#include <QtCore>
#include <QObject>
#include <QMutex>
#include <iostream>
#include <QtNetwork>

extern std::string GLOBAL_UDP_STR;//全局
class C_UDP : public QThread
{
public:
    Q_OBJECT
public:
    C_UDP();

signals:
    void udp();

public slots:
    void run();
    void sendData();
    QString getGLOBAL_UDP_STR();
    void clearGLOBAL_UDP_STR();
    void processPendingDatagram();
private:
    bool stopped;
    QMutex m_lock;
    QUdpSocket *receiver;
    QUdpSocket *sender;
    QFile f();
    QString talk="你好！我是小兰，来看看我这里有没有你需要的商品吧";

};

#endif // C_UDP_H
