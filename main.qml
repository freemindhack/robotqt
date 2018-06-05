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
                     swipeView.currentIndex=2;
//                  console.log("has data by scan")
                  break;
              case 1:
//                  if(swipeView.currentIndex!=2)
//                     swipeView.currentIndex=2;
//                  console.log("please keep hold")
                  break;
              case 9:                  
                  console.log("扫手注册成功"+parameter)
                  timerpalmService.stop();
                  timerGetRegister.stop();
                  doPostPlam("17317396108","Glo",1);//调用
                  palservice.setChangeValue(5);
                  palservice.setChangeValue(4);
                  break;
              case 19:
                  console.log("扫手成功并开门"+parameter)
                  timerpalmService.stop();
                  doPostPlamReg("17317396108","222");//调用
                  palservice.terminate();//
                  break;
              case 999:
                  console.log("处理UDP"+parameter)
                  break;
              case 1001:
                  console.log("处理voice"+parameter)
                  break;
            }

     }


    SwipeView {
        id: swipeView
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        smooth: false
        focusPolicy: Qt.NoFocus
        enabled: true
        font.family: "Times New Roman"
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        currentIndex: 0
        //获取useridtimer
        Timer {
            id: timerGetUserId
            interval: 2000;//如果没有成功就再次开启
            repeat: true
            running: false
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
            interval: 1000;//如果没有成功就再次开启
            repeat: true
            running: false
            triggeredOnStart: true
            onTriggered: {
                 palservice.onPalm()
            }
        }

       //------------------------------------------------1 page-----------------------------------------------------
  Rectangle{
            id:page1
               width: 800
               height: 480

               MouseArea{
                   anchors.fill : parent
                   onClicked: stopRobotFunc()
                   onPositionChanged: swipeView.enabled=false
                   onReleased: swipeView.enabled=true
//                   onPressed: swipeView.wheelEnabled=fa
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
                  ListElement{name:"the flavor of the flower";price:"12";weight:"2.0"}
                  ListElement{name:"the flavor of the flower";price:"12";weight:"2.0"}
                  ListElement{name:"the flavor of the flower";price:"12";weight:"2.0"}
                  ListElement{name:"the flavor of the flower";price:"12";weight:"2.0"}
                  ListElement{name:"the flavor of the flower";price:"12";weight:"2.0"}
                  ListElement{name:"the flavor of the flower";price:"12";weight:"2.0"}
                  ListElement{name:"the flavor of the flower";price:"12";weight:"2.0"}
                  ListElement{name:"the flavor of the flower";price:"12";weight:"2.0"}

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
                      if(1){
                         getShopCart(1);
                      }
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
                         text: "¥ "+price
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
                 onClicked: swipeView.currentIndex=1
             }
           }
      }
}

       //------------------------------------------------2 page-----------------------------------------------------
  Rectangle{
         id:page2
            width: 800
            height: 480

            MouseArea{
                anchors.fill : parent
                onClicked: stopRobotFunc()
            }

        Image {
            id: image1
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
                    imageViewer.source = "https://api.quixmart.com/quixmart-api/alipayXServer/getQRCode?intoMethod=2&initDeviceNo=Robot20170923";
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
                            speaker.receiveDataFromUI("你好你好好好好好")
//                            startInventory()
//                            swipeView.currentIndex=2;
//                            palservice.playerTTS("1111111111111111111111111111111111111111")

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

        //------------------------------------------------3 page-----------------------------------------------------
  Rectangle{
         id:page3
            width: 800
            height: 480


            MouseArea{
                anchors.fill : parent
                onClicked: stopRobotFunc()
                onPositionChanged: {
                    console.log("onPositionChanged")
//                  swipeView.enabled=false
                }
                onReleased: {

                     console.log("onReleased")
//                  swipeView.enabled=true
                }

                onExited:{
                    swipeView.enabled=true
                     console.log("onExited")
//                  swipeView.enabled=true
                }
                onCanceled:{
                    console.log("onCanceled")
//                    swipeView.currentIndex=2;
//                    swipeView.enabled=true
                }
                onPressAndHoldIntervalChanged: {
                  console.log("onPressAndHoldIntervalChanged")
                }
                onScrollGestureEnabledChanged: {
                 console.log("onDragChanged")
                }



            }

     Image {
            width: 800
            height: 480
            source: "img/index_bg.png"

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
                  onClicked: swipeView.currentIndex=1
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

            //            Rectangle{
            //              Image {
//                id:scanRegImg
//                source: "img/register.png"
//                x:250
//                y:150
//                width:300
//                height: 156
//                visible: true
//                MouseArea{
//                    anchors.fill : parent
//                    onClicked: stopRobotFunc()
//                }
//              }
//            }
//            Button {
//                id: regcapturebtn
//                text:"重新采集"
////                 : "img/regcapturebtn.png"
//                x:250
//                y:400
//                onClicked: palservice.setChangeValue(1)
//            }
        }
  }
       //------------------------------------------------4 page-----------------------------------------------------
  Rectangle{
      id:page4
         width: 800
         height: 480

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
                         palservice.setChangeValue(4)
                         swipeView.currentIndex=5
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
                         removePalmVienPageShow();
//                         swipeView.currentIndex=8
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
                  onClicked: swipeView.currentIndex=1
              }
            }
        }
  }
        //------------------------------------------------5 page-----------------------------------------------------
  Rectangle{
      id:page5
         width: 800
         height: 480

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
                  onClicked: swipeView.currentIndex=1
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
  //------------------------------------------------6 page-----------------------------------------------------
  Rectangle{
      id:page6
         width: 800
         height: 480

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
                  onClicked: swipeView.currentIndex=1
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
 //------------------------------------------------7------------------------------------------------
  Rectangle{
      id:page7
         width: 800
         height: 480

         MouseArea{
             anchors.fill : parent
             onClicked: stopRobotFunc()
         }
      Image {
          width: 800
          height: 480
            source: "img/index_bg.png"
            Text {
                id: text13
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
                      id: text14
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
                  onClicked: swipeView.currentIndex=1
              }
            }

            Image {
                id: image8
                x: 340
                y: 120
                width: 120
                height: 120
                source: "img/carting.png"
            }


      }

  }
  //------------------------------------------------8------------------------------------------------
  Rectangle{
      id:page8
         width: 800
         height: 480

         MouseArea{
             anchors.fill : parent
             onClicked: stopRobotFunc()
         }
      Image {
          width: 800
          height: 480
            source: "img/index_bg.png"
            Text {
                id: text15
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
                      id: text16
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
                  onClicked: swipeView.currentIndex=1
              }
            }

            Image {
                id: image10
                x: 340
                y: 120
                width: 120
                height: 120
                source: "img/systemerror.png"
            }


      }

  }
  //------------------------------------------------9------------------------------------------------

