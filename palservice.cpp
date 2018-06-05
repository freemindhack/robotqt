extern "C"
#include "dianutils.h"
#include "httprequest.h"
#include "palservice.h"
#include <QDebug>
#include <QDomDocument>
#include <pvs_hal.h>
#include <qnetworkaccessmanager.h>
#include <tinyxml2.h>
#include <qscriptjson.h>
#include <inc/tts.h>

std::string GLOBAL_USER_ID="0";
std::int8_t GLOBAL_CURRENT_STATUS;//全局掌脉状态
std::int8_t GLOBAL_CONTROL_CODE;//全局指令
std::string GLOBAL_CONTROL_PALM_RESULT;//全局指令
std::int8_t GLOBAL_CONTROL_PALM_OPTYPE;//全局指令
std::string GLOBAL_PHONE_FOUR;    //手机后四位
std::string GLOBAL_PALM_COUNT="0";   //当前次数

const QString AddNewUser="1";
const QString UpdateUser="2";
const QString DeleteUser="3";

PalService::PalService(QObject *parent) : QObject(parent)
{

}

PalService::~PalService()
{

}

int PalService::getPalmStatus()
{
    return GLOBAL_CURRENT_STATUS;

}

QString PalService::getServelInit()
{
    return palmServelInit;

}

QString PalService::getCurrentUserID()
{
    return QString::fromStdString(GLOBAL_USER_ID);

}

QString PalService::getPhoneFour()
{
    return QString::fromStdString(GLOBAL_PHONE_FOUR);
}

QString PalService::subPhoneFour()
{
    QString str;
    str=QString::fromStdString(GLOBAL_PHONE_FOUR);
    if(str.length()>0){
        str=str.mid(0,str.length()-1);
    }
    GLOBAL_PHONE_FOUR=str.toStdString();
    return str;

}

QString PalService::getPalmCount()
{
    return QString::fromStdString(GLOBAL_PALM_COUNT);

}

void PalService::setPhoneFour(QString s)
{
   GLOBAL_PHONE_FOUR=s.toStdString();
}

void PalService::setCurrentUserID(QString userID)
{
    qDebug()<<userID;
     GLOBAL_USER_ID=userID.toStdString();
}

QString PalService::getComponyUrl()
{
    return companyUrl;

}
QString PalService::getRobotName()
{
    return robotName;

}

QString PalService::getXMLByNodeName(QString xml,QString nodeName, QString xmlNode)
{
    Xml xmlParse;
    return xmlParse.readText(xml,nodeName,xmlNode);

}
QString PalService::getLocalServer()
{
    return localServer;

}


QString PalService::getServelReg()
{
    return palmServelReg;

}

QString PalService::getPalmData()
{
    if(GLOBAL_CONTROL_PALM_RESULT=="0"){
        return NULL;
    }
    return QString::fromStdString( GLOBAL_CONTROL_PALM_RESULT);
}
void PalService::clearPalmData()
{
    GLOBAL_CONTROL_PALM_RESULT="0";
}
int handleInit(PVS_APIIF_GUI_STATE GuiState,PVS_APIIF_GUI_MESSAGE Message,PVS_APIIF_GUI_BITMAP *pBitmapArea){
        pBitmapArea=pBitmapArea;

        if ((GuiState & PVS_APIIF_MESSAGE_PROVIDED) == PVS_APIIF_MESSAGE_PROVIDED)
        {
            switch (Message)
            {
            case PVS_APIIF_MESSAGE_PLACE_RIGHT:
                {
                    qDebug()<<("放上手掌\n");
                    break;
                }
            case PVS_APIIF_MESSAGE_HOLD_UP_HAND:
                {
                    qDebug()<<("放上手掌\n");
                    break;
                }
            case PVS_APIIF_MESSAGE_CORRECTLY:
                {
                    qDebug()<<("请正确放置手\n");
                    break;
                }
            case PVS_APIIF_MESSAGE_CLOSE:
                {
                    qDebug()<<("请将手靠近\n");
                    break;
                }
            case PVS_APIIF_MESSAGE_KEEP_AWAY:
                {
                    qDebug()<<("请抬高手掌\n");
                    break;
                }
            case PVS_APIIF_MESSAGE_MOVE_AWAY:
                {
                if(GLOBAL_PALM_COUNT=="0"){
                    GLOBAL_PALM_COUNT="1";
                }else if(GLOBAL_PALM_COUNT=="1"){
                    GLOBAL_PALM_COUNT="2";
                }else if(GLOBAL_PALM_COUNT=="2"){
                    GLOBAL_PALM_COUNT="3";
                }
                    qDebug()<<("请移开手,稍后再放回\n");
                    break;
                }
            case PVS_APIIF_MESSAGE_TEST_RIGHT:
            case PVS_APIIF_MESSAGE_SAVING:
            case PVS_APIIF_MESSAGE_AUTHENTICATING:
            case PVS_APIIF_MESSAGE_STOP_MOVING:
                {
                    qDebug()<<("请保持\n");
                    GLOBAL_CURRENT_STATUS=PVS_APIIF_MESSAGE_STOP_MOVING;
                    break;
                }
            case PVS_APIIF_MESSAGE_EVEN_UP:
            case PVS_APIIF_MESSAGE_SENSOR_ORIENT:
            case PVS_APIIF_MESSAGE_FLATTEN_OUT:
                {
                    qDebug()<<("手掌放平\n");
                    break;
                }
            case PVS_APIIF_MESSAGE_FINGER_OPEN:
                {
                    qDebug()<<("请张开手指\n");
                    break;
                }
            case PVS_APIIF_MESSAGE_MOVE_FORWARD:
                {
                    qDebug()<<("向前移动\n");
                    break;
                }
            case PVS_APIIF_MESSAGE_MOVE_BACKWARD:
                {
                    qDebug()<<("向后移动\n");
                    break;
                }
            case PVS_APIIF_MESSAGE_MOVE_LEFT:
                {
                    qDebug()<<("向左移动\n");
                    break;
                }
            case PVS_APIIF_MESSAGE_MOVE_RIGHT:
                {
                    qDebug()<<("向右移动\n");
                    break;
                }

            case PVS_APIIF_MESSAGE_RETRY_RIGHT:
                {
                    qDebug()<<("重新开始采集\n");
                    break;
                }
            case PVS_APIIF_MESSAGE_FAILED_RIGHT:
            case PVS_APIIF_MESSAGE_BRIGHT_MOMENT:
            case PVS_APIIF_MESSAGE_BRIGHT_NG:
                {
                    qDebug()<<("重新采集,请不要移动您的手\n");
                    break;
                }

            default:
                {
                    qDebug()<<("采集中...\n");
                    break;
                }
            }
        }

        return PVS_APIIF_OK;
}




