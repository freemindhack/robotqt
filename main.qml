import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4
import blue.deep.work 1.0
import blue.deep.palm 1.0
import "ajax.js" as AjaxScript
import blue.deep.cudp 1.0;
import blue.deep.voice 1.0;

ApplicationWindow {
    visible: true
    width: 800
    height: 480
    color: "#ff00ff00";
    title: qsTr("深兰科技")
    signal workThreadSignal(int message)
    onWorkThreadSignal: workFunction(message)
    function workFunction(parameter) {
            switch(parameter){
              case 100:
//                  console.log("no data by scan")
                  break;
              case 101:
//                  if(swipeView.currentIndex!=3)
                     backToIndex()
//                  console.log("has data by scan")
                  break;
              case 1:
//                  if(swipeView.currentIndex!=2)
//                     swipeView.currentIndex=2;
//                  console.log("please keep hold")
                  break;
              case 9:
                  var phone = palservice.getPhone();
                  var venn9 = palservice.getPalmData();
                  var userId =palservice.getCurrentUserID()
                  console.log(venn9+ "扫手注册成功"+parameter)
                  if(venn9==="0"){
                    return;
                  }
                  palservice.setChangeValue(4)
                  palservice.clearPalmData()
                  timerpalmService.stop()
                  doPostPlam(venn9,phone,userId,"1");//调用

                  break;
              case 19:
                  var venn = palservice.getPalmData();
                  var phonefour = palservice.getPhoneFour();
                  console.log(venn+"扫手成功并开门"+parameter)
                  if(venn==="0"){
                    return;
                  }
                  palservice.setChangeValue(4)
                  palservice.clearPalmData()
                  timerpalmService.stop()
                  doPostPlamReg(venn,phonefour);//调用

                  break;
              case 999:
                  break;
              case 1001:
                  break;
              default:
                  console.log("处理voice"+parameter)
                  playtts();
                  break;
            }

     }


    Rectangle {
        id: swipeView
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        smooth: false
        enabled: true
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        //获取useridtimer
        Timer {
            id: timerGetUserId
            interval: 2000;//如果没有成功就再次开启
            repeat: true
            running: true
            triggeredOnStart: true
            onTriggered: {
                // cudp.onUdp()
                 getCurrentUserFunc(1)
            }
        }
        Timer {
            id: timerGetRegister
            interval: 2000;//如果没有成功就再次开启
            repeat: true
            running: false
            triggeredOnStart: true
            onTriggered: {
                // cudp.onUdp()
                if(palservice.getPalmCount()==="0"){
                    getCurrentUserFunc(2)
                }else if(palservice.getPalmCount()==="1"){
                    regCaptureImg.source="img/scan2.png"
                }else if(palservice.getPalmCount()==="2"){
                    regCaptureImg.source="img/scan3.png"
                }
            }
        }
        //获取开启掌脉
        Timer {
            id: timerpalmService
            interval: 100;//如果没有成功就再次开启
            repeat: true
            running: false
            triggeredOnStart: true
            onTriggered: {
                 console.log(palservice.getPalmStatus()+"######------")                 
                 palservice.onPalm()

            }
        }

        //定时操作
        Timer {
            id: timerCommon
            interval: 30000;//
            repeat: true
            running: false
            triggeredOnStart: false
            onTriggered: {
                timerGetUserId.start()
                backToIndex()
                timerCommon.stop();
            }
        }


        //定时操作
        Timer {
            id: timerTipsCheck
            interval: 3000;//
            repeat: false
            running: false
            triggeredOnStart: false
            onTriggered: {
                setUnVisible();
                checkout.visible=true;
                timerCommon.start();
            }
        }

        //定时move操作
        Timer {
            id: timerRobot
            interval: 60000;//
            repeat: true
            running: false
            triggeredOnStart: false
            onTriggered: {
                if(systemerror.visible){
                   backToIndex()
                }
                if(index.visible){
                  startRobotFunc()
                  timerRobot.stop
                }else{
                  timerRobot.stop()
                }
            }
        }

       //------------------------------------------------1 shoplist page-----------------------------------------------------
  Rectangle{
            id:shoplist
               width: 800
               height: 480
               visible:false
               MouseArea{
                   anchors.fill : parent
                   onClicked: stopRobotFunc()
                   onPositionChanged: swipeView.enabled=false
                   onReleased: swipeView.enabled=true
               }

        Image {
            source: "img/shoplist.png"
            width: 800
            height: 480

           Rectangle{
               x:0
               y:127
               width: 800
               height: 290

              BusyIndicator{
                id:indicator
                running: false
                z:2
                anchors.centerIn: parent
             }
             Timer{
                 id:timer
                 interval: 2000
                 running: false
                 onTriggered: indicator.running=false
             }
             ListModel{
                 id:lm
                  ListElement{name:" ";price:" ";weight:" "}

             }

             ListView{
                 id:lv
                  width:parent.width
                  height:parent.height
                  model:lm
                  focus: true
                  clip:true
                  Component.onCompleted: {
                      console.log("contentY:"+lv.contentY)
                      console.log("contentHeight"+lv.contentHeight)
                      console.log("Height:"+lv.height)
                  }
                  onFlickEnded:
                  {
                      if(lv.contentY<1)
                      {
                          console.log("下拉刷新")
                      }
                  }
                  onFlickStarted:{
                     console.log("开始拉动"+contentY)
                      //内容右上角Y>0 表示 上拉
                      //contentHeight内容高度-内容右上角Y=屏幕+剩下内容宽度
                      //如果剩下内容宽度 不足listview 高度的9/10 就是下拉刷新了
//                      if(1){
//                         getShopCart(1);
//                      }
                 }

                 delegate:Rectangle {
                     width:parent.width
                     height:50
                     color:ListView.isCurrentItem?"#a8e6ff":"white"
                     Label{
                         x:30
                         y:5
                         width:700
                         height: 50
                         font.pixelSize: 18
                         font.bold: false
                         color: "#333333"
                         verticalAlignment: Text.AlignTop
                         horizontalAlignment: Text.AlignLeft
                         text: name
                     }
                     Label{
                         x:30
                         y:10
                         width:700
                         height: 50
                         font.pixelSize: 15
                         color: "#999999"
                         verticalAlignment: Text.AlignVCenter
                         horizontalAlignment: Text.AlignLeft
                         text: weight
                     }
                     Label{
                         x:700
                         y:0
                         width:100
                         height: 50
                         text: price
                         font.pixelSize: 25
                         font.bold: true
                         color: "#ff722b"
                         verticalAlignment: Text.AlignVCenter
                         horizontalAlignment: Text.AlignHCenter
                     }
                     MouseArea{
                         anchors.fill: parent
                         onClicked: {
                             lv.currentIndex=index
                         }
                      }
                 }
             }

           }
           Image {
             id: image2
             x: 27
             y: 60
             width: 58
             height: 15
             fillMode: Image.Tile
             source: "img/back_grey.png"
             MouseArea{
                 anchors.rightMargin: 0
                 anchors.bottomMargin: 0
                 anchors.leftMargin: 0
                 anchors.topMargin: 0
                 anchors.fill: parent
                 onClicked: {
                     backToIndex()
                 }
             }
           }
      }
}

       //------------------------------------------------2 qrcode page-----------------------------------------------------
  Rectangle{
         id:index
            width: 800
            height: 480
           visible: true
            MouseArea{
                anchors.fill : parent
                onClicked: stopRobotFunc()
            }

        Image {
            id: qrcode_img
            width: 800
            height: 480
            source: "img/index_bg.png"
            Rectangle{
                x: 497
                y: 212
                width: 150
                height: 150
                color: "#121212";
                //用来等待一个图元，可以缓解用户的焦躁情绪
                BusyIndicator{
                    id:busy;
                    running: true;
                    anchors.centerIn: parent;
                    z:2;
                }

                //一个文本
                Text{
                    id:stateLabel;
                    visible: false;
                    anchors.centerIn: parent;
                    z:3;
                }
                //图片资源，image的status改变的时候，会发出一个StatusChange信号，对应信号处理是On<property>Changed;
                Image{
                    id:imageViewer;
                    x: 1
                    y: 1
                    asynchronous: true;
                    cache: false;
                    width: 150
                    height: 150
                    opacity: 1
                    fillMode: Image.PreserveAspectFit;
                    onStatusChanged: {
                        if(imageViewer.status == Image.Loading){
                            busy.running = true;
                            stateLabel.visible = false;
                        }
                        else if(imageViewer.status == Image.Ready){
                            busy.running = false;
                        }
                        else if(imageViewer.status == Image.Error){
                            busy.running = false;
                            stateLabel.visible = true;
                            stateLabel.text = "ERROR";
                        }
                    }

                }
                Component.onCompleted: {
                    imageViewer.source = palservice.getComponyUrl()+"alipayXServer/getQRCode?intoMethod=2&initDeviceNo=AA20170606";
                }
            }
            Text {
                id: text1
                x: 164
                y: 398
                width: 155
                height: 47
                color: "#f9f8f8"
                text: qsTr("扫手开门")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20
            }

            Text {
                id: text3
                x: 539
                y: 408
                height: 47
                color: "#f5f3f3"
                text: qsTr("扫码开门")
                font.pixelSize: 20
            }


            Rectangle{

                Image {
                    id: image
                    x: 166
                    y: 208
                    width: 150
                    height: 150
                    source: "img/scanhandler.png"

                    MouseArea{
                        anchors.rightMargin: -8
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 8
                        anchors.topMargin: 0
                        anchors.fill : parent
                        onClicked: {
                            console.log("11111");
                            palservice.setPhoneFour(" ")
                            textEdit1.text=" "
                            textEdit4.text=" "
                            textEdit3.text=" "
                            textEdit2.text=" "
                            speaker.receiveDataFromUI("请输入您的手机号后四位")
                            phone.visible=true
                        }
                    }
                }

            }

            Text {
                id: text2
                x: 257
                y: 65
                width: 287
                height: 70
                color: "#f7f6f6"
                text: qsTr("信用购物 拿起就走")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 32
            }

            Text {
                id: text4
                x: 190
                y: 141
                width: 421
                height: 56
                color: "#ffeded"
                text: qsTr("Take go, Checking by credit score")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 23
            }
        }
    }

        //------------------------------------------------3 housiwei page-----------------------------------------------------
  Rectangle{
         id:phone
            width: 800
            height: 480
            visible:false

            MouseArea{
                anchors.fill : parent
                onClicked: stopRobotFunc()



            }

     Image {
            id:phone_img
            width: 800
            height: 480
            source: "img/index_bg.png"
            visible: true;
            Rectangle{
                gradient: Gradient {
                    GradientStop {
                        position: 0
                        color: "#b42c2c"
                    }

                    GradientStop {
                        position: 1
                        color: "#000000"
                    }
                }

       //-------------------------------//123-------------------------------
                Label {
                    id:firstLabel
                    x: 500
                    y: 112
                    width: 100
                    height: 90
                    text: "1"
                    font.bold: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 14
                    color: "white"
                    background:Rectangle
                    {
                        id:first
                        implicitHeight:firstLabel.height
                        implicitWidth:firstLabel.width
                        border.width:1
                        border.color:"#30a2d1"
                        color:"#3bb3e7"
                        MouseArea{
                          anchors.fill: parent
                          onPressed: {
                              first.color="#a8e6ff"
                              console.log("12121")
                          }
                          onExited: {
                              first.color="#39b2e7"
                              console.log("2121")
                          }
                          onClicked: handleClick(1)

                        }
                    }
                }

                Label {
                    x: 600
                    y: 112
                    width: 100
                    height: 90
                    text: "2"
                    font.bold: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 14
                    color: "white"
                    background:Rectangle
                    {
                        id:second
                        implicitHeight:firstLabel.height
                        implicitWidth:firstLabel.width
                        border.width:1
                        border.color:"#30a2d1"
                        color:"#3bb3e7"
                        MouseArea{
                          anchors.fill: parent
                          onPressed: {
                              second.color="#a8e6ff"
                              console.log("12121")
                          }
                          onExited: {
                              second.color="#39b2e7"
                              console.log("2121")
                          }
                          onClicked: handleClick(2)

                        }
                    }
                }

                Label {
                    x: 700
                    y: 112
                    width: 100
                    height: 90
                    text: "3"
                    font.bold: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 14
                    color: "white"
                    background:Rectangle
                    {
                        id:three
                        implicitHeight:firstLabel.height
                        implicitWidth:firstLabel.width
                        border.width:1
                        border.color:"#30a2d1"
                        color:"#3bb3e7"
                        MouseArea{
                          anchors.fill: parent
                          onPressed: {
                              three.color="#a8e6ff"
                              console.log("12121")
                          }
                          onExited: {
                              three.color="#39b2e7"
                              console.log("2121")
                          }
                          onClicked: handleClick(3)

                        }
                    }
                }

//456-------------------------------
                Label {
                    x: 500
                    y: 182
                    width: 100
                    height: 90
                    text: "4"
                    font.bold: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 14
                    color: "white"
                    background:Rectangle
                    {
                        id:four
                        implicitHeight:firstLabel.height
                        implicitWidth:firstLabel.width
                        border.width:1
                        border.color:"#30a2d1"
                        color:"#3bb3e7"
                        MouseArea{
                          anchors.fill: parent
                          onPressed: {
                              four.color="#a8e6ff"
                              console.log("12121")
                          }
                          onExited: {
                              four.color="#39b2e7"
                              console.log("2121")
                          }
                          onClicked: handleClick(4)

                        }
                    }
                }

                Label {
                    x: 600
                    y: 182
                    width: 100
                    height: 90
                    text: "5"
                    font.bold: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 14
                    color: "white"
                    background:Rectangle
                    {
                        id:five
                        implicitHeight:firstLabel.height
                        implicitWidth:firstLabel.width
                        border.width:1
                        border.color:"#30a2d1"
                        color:"#3bb3e7"
                        MouseArea{
                          anchors.fill: parent
                          onPressed: {
                              five.color="#a8e6ff"
                              console.log("12121")
                          }
                          onExited: {
                              five.color="#39b2e7"
                              console.log("2121")
                          }
                          onClicked: handleClick(5)

                        }
                    }
                }

                Label {
                    x: 700
                    y: 182
                    width: 100
                    height: 90
                    text: "6"
                    font.bold: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 14
                    color: "white"
                    background:Rectangle
                    {
                        id:six
                        implicitHeight:firstLabel.height
                        implicitWidth:firstLabel.width
                        border.width:1
                        border.color:"#30a2d1"
                        color:"#3bb3e7"
                        MouseArea{
                          anchors.fill: parent
                          onPressed: {
                              six.color="#a8e6ff"
                              console.log("12121")
                          }
                          onExited: {
                              six.color="#39b2e7"
                              console.log("2121")
                          }
                          onClicked: handleClick(6)

                        }
                    }
                }


//789-------------------------------
                Label {
                    x: 500
                    y: 252
                    width: 100
                    height: 90
                    text: "7"
                    font.bold: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 14
                    color: "white"
                    background:Rectangle
                    {
                        id:seven
                        implicitHeight:firstLabel.height
                        implicitWidth:firstLabel.width
                        border.width:1
                        border.color:"#30a2d1"
                        color:"#3bb3e7"
                        MouseArea{
                          anchors.fill: parent
                          onPressed: {
                              seven.color="#a8e6ff"
                              console.log("12121")
                          }
                          onExited: {
                              seven.color="#39b2e7"
                              console.log("2121")
                          }
                          onClicked: handleClick(7)

                        }
                    }
                }

                Label {
                    x: 600
                    y: 252
                    width: 100
                    height: 90
                    text: "8"
                    font.bold: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 14
                    color: "white"
                    background:Rectangle
                    {
                        id:eight
                        implicitHeight:firstLabel.height
                        implicitWidth:firstLabel.width
                        border.width:1
                        border.color:"#30a2d1"
                        color:"#3bb3e7"
                        MouseArea{
                          anchors.fill: parent
                          onPressed: {
                              eight.color="#a8e6ff"
                              console.log("12121")
                          }
                          onExited: {
                              eight.color="#39b2e7"
                              console.log("2121")
                          }
                          onClicked: handleClick(8)

                        }
                    }
                }

                Label {
                    x: 700
                    y: 252
                    width: 100
                    height: 90
                    text:"9"
                    font.bold: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 14
                    color: "white"
                    background:Rectangle
                    {
                        id:nine
                        implicitHeight:firstLabel.height
                        implicitWidth:firstLabel.width
                        border.width:1
                        border.color:"#30a2d1"
                        color:"#3bb3e7"
                        MouseArea{
                          anchors.fill: parent
                          onPressed: {
                              nine.color="#a8e6ff"
                              console.log("12121")
                          }
                          onExited: {
                              nine.color="#39b2e7"
                              console.log("2121")
                          }
                          onClicked: handleClick(9)

                        }
                    }
                }

  //123-------------------------------
                Label {
                    id:cancleLabel
                    x: 500
                    y: 322
                    width: 100
                    height: 90
                    text: "cancle"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 12
                    color: "white"
                    background:Rectangle
                    {
                        id:cancle
                        border.width:1
                        border.color:"#30a2d1"
                        implicitHeight:firstLabel.height
                        implicitWidth:firstLabel.width

                        color:"#3bb3e7"
                        MouseArea{
                          anchors.fill: parent
                          onPressed: {
                              cancle.color="#a8e6ff"
                              console.log("12121")
                          }
                          onExited: {
                              cancle.color="#39b2e7"
                              console.log("2121")
                          }
                          onClicked: handleClick(10)

                        }
                    }
                }

                Label {
                    x: 600
                    y: 322
                    width: 100
                    height: 90
                    text: "0"
                    font.bold: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 14
                    color: "white"
                    background:Rectangle
                    {
                        id:zero
                        border.width:1
                        border.color:"#30a2d1"
                        implicitHeight:firstLabel.height
                        implicitWidth:firstLabel.width
                        color:"#3bb3e7"
                        MouseArea{
                          anchors.fill: parent
                          onPressed: {
                              zero.color="#a8e6ff"
                              console.log("12121")
                          }
                          onExited: {
                              zero.color="#39b2e7"
                              console.log("2121")
                          }
                          onClicked: handleClick(11)

                        }
                    }
                }

                Label {
                    x: 700
                    y: 322
                    width: 100
                    height: 90
                    text: "x"
                    font.bold: true

                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 14
                    color: "white"
                    background:Rectangle
                    {
                        id:clear
                        border.width:1
                        border.color:"#30a2d1"
                        implicitHeight:firstLabel.height
                        implicitWidth:firstLabel.width
                        color:"#3bb3e7"
                        MouseArea{
                          anchors.fill: parent
                          onPressed: {
                              clear.color="#a8e6ff"
                              console.log("12121")
                          }
                          onExited: {
                              clear.color="#39b2e7"
                              console.log("2121")
                          }
                          onClicked: handleClick(12)

                        }
                        Image {
                            x: 40
                            y: 30
                            source: "img/error.png"
                            width: 20
                            height: 20
                        }
                    }
                }
            }

            Image {
              id: image22
              x: 27
              y: 60
              width: 58
              height: 15
              fillMode: Image.Tile
              source: "img/backmain.png"
              MouseArea{
                  anchors.fill: parent
                  onClicked: {
                      backToIndex()
                      }
              }
            }


//-------------------------------------选择的数字-------------------------

     Rectangle{
            Text {
                id: textEdit1
                x: 64
                y: 101
                width: 50
                height: 30
                text: qsTr("")
                font.underline: false
                font.pixelSize: 26
                fontSizeMode: Text.HorizontalFit
                textFormat: Text.AutoText
                elide: Text.ElideMiddle
                font.weight: Font.ExtraLight
                style: Text.Normal
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.bold: true
                color: "white"

            }
            Text {
                x: 64
                y: 126
                width: textEdit1.width
                height: 5
                text: qsTr("               ")
                horizontalAlignment: Text.AlignHCenter
                color: "white"
                font.underline: true
                }

       }

     Rectangle{
            Text {
                id: textEdit2
                x: 150
                y: 101
                width: 50
                height: 30
                text: qsTr("")
                font.underline: false
                font.pixelSize: 26
                fontSizeMode: Text.HorizontalFit
                textFormat: Text.AutoText
                elide: Text.ElideMiddle
                font.weight: Font.ExtraLight
                style: Text.Normal
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.bold: true
                color: "white"

            }
            Text {
                x: 150
                y: 126
                width: textEdit1.width
                height: 5
                text: qsTr("               ")
                horizontalAlignment: Text.AlignHCenter
                color: "white"
                font.underline: true
                }

       }

     Rectangle{
            Text {
                id: textEdit3
                x: 240
                y: 101
                width: 50
                height: 30
                text: qsTr("")
                font.underline: false
                font.pixelSize: 26
                fontSizeMode: Text.HorizontalFit
                textFormat: Text.AutoText
                elide: Text.ElideMiddle
                font.weight: Font.ExtraLight
                style: Text.Normal
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.bold: true
                color: "white"

            }
            Text {
                x: 240
                y: 126
                width: textEdit1.width
                height: 5
                text: qsTr("               ")
                horizontalAlignment: Text.AlignHCenter
                color: "white"
                font.underline: true
                }

       }

     Rectangle{
            Text {
                id: textEdit4
                x: 330
                y: 101
                width: 50
                height: 30
                text: qsTr("")
                font.underline: false
                font.pixelSize: 26
                fontSizeMode: Text.HorizontalFit
                textFormat: Text.AutoText
                elide: Text.ElideMiddle
                font.weight: Font.ExtraLight
                style: Text.Normal
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.bold: true
                color: "white"

            }
            Text {
                x: 330
                y: 126
                width: textEdit1.width
                height: 5
                text: qsTr("               ")
                horizontalAlignment: Text.AlignHCenter
                color: "white"
                font.underline: true
            }

     }

     Text {
         id: text5
         x: 80
         y: 217
         width: 300
         height: 84
         color: "white"
         font.letterSpacing: 5
         font.wordSpacing: 1
         text: qsTr("请输入\n手机号码后四位 ")
         verticalAlignment: Text.AlignVCenter
         horizontalAlignment: Text.AlignHCenter
         font.bold: true
         font.pixelSize: 25
     }

       Text {
           id: text6
           x: 80
           y: 318
           width: 300
           height: 97
           color: "white"
           font.letterSpacing: 1
           font.wordSpacing: 1
           text: qsTr("Please enter the last four \n of your phone number")
           verticalAlignment: Text.AlignVCenter
           horizontalAlignment: Text.AlignHCenter
           font.pixelSize: 16
       }


        }
  }
       //------------------------------------------------4 huanying tiyansaoshou page-----------------------------------------------------
   Rectangle{
      id:welcome
         width: 800
         height: 480
        visible:false
         MouseArea{
             anchors.fill : parent
             onClicked: stopRobotFunc()
         }
  Image {
      width: 800
      height: 480
      source: "img/index_bg.png"

      Text {
          id: text7
          x: 191
          y: 83
          width: 423
          height: 55
          color: "#ffffff"
          text: qsTr("欢迎 , 新的小伙伴")
          font.pixelSize: 37
          font.letterSpacing: 1
          font.wordSpacing: 4
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
      }

            Text {
                id: text8
                x: 229
                y: 163
                width: 356
                height: 28
                color: "#ffffff"
                text: qsTr("Welcome , my new fellows")
                font.letterSpacing: 0
                font.wordSpacing: 4
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 21
            }

            Label {
                id: openDoorLabel
                x: 242
                y: 248
                width: 343
                height: 60
                color: "#3bb3e7"
                text: qsTr("点击开锁")
                font.bold: false
                font.pointSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                background: Rectangle{
                   color: "white"
                   radius: 40
                   MouseArea{
                     anchors.fill: parent
                     onClicked: {
                         timerpalmService.stop() //stop palm
                         palservice.setChangeValue(4)//close palm
                         getLoginUserStatus(palservice.getCurrentUserID())// opendoor
                     }
                   }
                }
            }

            Label {
                id: goScanLabel
                x: 242
                y: 371
                width: 343
                height: 60
                color: "#3bb3e7"
                text: qsTr("体验刷手开门")
                font.pointSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                background: Rectangle{
                   color: "white"
                   radius: 40
                   MouseArea{
                     anchors.fill: parent
                     onClicked: {
                         getUserFromPalm()
                     }
                   }
                }
            }
            Image {
              id: image3
              x: 27
              y: 60
              width: 58
              height: 15
              fillMode: Image.Tile
              source: "img/backmain.png"
              MouseArea{
                  anchors.fill: parent
                  onClicked:{
                      backToIndex()
                  }
              }
            }
        }
  }
        //------------------------------------------------5 shuashou page-----------------------------------------------------
   Rectangle{
      id:plamreg
         width: 800
         height: 480
         visible:false
         MouseArea{
             anchors.fill : parent
             onClicked: stopRobotFunc()
         }
      Image {
          width: 800
          height: 480
            source: "img/index_bg.png"
            Text {
                id: text9
                x: 192
                y: 31
                width: 423
                height: 55
                color: "#ffffff"
                text: qsTr("请将手放值扫描仪")
                font.pixelSize: 37
                font.letterSpacing: 1
                font.wordSpacing: 4
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
               }

               Text {
                      id: text10
                      x: 230
                      y: 92
                      width: 356
                      height: 28
                      color: "#ffffff"
                      text: qsTr("Please record your hand print")
                      font.letterSpacing: 0
                      font.wordSpacing: 4
                      horizontalAlignment: Text.AlignHCenter
                      verticalAlignment: Text.AlignVCenter
                      font.pixelSize: 21
                  }


            Label {
                id: regOperation
                x: 308
                y: 409
                width: 200
                height: 50
                visible: false
                color: "#3bb3e7"
                text: qsTr("重新采集")
                font.bold: false
                font.pointSize: 16
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                background: Rectangle{
                   color: "white"
                   radius: 40
                   MouseArea{
                     anchors.fill: parent
                     onClicked: {
                         timerGetRegister.start()
                         regCaptureImg.source="img/scan1.png"
                         palservice.setChangeValue(1)
                         timerpalmService.start()
                         console.log("重新采集")
                     }
                   }
                }
            }

            Image {
              id: image4
              x: 27
              y: 60
              width: 58
              height: 15
              fillMode: Image.Tile
              source: "img/backmain.png"
              MouseArea{
                  anchors.fill: parent
                  onClicked: {
                      palservice.setChangeValue(4)
                      backToIndex()
                 }
              }
            }

            Image {
                id: regCaptureImg
                x: 230
                y: 139
                width: 364
                height: 248
                source: "img/scan1.png"
            }
      }

}
  //------------------------------------------------6 shua shou page-----------------------------------------------------

   Rectangle{
      id:choose
         width: 800
         height: 480
         visible:false
         MouseArea{
             anchors.fill : parent
             onClicked: stopRobotFunc()
         }
      Image {
          width: 800
          height: 480
            source: "img/index_bg.png"
            Text {
                id: text11
                x: 195
                y: 202
                width: 423
                height: 55
                color: "#ffffff"
                text: qsTr("已解锁 , 请选购")
                font.pixelSize: 37
                font.letterSpacing: 1
                font.wordSpacing: 4
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
               }

               Text {
                      id: text12
                      x: 229
                      y: 276
                      width: 356
                      height: 28
                      color: "#ffffff"
                      text: qsTr("Unlocked. Please choose what you want")
                      font.letterSpacing: 0
                      font.wordSpacing: 4
                      horizontalAlignment: Text.AlignHCenter
                      verticalAlignment: Text.AlignVCenter
                      font.pixelSize: 21
                  }


            Label {
                id: closeDoor
                x: 257
                y: 351
                width: 286
                height: 70
                visible: true
                color: "#3bb3e7"
                text: qsTr("购物完成,点我关门")
                font.bold: false
                font.pointSize: 16
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                background: Rectangle{
                   color: "white"
                   radius: 40
                   MouseArea{
                     anchors.fill: parent
                     onClicked: {
                         closeDoorFunc()//关门成功之后开始结算
                     }
                   }
                }
            }

            Image {
              id: image5
              x: 27
              y: 60
              width: 58
              height: 15
              fillMode: Image.Tile
              source: "img/backmain.png"
              MouseArea{
                  anchors.fill: parent
                  onClicked: {
                      backToIndex()
                  }
              }
            }

            Image {
                id: image6
                x: 340
                y: 60
                width: 120
                height: 120
                source: "img/success.png"
            }
      }

  }
 //------------------------------------------------7 zhengzai jiesuan------------------------------------------------
   Rectangle{
      id:checkout
         width: 800
         height: 480
         visible:false
         MouseArea{
             anchors.fill : parent
             onClicked: stopRobotFunc()
         }
      Image {
          width: 800
          height: 480
            source: "img/index_bg.png"
            Text {
                id: cartTextC
                x: 197
                y: 293
                width: 423
                height: 55
                color: "#ffffff"
                text: qsTr("正在结算, 请稍等")
                font.pixelSize: 37
                font.letterSpacing: 1
                font.wordSpacing: 4
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
               }

               Text {
                      id: cartTextE
                      x: 222
                      y: 381
                      width: 356
                      height: 28
                      color: "#ffffff"
                      text: qsTr("We are checking out your order, please wait.")
                      font.letterSpacing: 0
                      font.wordSpacing: 4
                      horizontalAlignment: Text.AlignHCenter
                      verticalAlignment: Text.AlignVCenter
                      font.pixelSize: 21
                  }




            Image {
              id: image7
              x: 27
              y: 60
              width: 58
              height: 15
              fillMode: Image.Tile
              source: "img/backmain.png"
              MouseArea{
                  anchors.fill: parent
                  onClicked: {
                      backToIndex()
                  }
              }
            }

            Image {
                id: cartImg
                x: 340
                y: 120
                width: 120
                height: 120
                source: "img/carting.png"
            }


      }

  }
  //------------------------------------------------8 xitongweihuzhong------------------------------------------------
   Rectangle{
      id:systemerror
         width: 800
         height: 480
         visible:false
         MouseArea{
             anchors.fill : parent
             onClicked: stopRobotFunc()
         }
      Image {
          width: 800
          height: 480
            source: "img/index_bg.png"
            Text {
                id: errorTips
                x: 197
                y: 293
                width: 423
                height: 55
                color: "#ffffff"
                text: qsTr("对不起, 系统维护中\n暂停营业")
                font.pixelSize: 37
                font.letterSpacing: 1
                font.wordSpacing: 4
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
               }

               Text {
                      id: errorTipeEng
                      x: 222
                      y: 381
                      width: 356
                      height: 28
                      color: "#ffffff"
                      text: qsTr("sorry, closed for system maintenance.")
                      font.letterSpacing: 0
                      font.wordSpacing: 4
                      horizontalAlignment: Text.AlignHCenter
                      verticalAlignment: Text.AlignVCenter
                      font.pixelSize: 21
                  }

            Image {
              id: image9
              x: 27
              y: 60
              width: 58
              height: 15
              fillMode: Image.Tile
              source: "img/backmain.png"
              MouseArea{
                  anchors.fill: parent
                  onClicked: {
                      backToIndex()
                  }
              }
            }

            Image {
                id: error_img
                x: 340
                y: 120
                width: 120
                height: 120
                source: "img/systemerror.png"
            }


      }

  }
  //------------------------------------------------9 xianyongzhifub saomazhuce shuashou------------------------------------------------

   Rectangle{
    id:plamBefore
       width: 800
       height: 480
       visible:false
       MouseArea{
           anchors.fill : parent
           onClicked: stopRobotFunc()
       }

   Image {
       id: image15
       width: 800
       height: 480
       source: "img/index_bg.png"
       Rectangle{
           x: 315
           y: 215
           width: 160
           height: 160
           color: "#121212";
           //图片资源，image的status改变的时候，会发出一个StatusChange信号，对应信号处理是On<property>Changed;
           Image{
               id:imageViewer2;
               x: 0
               y: 0
               asynchronous: true;
               cache: false;
               width: 160
               height: 160
               opacity: 1

               fillMode: Image.PreserveAspectFit;

               onStatusChanged: {
                   if(imageViewer2.status == Image.Loading){
                       busy.running = true;
                       stateLabel.visible = false;
                   }
                   else if(imageViewer2.status == Image.Ready){
                       busy.running = false;
                   }
                   else if(imageViewer2.status == Image.Error){
                       busy.running = false;
                       stateLabel.visible = true;
                       stateLabel.text = "ERROR";
                   }
               }

           }
           Component.onCompleted: {
               imageViewer2.source = palservice.getComponyUrl()+"alipayXServer/getQRCode?intoMethod=1&initDeviceNo=AA20170606";
           }
       }




       Text {
           id: text21
           x: 257
           y: 65
           width: 287
           height: 70
           color: "#f7f6f6"
           text: qsTr("请先用支付宝扫码")
           verticalAlignment: Text.AlignVCenter
           horizontalAlignment: Text.AlignHCenter
           font.pixelSize: 32
       }

       Text {
           id: text41
           x: 190
           y: 141
           width: 421
           height: 56
           color: "#ffeded"
           text: qsTr("Please scan the QRcode")
           verticalAlignment: Text.AlignVCenter
           horizontalAlignment: Text.AlignHCenter
           font.pixelSize: 23
       }
   }
   Image {
     id: image32
     x: 27
     y: 60
     width: 58
     height: 15
     fillMode: Image.Tile
     source: "img/backmain.png"
     MouseArea{
         anchors.fill: parent
         onClicked:{
             backToIndex()
         }
     }
   }
}
//------------------------------------------------9 刷手开门------------------------------------------------
   Rectangle{
    id:plamOpen
       width: 800
       height: 480
       visible:false
       MouseArea{
           anchors.fill : parent
           onClicked: stopRobotFunc()
       }
    Image {
        width: 800
        height: 480
          source: "img/index_bg.png"
          Text {
              id: text23
              x: 192
              y: 31
              width: 423
              height: 55
              color: "#ffffff"
              text: qsTr("请将手放值扫描仪")
              font.pixelSize: 37
              font.letterSpacing: 1
              font.wordSpacing: 4
              horizontalAlignment: Text.AlignHCenter
              verticalAlignment: Text.AlignVCenter
             }

             Text {
                    id: text22
                    x: 230
                    y: 92
                    width: 356
                    height: 28
                    color: "#ffffff"
                    text: qsTr("Please record your hand print")
                    font.letterSpacing: 0
                    font.wordSpacing: 4
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 21
                }




          Image {
            id: image41
            x: 27
            y: 60
            width: 58
            height: 15
            fillMode: Image.Tile
            source: "img/backmain.png"
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    backToIndex()
                }
            }
          }

          Image {
              id: captureOpen
              x: 230
              y: 139
              width: 364
              height: 248
              source: "img/register.png"
          }
    }

}
}

    Text {
        id: clock
        x:650
        y:10
        width: 150
        height: 30
        color: "white"
        text: qsTr("2018.09.25  14:32")
        Timer{
            interval: 30000;//如果没有成功就再次开启
            repeat: true
            running: true
            triggeredOnStart: true
            onTriggered: {
                if(shoplist.visible)
                     clock.color="#666666";
                else
                     clock.color="white";
                clock.text=speaker.getCurrentTime()
            }
        }
    }