Rectangle{
    id:page9
       width: 800
       height: 480

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
               imageViewer2.source = "https://api.quixmart.com/quixmart-api/alipayXServer/getQRCode?intoMethod=1&initDeviceNo=Robot20170923";
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
                if(swipeView.currentIndex===0)
                     clock.color="#666666";
                else
                     clock.color="white";
                clock.text=speaker.getCurrentTime()
            }
        }
    }

//------------------------------------------------qml------------------------------------------------

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
          workThreadSignal(getPalmStatus())
          console.log(getPalmStatus()+"----palm---")
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
           swipeView.currentIndex=1;
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
                swipeView.currentIndex=3;
            }
        }


    }




//------------------------------------------------js------------------------------------------------
 //************************************************************///************************************************************//
  function doPostPlam(userId,vein,opType){
      var venn=palservice.getPalmData();
      if(!venn){
         console.log("请先获取掌脉数据")
        return;
      }
      var dataStr="<?xml version='1.0' encoding='UTF-8' ?>"+"<Application> <PalmReq>  <userId>"+userId+"</userId>  <vein>"+venn+"</vein>  <type>"+opType+"</type> </PalmReq></Application>";

      console.log(dataStr);
      AjaxScript.ajax({   type:"POST",
                          url:palservice.getServelInit(),
                          dataType:"text",
                          contentType: "text/xml",
                          data:dataStr,
                          beforeSend:function(){
                            //some js code
                          },
                          success:function(msg){
                              //创建文档对象
                              if(msg==="PALMYUN2001"){
                                  console.log(msg+"该会员已经注册")
                                  palservice.setChangeValue(4)
                                  swipeView.currentIndex=1
                              }
                              if(msg.indexOf("transCode")!==-1){
                                   var transcode=palservice.getXMLByNodeName(msg,"transCode","PalmRes");
                                   if(transcode==="C1001"){
                                       console.log("扫手注册成功")
                                       palservice.setChangeValue(4)
                                       swipeView.currentIndex=5
                                    }else{
                                       console.log("扫手注册失败")
                                       palservice.setChangeValue(4)
                                       regOperation.visible=true
                                    }
                                 }

                              console.log(msg+"111-**********")
                          },
                          error:function(){
                            console.log("error"+"222-**********")
                          }
                        });
  }


  function doPostPlamReg(userId,palmSet){
      var venn=palservice.getPalmData();
      if(!venn){
         console.log("请先获取掌脉数据")
        return;
      }
      var dataStr="<?xml version='1.0' encoding='UTF-8' ?>"+"<Application> <PalmReq>  <userId>"+userId+"</userId>  <capture>"+venn+"</capture><palmsetName>test</palmsetName></PalmReq></Application>";

      console.log("doPostPlamReg"+dataStr);
      AjaxScript.ajax({   type:"POST",
                          url:palservice.getServelReg(),
                          dataType:"text",
                          contentType: "text/xml",
                          data:dataStr,
                          beforeSend:function(){
                            //some js code
                          },
                          success:function(msg){
                              palservice.clearPalmData();
                              console.log(msg+"1211-**********")
                              palservice.setCurrentUserID(palservice.getXMLByNodeName(msg,"userId","PalmRes"))
                              if(palservice.getCurrentUserID()!=="0"){
                                  openDoorFunc()
                                  console.log("开始-**********")
                              }
                          },
                          error:function(){
                              console.log("error"+"222-**********")
                          }
                        });
  }

  function openDoorFunc(){
      console.log("start"+"OpenDoor-**********")
      AjaxScript.ajax({   type:"GET",
                          url:palservice.getLocalServer()+"/OpenDoor",
                          dataType:"json",
                          contentType: "application/json",
                          data:'',
                          beforeSend:function(){
                            //some js code
                          },
                          success:function(msg){
                              swipeView.currentIndex=5
                              console.log((msg).toString()+"OpenDoor success-**********")
                          },
                          error:function(){
                            console.log("error"+"OpenDoor failed-**********")
                          }
                        });

  }

  function closeDoorFunc(){
      AjaxScript.ajax({   type:"GET",
                          url: palservice.getLocalServer()+"CloseDoor",
                          dataType:"json",
                          contentType: "application/json",
                          data:'',
                          beforeSend:function(){
                            //some js code
                          },
                          success:function(msg){
                               if(msg.code==="10002"){
                                  startInventory();//开始盘点
                               }
                               console.log(msg+"OpenDoor success-**********")
                          },
                          error:function(){
                            console.log("error"+"OpenDoor failed-**********")
                          }
                        });

  }

  function startInventory(){
      AjaxScript.ajax({   type:"POST",
                          url: palservice.getLocalServer()+"StartInventory",
                          dataType:"json",
                          contentType: "application/json",
                          data:'',
                          beforeSend:function(){
                            //some js code
                          },
                          success:function(msg){
                              console.log(JSON.stringify(msg)+"   start success")
                               if(msg.code==="10000"){
                                   getShopCart(msg);//处理盘点数据

                               }
                               console.log(msg+"OpenDoor success-**********")
                          },
                          error:function(){
                            console.log("error"+"OpenDoor failed-**********")
                          }
                        });

  }


  function startRobotFunc(){
      AjaxScript.ajax({   type:"GET",
                          url:palservice.getLocalServer()+"/StartRobot",
                          dataType:"json",
                          contentType: "application/json",
                          data:'',
                          beforeSend:function(){
                            //some js code
                          },
                          success:function(msg){
                            console.log(msg+"OpenDoor success-**********")
                          },
                          error:function(){
                            console.log("error"+"OpenDoor failed-**********")
                          }
                        });

  }

  function stopRobotFunc(){
      console.log("11111 success-**********")
      AjaxScript.ajax({   type:"GET",
                          url:palservice.getLocalServer()+"/StopRobot",
                          dataType:"json",
                          contentType: "application/json",
                          data:'',
                          beforeSend:function(){
                            //some js code
                          },
                          success:function(msg){
                            console.log(msg+"OpenDoor success-**********")
                          },
                          error:function(){
                            console.log("error"+"OpenDoor failed-**********")
                          }
         });

  }

  function submitOrder(){
      var productList=[{product_barcode:"11111",num:12},{product_barcode:"2222",num:12}];
      AjaxScript.ajax({   type:"POST",
                          url:palservice.getComponyUrl()+"order/v2/insertAll",
                          dataType:"json",
                          contentType: "application/json",
                          data:JSON.stringify({
                            InitDeviceNo:"Robot20170923",
                            AliPayUserID:palservice.getCurrentUserID(),
                            BarcodeList:productList
                          }),
                          beforeSend:function(){
                            //some js code
                          },
                          success:function(msg){
                              console.log(JSON.stringify(msg)+"insertAll success-**********")
                          },
                          error:function(){
                            console.log(palservice.getComponyUrl()+"insertAll failed-**********")
                       }
         });

  }

  function getCurrentUserFunc(status){
      console.log(palservice.getPalmCount()+"--------------");
      AjaxScript.ajax({   type:"POST",
                          url:palservice.getComponyUrl()+"posXServer/getPalmVienPageShow",
                          dataType:"json",
                          contentType: "application/json",
                          data:JSON.stringify({
                              initDeviceNo:"Robot20170923",
                              status:status
                          }),
                          beforeSend:function(){
                            //some js code
                          },
                          success:function(msg){
                              if(msg.resultCode==="1"){                                  
                                  //扫手注册掌页面
                                  if(status===1){
                                      timerGetUserId.stop();
                                      palservice.setCurrentUserID(msg.data.alipayUserID);
                                      openDoorFunc();
                                  }else{
                                     //进入注册页面
                                      palservice.setChangeValue(1)
                                      timerpalmService.start()
                                      swipeView.currentIndex=4
                                      console.log(msg.data.alipayUserID+" success-**********"+status)
                                  }
                                  console.log(msg.data.alipayUserID+"getCurrentUserFunc success-**********")
                              }
                              console.log(JSON.stringify(msg)+"getCurrentUserFunc success-**********")
                          },
                          error:function(){
                            console.log(palservice.getComponyUrl()+"getCurrentUserFunc failed-**********")
                          }
         });

  }


  function removePalmVienPageShow(){
      AjaxScript.ajax({   type:"POST",
                          url:palservice.getComponyUrl()+"posXServer/removePalmVienPageShow",
                          dataType:"json",
                          contentType: "application/json",
                          data:JSON.stringify({
                              initDeviceNo:"Robot20170923",
                          }),
                          beforeSend:function(){
                            //some js code
                          },
                          success:function(msg){
                              if(msg.resultCode==="1"){
                                  timerGetRegister.start()                                  
                                  swipeView.currentIndex=8
//                                    setPalmVienPageShow();
                              }
                              console.log(JSON.stringify(msg)+"removePalmVienPageShow success-**********")
                          },
                          error:function(){
                            console.log(palservice.getComponyUrl()+"setPalmVienPageShow failed-**********")
                          }
         });

  }

  //获取customer shopping 物品
  function getShopCart( msg){

      swipeView.currentIndex=0;//处理成功展示
//      if(msg.code==="10000"){
//          console.log("10000")
//      }

      if(lv.contentY>0&&lv.contentHeight-lv.contentY<lv.contentHeight*(9/10))
       {
          indicator.running=true
          timer.start()
          console.log("上拉加载")
           var rd=Math.random()
          lm.clear();
          lm.append({name:"the flavor of the flower",price:"12",weight:"2.0"});
          lm.append({name:"the flavor of the flower",price:"12",weight:"2.0"});
          lm.append({name:"the flavor of the flower",price:"12",weight:"2.0"});
          lm.append({name:"the flavor of the flower",price:"12",weight:"2.0"});
          lm.append({name:"the flavor of the flower",price:"12",weight:"2.0"});
      }
      //如果 contentY<0表示 下拉
      if(lv.contentY<0)
      {
          indicator.running=true
          timer.start()
          console.log("下拉刷新")
      }
  }

}
