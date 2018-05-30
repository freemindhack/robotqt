#ifndef PALSERVICE_H
#define PALSERVICE_H


#include <QObject>
#include <QTimer>

extern std::string GLOBAL_USER_ID;//全局
extern std::int8_t GLOBAL_CURRENT_STATUS;//全局掌脉状态
extern std::int8_t GLOBAL_CONTROL_CODE;//全局指令

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

private:
  int timeRequest;//this is a times for calc request
};

#endif // PALSERVICE_H

