#include "c_udp.h"
#include <QByteArray>
#include <voicethread.h>
std::string GLOBAL_UDP_STR="0";
C_UDP::C_UDP()
{
        //创建一个QUdpSocket类对象，该类提供了Udp的许多相关操作
        receiver = new QUdpSocket();
        int port =18731;//设置UDP的端口号参数，指定在此端口上监听数据
        //此处的bind是个重载函数，连接本机的port端口，采用ShareAddress模式(即允许其它的服务连接到相同的地址和端口，特别是
        //用在多客户端监听同一个服务器端口等时特别有效)，和ReuseAddressHint模式(重新连接服务器)
        QHostAddress address;
        address.setAddress("192.168.100.169");
        int receive = receiver->bind(address,port);

        qDebug() << "receive: " <<receive << endl;
        if(receive == 0)
        {
            qDebug() << "UDP Connected Succeed 1111! " <<currentThreadId()<< endl;
        }
        else
        {
            qDebug() << "UDP Connected Faild 22222! "<<currentThreadId() << endl;
        }
}

QString C_UDP::getGLOBAL_UDP_STR()
{
    return QString::fromStdString(GLOBAL_UDP_STR);
}

void C_UDP::clearGLOBAL_UDP_STR()
{
   GLOBAL_UDP_STR="0";
}



void C_UDP::sendData()
{
    qDebug() << "QByteArray send: "<< endl;
    char  data[8]={0};
    data[3]=2;
    QHostAddress address;
    address.setAddress("192.168.100.169");
    qDebug() <<  currentThreadId() << endl;
    receiver->writeDatagram(data,8,address, 18731);

}




void C_UDP::run()
{


        while(1)
        {
            while(receiver->hasPendingDatagrams())  //拥有等待的数据报
            {
               //qDebug() << "receive succeed ! " << endl;
                QByteArray datagram; //拥于存放接收的数据报
               //pendingDatagramSize为返回第一个在等待读取报文的size，
               //resize函数是把datagram的size归一化到参数size的大小一样
               datagram.resize(receiver->pendingDatagramSize());
               //接收数据报，将其存放到datagram中
               //将读取到的不大于datagram.size()大小数据输入到datagram.data()中，
               //datagram.data()返回的是一个字节数组中存储数据位置的指针
               receiver->readDatagram(datagram.data(),datagram.size());
               //将数据报内容显示出来
               QString HexData = QString::fromStdString( datagram.toStdString());
               //判断数据是否完整
               GLOBAL_UDP_STR=HexData.toStdString();
               VoiceThread speaker;
               speaker.receiveDataFromUI(talk);
               qDebug() << HexData << currentThreadId()<<QString::fromStdString(GLOBAL_UDP_STR) << endl;

            }
        }
}

void C_UDP::processPendingDatagram()
{

}
