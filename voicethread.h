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
//语音列表
typedef std::function<void()> Func;
extern std::vector<std::string> voiceVector;


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
    void getCallBackFunc(Func c);
    QString getCurrentTime();
private:
     QSoundEffect effect;
     Func fback;
};

#endif // VOICETHREAD_H
