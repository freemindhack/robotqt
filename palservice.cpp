extern "C"
#include "dianutils.h"
#include "httprequest.h"
#include "palservice.h"
#include "voicethread.h"
#include "voicethread.h"
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
std::string GLOBAL_PHONE;    //手机后
std::string GLOBAL_PALM_COUNT="0";   //当前次数
std::string isInitPalm="0";
std::int8_t GLOBAL_CURRENT_OLD_STATUS;//全局掌脉状态

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
//    if(GLOBAL_CURRENT_STATUS==GLOBAL_CURRENT_OLD_STATUS)
//        return -1;
//    else
//        GLOBAL_CURRENT_OLD_STATUS=GLOBAL_CURRENT_STATUS;
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

QString PalService::getPhone()
{
    return QString::fromStdString(GLOBAL_PHONE);
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
void PalService::setPhone(QString s)
{
   GLOBAL_PHONE=s.toStdString();
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

    return QString::fromStdString( GLOBAL_CONTROL_PALM_RESULT);
}
void PalService::clearPalmData()
{
    GLOBAL_CONTROL_PALM_RESULT="0";
    isInitPalm="0";
}

VoiceThread speaker;

int handleInit(PVS_APIIF_GUI_STATE GuiState,PVS_APIIF_GUI_MESSAGE Message,PVS_APIIF_GUI_BITMAP *pBitmapArea){
//        pBitmapArea=pBitmapArea;
        if ((GuiState & PVS_APIIF_MESSAGE_PROVIDED) == PVS_APIIF_MESSAGE_PROVIDED)
        {
            switch (Message)
            {
            case PVS_APIIF_MESSAGE_PLACE_RIGHT:
                {
                    qDebug()<<("放上手掌\n");
                    GLOBAL_CURRENT_STATUS=8;
                    break;
                }
            case PVS_APIIF_MESSAGE_HOLD_UP_HAND:
                {
                    qDebug()<<("放上手掌\n");
                    GLOBAL_CURRENT_STATUS=25;
                    break;
                }
            case PVS_APIIF_MESSAGE_CORRECTLY:
                {
                    qDebug()<<("请正确放置手\n");
                    GLOBAL_CURRENT_STATUS=2;
                    break;
                }
            case PVS_APIIF_MESSAGE_CLOSE:
                {
                    qDebug()<<("请将手靠近\n");
                    GLOBAL_CURRENT_STATUS=3;
                    break;
                }
            case PVS_APIIF_MESSAGE_KEEP_AWAY:
                {
                    qDebug()<<("请抬高手掌\n");
                    GLOBAL_CURRENT_STATUS=4;
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
                GLOBAL_CURRENT_STATUS=7;
                    qDebug()<<("请移开手,稍后再放回\n");
                    break;
                }
            case PVS_APIIF_MESSAGE_TEST_RIGHT:
            case PVS_APIIF_MESSAGE_SAVING:
            case PVS_APIIF_MESSAGE_AUTHENTICATING:
            case PVS_APIIF_MESSAGE_STOP_MOVING:
                {
                    qDebug()<<("请保持");
                    GLOBAL_CURRENT_STATUS=1;
                    break;
                }
            case PVS_APIIF_MESSAGE_EVEN_UP:
            case PVS_APIIF_MESSAGE_SENSOR_ORIENT:
            case PVS_APIIF_MESSAGE_FLATTEN_OUT:
                {
                        qDebug()<<("手掌放平");
                        GLOBAL_CURRENT_STATUS=26;
                    break;
                }
            case PVS_APIIF_MESSAGE_FINGER_OPEN:
                {
                        qDebug()<<("请张开手指");
                        GLOBAL_CURRENT_STATUS=22;
                    break;
                }
            case PVS_APIIF_MESSAGE_MOVE_FORWARD:
                {
                        qDebug()<<("向前移动");
                        GLOBAL_CURRENT_STATUS=18;
                    break;
                }
            case PVS_APIIF_MESSAGE_MOVE_BACKWARD:
                {
                        qDebug()<<("向后移动");
                        GLOBAL_CURRENT_STATUS=19;
                    break;
                }
            case PVS_APIIF_MESSAGE_MOVE_LEFT:
                {
                        qDebug()<<("向左移动");
                        GLOBAL_CURRENT_STATUS=13;
                    break;
                }
            case PVS_APIIF_MESSAGE_MOVE_RIGHT:
                {
                        qDebug()<<("向右移动");
                        GLOBAL_CURRENT_STATUS=17;
                    break;
                }

            case PVS_APIIF_MESSAGE_RETRY_RIGHT:
                {
                        qDebug()<<("重新开始采集");
                        GLOBAL_CURRENT_STATUS=10;
                    break;
                }
            case PVS_APIIF_MESSAGE_FAILED_RIGHT:
            case PVS_APIIF_MESSAGE_BRIGHT_MOMENT:
            case PVS_APIIF_MESSAGE_BRIGHT_NG:
                {
                        qDebug()<<("重新采集,请不要移动您的手");
                        GLOBAL_CURRENT_STATUS=24;
                    break;
                }

            default:
                {
                        qDebug()<<("采集中...");
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
   GLOBAL_CONTROL_PALM_OPTYPE=1;
   GLOBAL_CURRENT_STATUS=9;
   hal_pvs_init((CALLBACK_FUNC *)handleInit,&pbr);
//   std::string palmData="0";
   GLOBAL_CONTROL_PALM_RESULT="0";
   hal_pvs_enroll(GLOBAL_CONTROL_PALM_RESULT,&pbr);
   terminate();
   //lock done get data finished
//   GLOBAL_CONTROL_PALM_RESULT=palmData;
//   setChangeValue("4");
   qDebug()<<QString::fromStdString(GLOBAL_CONTROL_PALM_RESULT)+"----init success";
   while (GLOBAL_CONTROL_PALM_RESULT!="0") {
       qDebug()<<"--------init success";
   }
}

void PalService::ecoll()
{
   qDebug()<<"注册扫描";
}

void PalService::capture()
{
  qDebug()<<"获取数据--------capture";
  GLOBAL_CURRENT_STATUS=19;
  PVS_BIOAPI_RETURN pbr;
  hal_pvs_init((CALLBACK_FUNC *)handleInit,&pbr);
//  std::string palmData="0";
  GLOBAL_CONTROL_PALM_RESULT="0";
  hal_pvs_capture(GLOBAL_CONTROL_PALM_RESULT,&pbr);
//  GLOBAL_CONTROL_PALM_RESULT=palmData;
  terminate();

//  setChangeValue("4");
  qDebug()<<QString::fromStdString(GLOBAL_CONTROL_PALM_RESULT)+"--------capture success";
  while (GLOBAL_CONTROL_PALM_RESULT!="0") {
      qDebug()<<"--------capture success";
  }
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
    qDebug()<<"zhixin______________"+(GLOBAL_CONTROL_CODE);

    switch ((int)GLOBAL_CONTROL_CODE) {
    case 1:
        qDebug()<<"开启初始化";
        if(isInitPalm=="1"){
            qDebug()<<"yijingchushihua,using______________";
            break;
        }
        isInitPalm="0";
        PalService::init();
        break;
    case 2:
        qDebug()<<"开启注册";
        break;
    case 3:
        qDebug()<<"开启采集";
        if(isInitPalm=="1"){
            qDebug()<<"yijingchushihua,using______________";
            break;
        }
        isInitPalm="0";
        PalService::capture();

        break;
    case 4:
        PalService::terminate();
        GLOBAL_CONTROL_CODE=0;
        break;
    case 5:
        PalService::terminate();
        GLOBAL_CONTROL_CODE=0;
        break;
    default:
        break;
    }

}

void PalService::setChangeValue(QString value)
{
    //control palm init
   GLOBAL_CONTROL_CODE=value.toInt();

    qDebug()<<"set control value successful"+value+"----"+GLOBAL_CONTROL_CODE;
}

