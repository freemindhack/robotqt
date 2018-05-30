#ifndef WORKTHREAD_H
#define WORKTHREAD_H
#include <QTimer>
#include <QObject>
#include <QDebug>
class WorkThread : public QObject
{
    Q_OBJECT
public:
    explicit WorkThread(QObject *parent = nullptr);
    ~WorkThread();

signals:
    void work();

public slots:
    void getData();
    int sendWorkSignal();
private:
    int isByScan;
    int timeRequest;//this is a times for calc request
    QString serverUrl="https://api.quixmart.com/quixmart-api/alipayXServer/getQRCode?intoMethod=2&initDeviceNo=Robot20170923";

};

#endif // WORKTHREAD_H
