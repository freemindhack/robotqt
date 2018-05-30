#include "dianutils.h"

#include <QJsonDocument>
#include <QDebug>


Dianutils::Dianutils()
{

}

QJsonObject Dianutils::getJsonObjectFromString(const QString jsonString)
{
    QJsonDocument jsonDocument = QJsonDocument::fromJson(jsonString.toLocal8Bit().data());
    if( jsonDocument.isNull() ){
        qDebug()<< "===> please check the string "<< jsonString.toLocal8Bit().data();
    }
    QJsonObject jsonObject = jsonDocument.object();
    return jsonObject;
}

QString Dianutils::getStringFromJsonObject(const QJsonObject &jsonObject)
{
    return QString(QJsonDocument(jsonObject).toJson());
}
