#include "runnable.h"
#include <QDebug>
#include <QThread>
Runnable::Runnable()
{

}
void Runnable::run()
{
    qDebug() << "child thread id: " << QThread::currentThreadId();
    int i = 1000;
    while(i--)
    {
        qDebug() << QString("hello world %1").arg(i);
        QThread::msleep(5000);

    }
}
