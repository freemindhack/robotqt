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
    QByteArrayData data[11];
    char stringdata0[101];
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
QT_MOC_LITERAL(7, 63, 15), // "getCallBackFunc"
QT_MOC_LITERAL(8, 79, 4), // "Func"
QT_MOC_LITERAL(9, 84, 1), // "c"
QT_MOC_LITERAL(10, 86, 14) // "getCurrentTime"

    },
    "VoiceThread\0speak\0\0receiveDataFromUI\0"
    "voiceStr\0initScan\0initASR\0getCallBackFunc\0"
    "Func\0c\0getCurrentTime"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_VoiceThread[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       6,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   44,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       3,    1,   45,    2, 0x0a /* Public */,
       5,    0,   48,    2, 0x0a /* Public */,
       6,    0,   49,    2, 0x0a /* Public */,
       7,    1,   50,    2, 0x0a /* Public */,
      10,    0,   53,    2, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void, QMetaType::QString,    4,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, 0x80000000 | 8,    9,
    QMetaType::QString,

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
        case 4: _t->getCallBackFunc((*reinterpret_cast< Func(*)>(_a[1]))); break;
        case 5: { QString _r = _t->getCurrentTime();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
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
        if (_id < 6)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 6;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 6)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 6;
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
