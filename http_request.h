/*

  Add "network" to .pro


         Coded By Virus007
          CyberSoldiersST

   Email: virus007@protonmail.com

*/



#ifndef HTTP_REQUEST_H
#define HTTP_REQUEST_H

#include <QDebug>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QString>
#include <QEventLoop>
#include <QByteArray>
#include <QVariant>
#include <QLoggingCategory>


//Post http request
/*
  Example:
  Post("http://google.com/","header1=one&header2=two");
*/
void Post(QString uri, QString header)
{
    QLoggingCategory::setFilterRules("qt.network.ssl.warning=false");
    QEventLoop eventLoop;
    QNetworkAccessManager manager;
    QUrl url(uri);
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/x-www-form-urlencoded");
    QObject::connect(&manager, SIGNAL(finished(QNetworkReply*)), &eventLoop, SLOT(quit()));
    QNetworkReply *reply = manager.post(request, header.toUtf8());
    eventLoop.exec();
    qDebug() << "\n";
    qDebug() << reply->readAll();
}

void Get(QString uri)
{
    QLoggingCategory::setFilterRules("qt.network.ssl.warning=false");
    QEventLoop eventLoop;
    QNetworkAccessManager mgr;
    QObject::connect(&mgr, SIGNAL(finished(QNetworkReply*)), &eventLoop, SLOT(quit()));
    QUrl url(uri);
    QNetworkRequest req(url);
    QNetworkReply *reply = mgr.get(req);
    eventLoop.exec();
    qDebug() << "\n";
    qDebug() << reply->readAll();

}

#endif // HTTP_REQUEST_H
