#ifndef DIANUTILS_H
#define DIANUTILS_H

#include <QJsonObject>
#include <QString>


class Dianutils
{
public:
    Dianutils();
    // QString >> QJson
    QJsonObject getJsonObjectFromString(const QString jsonString);
    // QJson >> QString
    QString getStringFromJsonObject(const QJsonObject& jsonObject);
};

#endif // DIANUTILS_H
