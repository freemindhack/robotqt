/****************************************************************************
** Meta object code from reading C++ file 'voicethread.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.10.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "voicethread.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'voicethread.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.10.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_VoiceThread_t {
    QByteArrayData data[22];
    char stringdata0[230];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_VoiceThread_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_VoiceThread_t qt_meta_stringdata_VoiceThread = {
    {
QT_MOC_LITERAL(0, 0, 11), // "VoiceThread"
QT_MOC_LITERAL(1, 12, 5), // "speak"
QT_MOC_LITERAL(2, 18, 0), // ""
QT_MOC_LITERAL(3, 19, 17), // "receiveDataFromUI"
QT_MOC_LITERAL(4, 37, 8), // "voiceStr"
QT_MOC_LITERAL(5, 46, 8), // "initScan"
QT_MOC_LITERAL(6, 55, 7), // "initASR"
QT_MOC_LITERAL(7, 63, 14), // "getInStoreTime"
QT_MOC_LITERAL(8, 78, 15), // "getOffStoreTime"
QT_MOC_LITERAL(9, 94, 14), // "setInStoreTime"
QT_MOC_LITERAL(10, 109, 15), // "setOffStoreTime"
QT_MOC_LITERAL(11, 125, 9), // "playerTTS"
QT_MOC_LITERAL(12, 135, 5), // "value"
QT_MOC_LITERAL(13, 141, 17), // "readFileFromLocal"
QT_MOC_LITERAL(14, 159, 4), // "name"
QT_MOC_LITERAL(15, 164, 15), // "getCallBackFunc"
QT_MOC_LITERAL(16, 180, 4), // "Func"
QT_MOC_LITERAL(17, 185, 1), // "c"
QT_MOC_LITERAL(18, 187, 14), // "getCurrentTime"
QT_MOC_LITERAL(19, 202, 11), // "getShopCart"
QT_MOC_LITERAL(20, 214, 11), // "setShopCart"
QT_MOC_LITERAL(21, 226, 3) // "msg"

    },
    "VoiceThread\0speak\0\0receiveDataFromUI\0"
    "voiceStr\0initScan\0initASR\0getInStoreTime\0"
    "getOffStoreTime\0setInStoreTime\0"
    "setOffStoreTime\0playerTTS\0value\0"
    "readFileFromLocal\0name\0getCallBackFunc\0"
    "Func\0c\0getCurrentTime\0getShopCart\0"
    "setShopCart\0msg"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_VoiceThread[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
      14,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   84,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       3,    1,   85,    2, 0x0a /* Public */,
       5,    0,   88,    2, 0x0a /* Public */,
       6,    0,   89,    2, 0x0a /* Public */,
       7,    0,   90,    2, 0x0a /* Public */,
       8,    0,   91,    2, 0x0a /* Public */,
       9,    0,   92,    2, 0x0a /* Public */,
      10,    0,   93,    2, 0x0a /* Public */,
      11,    1,   94,    2, 0x0a /* Public */,
      13,    1,   97,    2, 0x0a /* Public */,
      15,    1,  100,    2, 0x0a /* Public */,
      18,    0,  103,    2, 0x0a /* Public */,
      19,    0,  104,    2, 0x0a /* Public */,
      20,    1,  105,    2, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void, QMetaType::QString,    4,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::Void, QMetaType::QString,   12,
    QMetaType::QString, QMetaType::QString,   14,
    QMetaType::Void, 0x80000000 | 16,   17,
    QMetaType::QString,
    QMetaType::QString,
    QMetaType::Void, QMetaType::QString,   21,

       0        // eod
};

void VoiceThread::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        VoiceThread *_t = static_cast<VoiceThread *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->speak(); break;
        case 1: _t->receiveDataFromUI((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 2: _t->initScan(); break;
        case 3: _t->initASR(); break;
        case 4: { QString _r = _t->getInStoreTime();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 5: { QString _r = _t->getOffStoreTime();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 6: { QString _r = _t->setInStoreTime();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 7: { QString _r = _t->setOffStoreTime();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 8: _t->playerTTS((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 9: { QString _r = _t->readFileFromLocal((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 10: _t->getCallBackFunc((*reinterpret_cast< Func(*)>(_a[1]))); break;
        case 11: { QString _r = _t->getCurrentTime();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 12: { QString _r = _t->getShopCart();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 13: _t->setShopCart((*reinterpret_cast< QString(*)>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            typedef void (VoiceThread::*_t)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&VoiceThread::speak)) {
                *result = 0;
                return;
            }
        }
    }
}

const QMetaObject VoiceThread::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_VoiceThread.data,
      qt_meta_data_VoiceThread,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *VoiceThread::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *VoiceThread::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_VoiceThread.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int VoiceThread::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 14)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 14;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 14)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 14;
    }
    return _id;
}

// SIGNAL 0
void VoiceThread::speak()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