//------------------------------------------------qml  plguins------------------------------------------------

    WorkThread{
      id:workThread
      onWork: {
          workThreadSignal(sendWorkSignal())
          console.log(sendWorkSignal()+"----work----")
      }
    }
    PalService{
      id:palservice
      onPalm: {
          //检测是否在刷手界面
         if(!plamOpen.visible&&!plamreg.visible){
             timerGetRegister.stop()
             timerpalmService.stop()
             palservice.setChangeValue(4)
         }
         //检测是否拿到刷手数据
          console.log(palservice.getPalmData()+"---")
          if(palservice.getPalmData()!=="0"&&palservice.getPalmData().length>15){
              if(plamOpen.visible)
                  workThreadSignal(19) //识别
              if(plamreg.visible)
                  workThreadSignal(9)   //注册

          }
          console.log(palservice.getPalmData ()+"----getPalmData---")
          workThreadSignal(palservice.getPalmStatus())
          console.log(palservice.getPalmStatus()+"----palm---")
      }
    }

    C_UDP{
      id:cudp
      onUdp:{
          console.log(getGLOBAL_UDP_STR())
          workThreadSignal(999)
      }
    }
    VoiceThread{
      id:speaker
      onSpeak:{
          workThreadSignal(1001)
      }
    }


 //------------------------------------------------Connections------------------------------------------------
    function handleClick(i){
        var phoneStr=palservice.getPhoneFour().trim();
        if(i===10){
            backToIndex()
        }else if(i===12){
            if(phoneStr.length>0){
                if(phoneStr.length===1){
                    textEdit1.text="";
                }else if(phoneStr.length===2){
                    textEdit2.text="";
                }else if(phoneStr.length===3){
                    textEdit3.text="";
                }else if(phoneStr.length===4){
                    textEdit4.text="";
                }
              palservice.subPhoneFour();
            }
        }else{
            if(i===11){
               i=0;
            }
            if(phoneStr.length===0){
                textEdit1.text=i;
                phoneStr=phoneStr+i;
                palservice.setPhoneFour(phoneStr);
            }else if(phoneStr.length===1){
                textEdit2.text=i;
                phoneStr=phoneStr+i;
                palservice.setPhoneFour(phoneStr);
            }else if(phoneStr.length===2){
                textEdit3.text=i;
                phoneStr=phoneStr+i;
                palservice.setPhoneFour(phoneStr);
            }else if(phoneStr.length===3){
                textEdit4.text=i;
                phoneStr=phoneStr+i;
                palservice.setPhoneFour(phoneStr);
                setUnVisible();
                palservice.clearPalmData()
                palservice.setChangeValue(3)
                plamOpen.visible=true;
                timerGetUserId.stop();                
                timerpalmService.start();               
            }
        }

    }
