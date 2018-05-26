#include "gameapi.h"
#include "qdebug.h"

#include <QJsonArray>
#include <QJsonObject>
#include <QJsonDocument>

const QString GET_GAME = QString("https://www.baidu.com").append("/apps");
GameAPI::GameAPI()
{

}
GameAPI::~GameAPI()
{

}
void GameAPI::requestFinished(QNetworkReply* reply, const QByteArray data, const int statusCode)
{
    if (statusCode == 200) {
        QJsonParseError jsonError;
        QJsonArray json_array = QJsonDocument::fromJson(data, &jsonError).array();
        if(jsonError.error == QJsonParseError::NoError) {
            QList<QPair<QString,QString>> games;
            for(int i = 0; i < json_array.size(); ++i) {
                   QJsonObject json = json_array.at(i).toObject();
                   games.append(qMakePair(json.value("key1").toString(), json.value("key2").toString()));
            }
            this->checkCallback(true, games);
            return;
        }
    }
    QList<QPair<QString,QString>> games;
    this->checkCallback(false, games);
}
void GameAPI::getGameList(std::function<void(bool, QList<QPair<QString,QString>>)> callback)
{
    this->checkCallback = callback;
    get(GET_GAME);
}
