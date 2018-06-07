#ifndef VOICETHREAD_H
#define VOICETHREAD_H


#include <QTimer>
#include <QObject>
#include <QDebug>
#include <qsoundeffect.h>
#include <inc/tts.h>
#include <inc/awaken.h>
#include <inc/qisr.h>
#include <QDateTime>
#include <voicethread.h>
//语音列表
typedef std::function<void()> Func;
extern std::string voiceStr;
extern std::string oldVoiceStr;

class VoiceThread : public QObject
{
    Q_OBJECT
public:
    explicit VoiceThread(QObject *parent = nullptr);
    ~VoiceThread();
signals:
    void speak();

public slots:
    void receiveDataFromUI(QString voiceStr);
    void initScan();
    void initASR();
    QString getInStoreTime();
    QString getOffStoreTime();
    QString setInStoreTime();
    QString setOffStoreTime();
    void playerTTS(QString value);
//    size_t utf(const std::uint8_t* src, std::uint16_t& des);
    QString readFileFromLocal(QString name);
    void getCallBackFunc(Func c);
    QString getCurrentTime();
    QString getShopCart( );
    void setShopCart(QString msg);
private:
     QSoundEffect effect;
     Func fback;
     QString inStoreTime;
     QString offStoreTime;
     QString resultMsg;
};

#endif // VOICETHREAD_H
