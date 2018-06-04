QT += quick
CONFIG += c++11
QT += network
QT += xml
QT += multimedia
QT       += script
# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += main.cpp \
    httprequest.cpp \
    runnable.cpp \
    workthread.cpp \
    palservice.cpp \
    dianutils.cpp \
    tinyxml2.cpp \
    qscriptjson.cpp \
    c_udp.cpp \
    Xml.cpp

RESOURCES += qml.qrc \
ajax.js

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    http_request.h \
    httprequest.h \
    httprequest_global.h \
    runnable.h \
    workthread.h \
    palservice.h \
    pvs_hal.h \
    pvsapiif.h \
    pvsapiifcommon.h \
    pvsapiiftypes.h \
    dianutils.h \
    tinyxml2.h \
    commoncontants.h \
    qscriptjson.h \
    AHeaders.h \
    SimpleAmqpClient.h \
    SimpleAmqpClient/AmqpException.h \
    SimpleAmqpClient/AmqpLibraryException.h \
    SimpleAmqpClient/AmqpResponseLibraryException.h \
    SimpleAmqpClient/BadUriException.h \
    SimpleAmqpClient/BasicMessage.h \
    SimpleAmqpClient/Channel.h \
    SimpleAmqpClient/ChannelImpl.h \
    SimpleAmqpClient/ConnectionClosedException.h \
    SimpleAmqpClient/ConsumerCancelledException.h \
    SimpleAmqpClient/ConsumerTagNotFoundException.h \
    SimpleAmqpClient/Envelope.h \
    SimpleAmqpClient/MessageReturnedException.h \
    SimpleAmqpClient/SimpleAmqpClient.h \
    SimpleAmqpClient/Table.h \
    SimpleAmqpClient/TableImpl.h \
    SimpleAmqpClient/Util.h \
    SimpleAmqpClient/Version.h \
    c_udp.h \
    Xml.h \
    inc/formats.h \
    inc/linuxrec.h \
    inc/msp_cmn.h \
    inc/msp_errors.h \
    inc/msp_types.h \
    inc/qise.h \
    inc/qisr.h \
    inc/qivw.h \
    inc/qtts.h \
    inc/speech_recognizer.h \
    inc/tts.h




unix:!macx: LIBS += -L$$PWD/../sensord/pvs/ -lpvs_hal

INCLUDEPATH += $$PWD/../sensord/pvs
DEPENDPATH += $$PWD/../sensord/pvs

unix:!macx: LIBS += -L$$PWD/../sensord/pvs/pvslib/ -lf3bc4bio

INCLUDEPATH += $$PWD/../sensord/pvs/pvslib
DEPENDPATH += $$PWD/../sensord/pvs/pvslib

unix:!macx: LIBS += -L$$PWD/../sensord/pvs/pvslib/ -lf3bc4bsp

INCLUDEPATH += $$PWD/../sensord/pvs/pvslib
DEPENDPATH += $$PWD/../sensord/pvs/pvslib

unix:!macx: LIBS += -L$$PWD/../sensord/pvs/pvslib/ -lf3bc4cap

INCLUDEPATH += $$PWD/../sensord/pvs/pvslib
DEPENDPATH += $$PWD/../sensord/pvs/pvslib

unix:!macx: LIBS += -L$$PWD/../sensord/pvs/pvslib/ -lf3bc4com

INCLUDEPATH += $$PWD/../sensord/pvs/pvslib
DEPENDPATH += $$PWD/../sensord/pvs/pvslib

unix:!macx: LIBS += -L$$PWD/../sensord/pvs/pvslib/ -lf3bc4mat

INCLUDEPATH += $$PWD/../sensord/pvs/pvslib
DEPENDPATH += $$PWD/../sensord/pvs/pvslib

unix:!macx: LIBS += -L$$PWD/../sensord/pvs/pvslib/ -lpvsapiif

INCLUDEPATH += $$PWD/../sensord/pvs/pvslib
DEPENDPATH += $$PWD/../sensord/pvs/pvslib

DISTFILES += \
    dataloader.js \
    test.wav \
    msc/msc_back/res/ivw/wakeupresource.jet \
    msc/msc_back/res/tts/common.jet \
    msc/msc_back/res/tts/xiaofeng.jet \
    msc/msc_back/res/tts/xiaoyan.jet \
    msc/res/ivw/wakeupresource.jet \
    msc/res/tts/common.jet \
    msc/res/tts/xiaofeng.jet \
    msc/res/tts/xiaoyan.jet \
    msc/ca5a81647a6d5f14f1e91be345abf427/cfg.ldata \
    msc/ca5a81647a6d5f14f1e91be345abf427/kaisound.dat \
    msc/msc_back/ca5a81647a6d5f14f1e91be345abf427/cfg.ldata \
    msc/msc_back/ca5a81647a6d5f14f1e91be345abf427/kaisound.dat \
    msc/msc_back/msc.cfg \
    msc/msc.cfg \



unix:!macx: LIBS += -L$$PWD/../SimpleAmqpClient/simpleamqpclient-build/ -lSimpleAmqpClient

INCLUDEPATH += $$PWD/../SimpleAmqpClient/simpleamqpclient-build
DEPENDPATH += $$PWD/../SimpleAmqpClient/simpleamqpclient-build


INCLUDEPATH += $$PWD/.
DEPENDPATH += $$PWD/.

unix:!macx: LIBS += -L$$PWD/lib/ -ltts

INCLUDEPATH += $$PWD/.
DEPENDPATH += $$PWD/.

unix:!macx: LIBS += -L$$PWD/lib/ -lmsc

INCLUDEPATH += $$PWD/.
DEPENDPATH += $$PWD/.

unix:!macx: LIBS += -L$$PWD/lib/ -laisound

INCLUDEPATH += $$PWD/.
DEPENDPATH += $$PWD/.