void PalService::init()

{
   qDebug()<<"初始化以及获取状态，时时提醒用户手到操作"<<QString::fromStdString(GLOBAL_USER_ID);
   PVS_BIOAPI_RETURN pbr;
   hal_pvs_init((CALLBACK_FUNC *)handleInit,&pbr);
   std::string palmData="0";

   hal_pvs_enroll(palmData,&pbr);
   //lock done get data finished
   GLOBAL_CONTROL_PALM_RESULT=palmData;
   GLOBAL_CONTROL_PALM_OPTYPE=1;
   GLOBAL_USER_ID="1111";
   GLOBAL_CURRENT_STATUS=9;
   cancle();
   terminate();
   qDebug()<<QString::fromStdString(palmData);
}



void PalService::ecoll()
{
   qDebug()<<"注册扫描";
}

void PalService::capture()
{
  qDebug()<<"获取数据";
  PVS_BIOAPI_RETURN pbr;
  hal_pvs_init((CALLBACK_FUNC *)handleInit,&pbr);
  std::string palmData="0";
  hal_pvs_capture(palmData,&pbr);

  GLOBAL_CONTROL_PALM_RESULT=palmData;
  GLOBAL_USER_ID="17317396108";
  GLOBAL_CURRENT_STATUS=19;
  qDebug()<<QString::fromStdString(palmData);
}
void PalService::cancle(){
    PVS_BIOAPI_RETURN pbr;
    hal_pvs_cancel(PVS_APIIF_CANCEL_CANCEL,&pbr);
    qDebug()<<"取消刷手";
}
void PalService::terminate(){
    PVS_BIOAPI_RETURN pbr;
    cancle();
    hal_pvs_terminate(&pbr);
    qDebug()<<"关闭设备";
}

//控制指令exec
void PalService::changeValueByCode()
{
    while (true) {
        switch (GLOBAL_CONTROL_CODE) {
        case 1:
//            qDebug()<<"开启初始化";
            if(!isInitPalm)
               PalService:: init();
            isInitPalm=true;
            break;
        case 2:
            qDebug()<<"开启注册";
            break;
        case 3:
            PalService::capture();
            qDebug()<<"开启采集";
            break;
        case 4:
//            qDebug()<<"开始关闭";
            if(isInitPalm){
               PalService::terminate();
               isInitPalm=false;
            }
            break;
        case 5:
            qDebug()<<"取消采集";
            PalService::cancle();
            break;
        default:
            break;
        }

    }

}

void PalService::setChangeValue(QString value)
{
    GLOBAL_CONTROL_CODE=value.toInt();

    qDebug()<<"set control value successful";
}

void PalService::playerTTS(QString value)
{
    QString path="text.wav";
    QByteArray bytestext=value.toUtf8();
    QByteArray bytespath=path.toUtf8();
     qDebug()<<"player111";

     qint8 status= start_tts(NULL, bytestext.data(), bytespath.data());
     qDebug()<<"player";

    if(status==0){
        qDebug()<<"player";
    //    effect.setSource(QUrl::fromLocalFile("/home/robot/test.wav"));
        //循环播放
        effect.setSource(path);
//        effect.setLoopCount(QSoundEffect::Infinite);
            //设置音量，0-1
        effect.setVolume(0.8f);
        effect.play();
    }

}
