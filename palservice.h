#ifndef PALSERVICE_H
#define PALSERVICE_H


#include <QObject>
#include <QSoundEffect>
#include <QTimer>
#include <Xml.h>
extern std::string GLOBAL_USER_ID;//全局
extern std::int8_t GLOBAL_CURRENT_STATUS;//全局掌脉状态
extern std::int8_t GLOBAL_CONTROL_CODE;//全局指令
extern std::string GLOBAL_CONTROL_PALM_RESULT;//全局结果
extern std::int8_t GLOBAL_CONTROL_PALM_OPTYPE;//全局类型
extern std::string GLOBAL_PHONE_FOUR;

class PalService : public QObject
{
    Q_OBJECT
public:
     explicit PalService(QObject *parent = nullptr);
     ~PalService();
signals:
    int palm();
public slots:
    int getPalmStatus();
    void init();
    void ecoll();
    void capture();
    void cancle();
    void terminate();
    void changeValueByCode();
    void setChangeValue( QString value);
    void playerTTS(QString value);
    QString getPalmData();
    void clearPalmData();
    QString getServelInit();
    QString getServelReg();
    QString getRobotName();
    QString getXMLByNodeName(QString xml,QString nodeName,QString nodeName2);
    QString getComponyUrl();
    QString getLocalServer();
    QString getCurrentUserID();
    QString getPhoneFour();
    QString subPhoneFour();
    void setPhoneFour(QString s);
    void setCurrentUserID(QString userID);
private:
  int timeRequest;//this is a times for calc request
  QSoundEffect effect;
  QString palmServelInit="http://118.31.35.229:8080/palmgw/app211b81d83c2048b792c030b928e7aeae/C1001.htm";
  QString palmServelReg="http://118.31.35.229:8080/palmgw/app211b81d83c2048b792c030b928e7aeae/C2003.htm";
  QString companyUrl="https://api.quixmart.com/quixmart-api/";
  QString robotName="Robot20170923";
  QString localServer="http://192.168.100.164:8733/androidServer/";
  bool isInitPalm=false;
};

#endif // PALSERVICE_H

