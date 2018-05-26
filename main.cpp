extern "C"
#include <QGuiApplication>
#include <QDebug>
#include <http_request.h>
#include <QQmlApplicationEngine>
#include <httprequest.h>
#include <QNetworkAccessManager>
#include <QTextCodec>

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

//网络请求框架
    QNetworkAccessManager *m_manager = new QNetworkAccessManager();
    HTTPRequest *request = new HTTPRequest(NULL,m_manager); //or null network acess manager instance, http request can create it's own access manager
    request->setHandlerFunc([=] (QNetworkReply *reply) {
        if (reply) {
            QByteArray data = reply->readAll();
            QString string_data = QString::fromUtf8(data.data());
            qDebug() << string_data;
        }

        //delete captured request
        request->deleteLater();
    });

    QString url = "http://www.weather.com.cn/data/sk/101010100.html";
    request->get(url);





    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