//------------------------------------------------js------------------------------------------------
 //************************************************************///************************************************************//
    //注册掌纹接口

    function doPostPlam(venn,phone,userId, opType){

        console.log(palservice.getServelReg() + "--------------");
        AjaxScript.ajax({
            type: "POST",
            url: palservice.getServelReg() + "palm/operation/mobile",
            dataType: "json",
            contentType: "application/json",
            data: JSON.stringify({
                mobile: phone,
                userId: userId,
                vein:venn,
                type:opType
            }),
            beforeSend: function() {
                //some js code
            },
            success: function(msg) {
                //创建文档对象
                if (msg.resultCode === "1") {
                    timerGetRegister.stop()
                    palservice.clearPalmData()
                    console.log("扫手注册成功")
                    palservice.setChangeValue(4)
                    setUnVisible();
                    choose.visible=true;
                }else if (msg.resultCode === "5002") {
                    console.log(JSON.stringify(msg) + "该会员已经注册")
                    timerGetRegister.stop()
                    palservice.clearPalmData()
                    palservice.setChangeValue(4)
                    speaker.receiveDataFromUI("您已注册,请直接刷手")
                    backToIndex()
                } else {
                    timerGetRegister.stop()
                    palservice.clearPalmData()
                    console.log("扫手注册失败")
                    palservice.setChangeValue(4)
                    registerError();
                }

                console.log(JSON.stringify(msg) + "doPostPlam success-**********")
            },
            error: function() {
                systemError()
            }
        });
    }
    function playtts() {
        console.log(palservice.getPalmStatus() + "-----")
        switch (palservice.getPalmStatus()) {
        case 25:
            speaker.receiveDataFromUI("请放上手");
            break;
        case 2:
            speaker.receiveDataFromUI("请正确放置手");
            break;

        case 3:
            speaker.receiveDataFromUI("请将手靠近");
            break;

        case 4:
            speaker.receiveDataFromUI("请抬高手掌");
            break;

        case 7:
            speaker.receiveDataFromUI("请移开手,稍后再放回");
            break;

        case 1:
            speaker.receiveDataFromUI("请保持");
            break;

        case 26:
            speaker.receiveDataFromUI("手掌放平");
            break;

        case 22:

            speaker.receiveDataFromUI("请张开手指");
            break;

        case 18:
            speaker.receiveDataFromUI("向前移动");
            break;

        case 19:
            speaker.receiveDataFromUI("向后移动");
            break;

        case 16:
            speaker.receiveDataFromUI("向左移动");
            break;

        case 17:
            speaker.receiveDataFromUI("向右移动");
            break;
        case 10:
            speaker.receiveDataFromUI("重新开始采集");
            break;

        case 24:
            speaker.receiveDataFromUI("重新采集,请不要移动您的手");
            break;

        }
    }
    function setUnVisible(){
        shoplist.visible=false;
        index.visible=false;
        phone.visible=false;
        welcome.visible=false;
        plamreg.visible=false;
        choose.visible=false;
        checkout.visible=false;
        systemerror.visible=false;
        plamBefore.visible=false;
        plamOpen.visible=false;
    }

    function doPostPlamReg(venn,phone){
        console.log(palservice.getServelReg() + "--------------"+venn+"---"+phone);
        AjaxScript.ajax({
            type: "POST",
            url: palservice.getServelReg() + "palm/identify",
            dataType: "json",
            contentType: "application/json",
            data: JSON.stringify({
                capture: venn,
                phoneSuffix: phone
            }),
            beforeSend: function() {
                //some js code
            },
            success: function(msg) {
                palservice.clearPalmData();
                console.log(JSON.stringify(msg) + "doPostPlamReg----**********")
                if(msg.resultCode!=="1"){
                    console.log("renzheng failed---211-**********")
                    timerpalmService.stop()
                    palservice.setChangeValue(4)
                    speaker.receiveDataFromUI("识别失败,请稍候重试")
                    authFaile();
                    return;
                }
                console.log(JSON.stringify(msg) + "----**********")
                palservice.setCurrentUserID(msg.data.palmRes.userId)
                if (palservice.getCurrentUserID() !== "0") {
                    getLoginUserStatus(palservice.getCurrentUserID())
                    console.log("开始-**********")
                }else{
                    authFaile();
                }
            },
            error: function() {
                systemError()
            }
        });
    }


    function getUserFromPalm(){
        console.log(palservice.getCurrentUserID())
        AjaxScript.ajax({
            type: "GET",
            url: palservice.getServelReg()+ "person/valid?userId="+palservice.getCurrentUserID(),
            dataType: "json",
            contentType: "application/json",
            data:'',
            beforeSend: function() {
                //some js code
            },
            success: function(msg) {
                console.log("palm status")
                if(msg.resultCode==="1"){
                    speaker.receiveDataFromUI("您已注册,可直接刷手开门")
                    backToIndex()
                }else{
                   removePalmVienPageShow();
                }

            },
            error: function() {
                console.log("palm systemError")
                systemError()
            }
        });
    }


    function openDoorFunc() {
        console.log("start" + "OpenDoor-**********")
        AjaxScript.ajax({
            type: "GET",
            url: palservice.getLocalServer() + "/OpenDoor",
            dataType: "json",
            contentType: "application/json",
            data: '',
            beforeSend: function() {
                //some js code
            },
            success: function(msg) {
                if (msg.code === 10001) {
                    setUnVisible();
                    choose.visible=true;
                    speaker.receiveDataFromUI("开门成功,拿好物品后请关门")
                    speaker.setInStoreTime()
                } else {
                    speaker.receiveDataFromUI("开门失败")
                    console.log(JSON.stringify(msg) + "OpenDoor failed-**********")
                }
            },
            error: function() {
                console.log("error" + "OpenDoor failed-**********")
            }
        });

    }

    //registerError
    function registerError(){
        setUnVisible();
        systemerror.visible=true;
        errorTipeEng.text="Sorry, registration failed";
        errorTips.text="对不起,注册失败 ";
        error_img.source="img/failed.png";
        timerCommon.start()
        timerpalmService.stop()
        timerGetRegister.stop()
    }
    //authFaile
    function authFaile(){
        timerGetRegister.stop()
        timerpalmService.stop()
        palservice.clearPalmData()
        setUnVisible();
        systemerror.visible=true;
        errorTipeEng.text="Sorry, authentication failed ";
        errorTips.text="对不起,识别失败 ";
        error_img.source="img/failed.png";
        timerCommon.start()
    }
    //systemError
    function systemError(){
        timerRobot.start()
        timerGetRegister.stop()
        timerGetUserId.stop()
        timerpalmService.stop()
        palservice.clearPalmData()
        setUnVisible();
        systemerror.visible=true;
        errorTips.text="对不起,系统维护中\n暂停营业";
        errorTipeEng.text="Sorry, closed for system maintenance";
        error_img.source="img/systemerror.png";
    }

    function closeDoorFunc() {
        AjaxScript.ajax({
            type: "GET",
            url: palservice.getLocalServer() + "CloseDoor",
            dataType: "json",
            contentType: "application/json",
            data: '',
            beforeSend: function() {
                //some js code
            },
            success: function(msg) {
                //close successfull
                if (msg.code === 10002) {
                    console.log(JSON.stringify(msg) + "closeDoorFunc success-**********")
//                    speaker.setOffStoreTime()
                    startInventory(); //开始盘点
                } else {

                }
                console.log(msg + "closeDoorFunc success-**********")
            },
            error: function() {
                console.log("error" + "closeDoorFunc failed-**********")
            }
        });

    }

    function startInventory() {
        console.log("   start startInventory")
        AjaxScript.ajax({
            type: "POST",
            url: palservice.getLocalServer() + "StartInventory",
            dataType: "json",
            contentType: "application/json",
            data: '',
            beforeSend: function() {
                //some js code
            },
            success: function(msg) {
                console.log(JSON.stringify(msg) + "   start success")
                if (msg.code === 10000) {
                    console.log(JSON.stringify(msg) + "处理盘点数据 success-**********")
                    getShopCart(msg); //处理盘点数据
                }
                console.log(msg + "OpenDoor success-**********")
            },
            error: function() {
                console.log("error" + "OpenDoor failed-**********")
            }
        });

    }
    function backToIndex(){
        palservice.clearPalmData()
        timerpalmService.stop()
        timerGetRegister.stop()
        timerRobot.start()
        timerGetUserId.start()
        setUnVisible()
        index.visible=true
    }

    function startRobotFunc() {
        AjaxScript.ajax({
            type: "GET",
            url: palservice.getLocalServer() + "/StartRobot",
            dataType: "json",
            contentType: "application/json",
            data: '',
            beforeSend: function() {
                //some js code
            },
            success: function(msg) {
                if(msg.code===10004){
                   console.log(JSON.stringify(msg) + "start success-**********")
                }else{
                   console.log(JSON.stringify(msg) + "start failed-**********")
                }
            },
            error: function() {
                console.log("error" + "OpenDoor failed-**********")
            }
        });

    }

    function stopRobotFunc() {
        console.log("11111 success-**********")
        AjaxScript.ajax({
            type: "GET",
            url: palservice.getLocalServer() + "/StopRobot",
            dataType: "json",
            contentType: "application/json",
            data: '',
            beforeSend: function() {
                //some js code
            },
            success: function(msg) {
                if(msg.code===10003){
                    timerRobot.start()
                   console.log(JSON.stringify(msg) + "stop success-**********")
                }else{
                   console.log(JSON.stringify(msg) + "stop failed-**********")
                }

            },
            error: function() {
                console.log("error" + "OpenDoor failed-**********")
            }
        });

    }

    function submitOrder(token,productList) {
//        [{"product_barcode": "6926800401516","num": "1"}]
        var codeArr=new Array(1);
//        for(var i=0;i<productList.list.length;i++){
//            console.log(productList.list[0].name)
//            var ob={product_barcode:msg.list[i].barcode,num:msg.list[i].num};
            var ob={product_barcode:"6926800401516",num:1};
            codeArr[0]=ob;
//        }
        console.log(codeArr+"---------")
        var timestamp = Date.parse(new Date());
        var params={
            "IntoStore":speaker.getInStoreTime(),  //  "2018/05/22 18:20:13"
            "OffStore":speaker.getOffStoreTime(),
            "token":token,
            "InitDeviceNo":palservice.getRobotName(),
            "AliPayUserID": palservice.getCurrentUserID(),
            "BarcodeList": codeArr
        };
        //AliPayUserID: palservice.getCurrentUserID(),
        console.log(JSON.stringify(params)+"---------")
        AjaxScript.ajax({
            type: "POST",
            url: palservice.getComponyUrl() + "order/createOrder",
            dataType: "json",
            contentType: "application/json",
            data: JSON.stringify(params),
            beforeSend: function() {
                //some js code
            },
            success: function(msg) {                
                if(msg.resultCode==="1"){
                    cartTextC.text="结算成功";
                    cartTextE.text="Checking out is finished";
                    cartImg.source="img/cartdone.png";
                    console.log(JSON.stringify(msg) + "insertAll success-**********")
//                    speaker.receiveDataFromUI("结算成功")
                    timerTipsCheck.start()
                }else{
                    console.log(JSON.stringify(msg) + "insertAll failed-**********")
                    cartTextC.text="结算失败";
                    cartTextE.text="we failed to check out your order";
                    cartImg.source="img/takefailed.png";
                    console.log(JSON.stringify(msg) + "insertAll success-**********")
                    timerTipsCheck.start()
//                    speaker.receiveDataFromUI("结算失败,稍候重试");
                }
            },
            error: function() {
                console.log(palservice.getComponyUrl() + "insertAll failed-**********")
            }
        });

    }
    //------
    function getLoginUserStatus(userId) {
        AjaxScript.ajax({
            type: "POST",
            url: palservice.getComponyUrl() + "memberInfo/loginMemberStatus",
            dataType: "json",
            contentType: "application/json",
            data: JSON.stringify({
                alipayUserID: userId,
            }),
            beforeSend: function() {
                //some js code
            },
            success: function(msg) {
                console.log(JSON.stringify(msg) + "loginMenberStatus success-**********")
                if (msg.zMStatus === "0"&&msg.memberResult === "0") {
                    openDoorFunc()
                }else if (msg.zMStatus === "1") {
                    speaker.receiveDataFromUI("您的信用分还需累积,请继续努力")
                    timerCommon.start()
                }else if (msg.zMStatus === "2") {
                    speaker.receiveDataFromUI("对不起,您的帐号异常")
                    timerCommon.start()
                }else if (msg.memberResult === "1") {
                    speaker.receiveDataFromUI("您有未付款订单,请在支付宝生活号里完成支付")
                    timerCommon.start()
                }else if (msg.memberResult === "2") {
                    speaker.receiveDataFromUI("您当前处于解约状态,不能购物")
                    timerCommon.start()
                }
            },
            error: function() {
                systemError()
            }
        });

    }

    //---------------
    function getShoppingToken(productList) {
        AjaxScript.ajax({
            type: "POST",
            url: palservice.getComponyUrl() + "common/getShoppingToken",
            dataType: "json",
            contentType: "application/json",
            data: JSON.stringify({
                initDeviceNo: "AA20170606",
            }),
            beforeSend: function() {
                //some js code
            },
            success: function(msg) {
                if (msg.resultCode === "1") {                    
                    submitOrder(msg.data,productList)
                    console.log(JSON.stringify(msg) + "getCurrentUserFunc success-**********")
                }
            },
            error: function() {
                systemError()
                console.log(palservice.getComponyUrl() + "getCurrentUserFunc failed-**********")
            }
        });

    }

    function getCurrentUserFunc(status) {
        console.log(palservice.getPalmCount() + "--------------");
        AjaxScript.ajax({
            type: "POST",
            url: palservice.getComponyUrl() + "posXServer/getPalmVienPageShow",
            dataType: "json",
            contentType: "application/json",
            data: JSON.stringify({
                initDeviceNo: "AA20170606",
                status: status
            }),
            beforeSend: function() {
                //some js code
            },
            success: function(msg) {
                if (msg.resultCode === "1") {
                    palservice.setPhone(msg.data.mobile)
                    //扫手注册掌页面or scan qrcode
                    if(status === 1) {
                        timerGetUserId.stop();
                        palservice.setCurrentUserID(msg.data.alipayUserID);
                        setUnVisible();
                        welcome.visible=true;

                    } else {
                        //进入注册页面
                        palservice.setChangeValue(1)
                        timerpalmService.start()
                        setUnVisible();
                        plamreg.visible=true;
                        console.log(msg.data.alipayUserID + " success-**********" + status)
                    }
                    console.log(msg.data.alipayUserID + "getCurrentUserFunc success-**********")
                }else if(msg.message!=="") {
                    systemError()
                    speaker.receiveDataFromUI("对不起, 系统维护中,暂停营业")
                }
                console.log(JSON.stringify(msg) + "getCurrentUserFunc success-**********")
            },
            error: function() {
                systemError()
                console.log(palservice.getComponyUrl() + "getCurrentUserFunc failed-**********")
            }
        });

    }

    function removePalmVienPageShow() {
        AjaxScript.ajax({
            type: "POST",
            url: palservice.getComponyUrl() + "posXServer/removePalmVienPageShow",
            dataType: "json",
            contentType: "application/json",
            data: JSON.stringify({
                initDeviceNo: "AA20170606",
            }),
            beforeSend: function() {
                //some js code
            },
            success: function(msg) {
                if (msg.resultCode === "1") {
                    timerGetRegister.start()
                    setUnVisible();
                    plamBefore.visible=true;
                    //                                    setPalmVienPageShow();
                }
                console.log(JSON.stringify(msg) + "removePalmVienPageShow success-**********")
            },
            error: function() {
                console.log(palservice.getComponyUrl() + "setPalmVienPageShow failed-**********")
            }
        });

    }

    //获取customer shopping 物品

    function getShopCart(msg) {
        setUnVisible();
        shoplist.visible=true;
        lm.clear();
        for(var i=0;i<msg.list.length;i++){
            console.log(msg.list[i].name)
            lm.append({
                name: msg.list[i].name,
                price: "￥"+msg.list[i].price,
                weight: msg.list[i].weight+"g"
            });
        }
        getShoppingToken(msg)//拿到数据之后进行购物清算
    }

  }
