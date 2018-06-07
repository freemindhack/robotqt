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
    Xml.cpp \
    voicethread.cpp

RESOURCES += qml.qrc \
    ajax.js\
    msc/msc.cfg \
    msc/res/asr/common.jet \
    msc/res/ivw/wakeupresource.jet \
    msc/res/tts/common.jet \
    msc/res/tts/xiaofeng.jet \
    msc/res/tts/xiaoyan.jet



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
    inc/tts.h \
    voicethread.h \
    inc/awaken.h \
    inc/aisound.h





DISTFILES += \
    dataloader.js \
    test.wav




INCLUDEPATH += $$PWD/.
DEPENDPATH += $$PWD/.


unix:!macx: LIBS += -L$$PWD/../lib/qt-arm-lib/ -laisound

INCLUDEPATH += $$PWD/../lib/qt-arm-lib
DEPENDPATH += $$PWD/../lib/qt-arm-lib

unix:!macx: LIBS += -L$$PWD/../lib/qt-arm-lib/ -laiui

INCLUDEPATH += $$PWD/../lib/qt-arm-lib
DEPENDPATH += $$PWD/../lib/qt-arm-lib

unix:!macx: LIBS += -L$$PWD/../lib/qt-arm-lib/ -lawaken

INCLUDEPATH += $$PWD/../lib/qt-arm-lib
DEPENDPATH += $$PWD/../lib/qt-arm-lib

unix:!macx: LIBS += -L$$PWD/../lib/qt-arm-lib/ -lf3bc4bio

INCLUDEPATH += $$PWD/../lib/qt-arm-lib
DEPENDPATH += $$PWD/../lib/qt-arm-lib

unix:!macx: LIBS += -L$$PWD/../lib/qt-arm-lib/ -lf3bc4bsp

INCLUDEPATH += $$PWD/../lib/qt-arm-lib
DEPENDPATH += $$PWD/../lib/qt-arm-lib

unix:!macx: LIBS += -L$$PWD/../lib/qt-arm-lib/ -lf3bc4cap

INCLUDEPATH += $$PWD/../lib/qt-arm-lib
DEPENDPATH += $$PWD/../lib/qt-arm-lib

unix:!macx: LIBS += -L$$PWD/../lib/qt-arm-lib/ -lf3bc4com

INCLUDEPATH += $$PWD/../lib/qt-arm-lib
DEPENDPATH += $$PWD/../lib/qt-arm-lib

unix:!macx: LIBS += -L$$PWD/../lib/qt-arm-lib/ -lf3bc4mat

INCLUDEPATH += $$PWD/../lib/qt-arm-lib
DEPENDPATH += $$PWD/../lib/qt-arm-lib

unix:!macx: LIBS += -L$$PWD/../lib/qt-arm-lib/ -lmsc

INCLUDEPATH += $$PWD/../lib/qt-arm-lib
DEPENDPATH += $$PWD/../lib/qt-arm-lib

unix:!macx: LIBS += -L$$PWD/../lib/qt-arm-lib/ -lpvsapiif

INCLUDEPATH += $$PWD/../lib/qt-arm-lib
DEPENDPATH += $$PWD/../lib/qt-arm-lib

unix:!macx: LIBS += -L$$PWD/../lib/qt-arm-lib/ -lpvs_hal

INCLUDEPATH += $$PWD/../lib/qt-arm-lib
DEPENDPATH += $$PWD/../lib/qt-arm-lib

unix:!macx: LIBS += -L$$PWD/../lib/qt-arm-lib/ -ltts

INCLUDEPATH += $$PWD/../lib/qt-arm-lib
DEPENDPATH += $$PWD/../lib/qt-arm-lib
