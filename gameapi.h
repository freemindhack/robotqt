#ifndef GAMEAPI_H
#define GAMEAPI_H


class GameAPI : public BaseAPI
{
public:
    GameAPI();
    ~GameAPI();
    void getGameList(std::function<void(bool, QList<QPair<QString,QString>>)> callback);

protected:
    void requestFinished(QNetworkReply* reply, const QByteArray data, const int statusCode);

private:
    std::function<void(bool, QList<QPair<QString,QString>>)> checkCallback;

};

#endif // GAMEAPI_H
