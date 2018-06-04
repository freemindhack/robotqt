#include "dianutils.h"
#include "httprequest.h"
#include "workthread.h"
#include <QDebug>
#include <QNetworkAccessManager>
#include <qjsondocument.h>
#include <qjsondocument.h>
#include <qjsonobject.h>
#include <pvs_hal.h>
#include <palservice.h>
#include <qcoreapplication.h>
#include <qscriptjson.h>
#include <QUdpSocket>

WorkThread::WorkThread(QObject *parent) : QObject(parent)
{

}
WorkThread::~WorkThread(){

}
//轮询请求网络数据
void WorkThread::getData(){
    //网络请求框架
        QNetworkAccessManager *m_manager = new QNetworkAccessManager();
        HTTPRequest *request = new HTTPRequest(NULL,m_manager); //or null network acess manager instance, http request can create it's own access manager
        request->setHandlerFunc([=] (QNetworkReply *reply) {
            if (reply) {
                WorkThread::isByScan=101;
                QByteArray data = reply->readAll();
                Dianutils dianUtils;
                QString string_data = QString::fromUtf8(data.data());
                QJsonObject datajson= dianUtils.getJsonObjectFromString(string_data);

//                QScriptJson qsj("/home/robot/Desktop/workplan/data.xml");
//                qsj.write2File();

                if(datajson.contains("weatherinfo")){
                    QJsonValue jsvalue=datajson.value("weatherinfo");
                    if(jsvalue.isObject()){
                        QJsonObject d=jsvalue.toObject();
                        if(d.contains("Radar")){
                           QString strHome = d.take("Radar").toString();
                           qDebug() << strHome<<"----------";
                        }
                        if(d.contains("city")){
                           QString strHome = d.take("city").toString();
                           qDebug() << strHome<<"----------";
                        }
                        if(d.contains("cityid")){
                           QString strHome = d.take("cityid").toString();
                           qDebug() << strHome<<"----------";
                        }
    //                    if (value.isArray()) {  // Version 的 value 是数组
    //                                    QJsonArray array = value.toArray();
    //                                    int nSize = array.size();
    //                                    for (int i = 0; i < nSize; ++i) {
    //                                        QJsonValue value = array.at(i);
    //                                        if (value.isDouble()) {
    //                                            double dVersion = value.toDouble();
    //                                            qDebug() << "Version : " << dVersion;
    //                                     }
    //                               }
    //                       }
                    }

                }


            }else{
                WorkThread::isByScan=100;
            }
            //delete captured request
            request->deleteLater();
        });

        QString url = "http://www.weather.com.cn/data/sk/101010100.html";
        request->get(url);
        qDebug()<<"get data";
}

void WorkThread::receiveDataFromCsharp()
{

}

void getRabbitMq(){


}


int WorkThread::sendWorkSignal()
{
    getRabbitMq();
    if(timeRequest<=5){
      timeRequest++;
    }else{
        timeRequest=0;
        //getData();
    }
    return WorkThread::isByScan;
}



//----------------------------------




