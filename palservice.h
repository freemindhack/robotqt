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
extern std::string GLOBAL_PHONE;
extern std::string GLOBAL_PALM_COUNT;   //当前次数
extern std::string isInitPalm;
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
    QString getPhone();
    void setPhone(QString s);
    QString getPalmCount();
    void setPhoneFour(QString s);
    void setCurrentUserID(QString userID);
private:
  int timeRequest;//this is a times for calc request

//  QString palmServelInit="http://118.31.35.229:8080/palmgw/app211b81d83c2048b792c030b928e7aeae/C1001.htm";
//  QString palmServelInit="http://61.155.196.50:52125/palmgw/appb2b1e78ca6ec44dab7e4e3981331c483/C1001.htm";
//  QString palmServelReg="http://61.155.196.50:52125/palmgw/appb2b1e78ca6ec44dab7e4e3981331c483/C2003.htm";
//  QString palmServelReg="http://118.31.35.229:8080/palmgw/app211b81d83c2048b792c030b928e7aeae/C2003.htm";
//  QString companyUrl="https://api.quixmart.com/quixmart-api/";
  QString companyUrl="http://27.115.36.78:10111/";
  QString robotName="AA20170606";
  QString localServer="http://192.168.100.164:8733/androidServer/";
  QString releaseUrl="https://api.quixmart.com/quixmart-api/";

  QSoundEffect effect;
  QString palmServelInit="https://palm-test.quixmart.com/v1/mobile/api/grampus/";
  QString palmServelReg="https://palm-test.quixmart.com/v1/mobile/api/grampus/";

};

#endif // PALSERVICE_H

