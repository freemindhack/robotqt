import QtQuick 2.9
import QtQuick.Controls 2.2
import blue.deep.work 1.0
import blue.deep.palm 1.0

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    color: "#ff00ff00";
    title: qsTr("SwipeView")
    signal workThreadSignal(int message)
    onWorkThreadSignal: workFunction(message)
    function workFunction(parameter) {
            switch(parameter){
              case 100:
                  console.log("no data by scan")
                  break;
              case 101:
                  if(swipeView.currentIndex!=3)
//                     swipeView.currentIndex=3;
                  console.log("has data by scan")
                  break;
              case 1:
                  if(swipeView.currentIndex!=2)
//                     swipeView.currentIndex=2;
                  console.log("please keep hold")
                  break;
            }

     }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: 1
       //first page-----------------------------------------------------
        Image {
            source: "img/index_bg.png"
            BusyIndicator{
               id:indicator
               running: false
               z:2
               anchors.centerIn: parent
            }
            Timer{
                id:timer
                interval: 1000
                running: false
                onTriggered: indicator.running=false
            }
            ListModel{
                id:lm
                ListElement{name:"xx";age:"12"}
                ListElement{name:"xx";age:"12"}
                ListElement{name:"xx";age:"12"}
                ListElement{name:"xx";age:"12"}
                ListElement{name:"xx";age:"12"}
                ListElement{name:"xx";age:"12"}
                ListElement{name:"xx";age:"12"}
                ListElement{name:"xx";age:"12"}
                ListElement{name:"xx";age:"12"}
                ListElement{name:"xx";age:"12"}
                ListElement{name:"xx";age:"12"}
                ListElement{name:"xx";age:"12"}
                ListElement{name:"xx";age:"12"}
                ListElement{name:"xx";age:"12"}
                ListElement{name:"xx";age:"12"}
                ListElement{name:"xx";age:"12"}
            }

            ListView{
                id:lv
                 width:parent.width
                 height:parent.width
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
                     if(contentY>0&&contentHeight-contentY<contentHeight*(9/10))
                      {
                         indicator.running=true
                         timer.start()
                         console.log("上拉加载")
                         var rd=Math.random()
                         lm.append({name:"hanhan"+rd,age:"20"});
                          lm.append({name:"hanhan"+rd,age:"20"});
                          lm.append({name:"hanhan"+rd,age:"20"});
                          lm.append({name:"hanhan"+rd,age:"20"});
                          lm.append({name:"hanhan"+rd,age:"20"});
                     }
                     //如果 contentY<0表示 下拉
                     if(contentY<0)
                     {
                         indicator.running=true
                         timer.start()
                         console.log("下拉刷新")
                     }
                }

                delegate:Rectangle {
                    width:parent.width
                    height:50
                    color:ListView.isCurrentItem?"red":"white"
                    Label{
                        text:name
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
       //2 page-----------------------------------------------------
        Image {
            source: "img/index_bg.png"
            Rectangle{
                x: 291
                y: 94
                width: 200;
                height: 200;
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
                    x: 0
                    y: 0
                    asynchronous: true;
                    cache: false;
                    width: 200;
                    height: 200;
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

            Button {
                id: borderImage
                x: 265
                y: 368
                width: 270
                height: 75
                text:"请刷手"
                font.pointSize: 14
                onClicked:palservice.setChangeValue(1)
            }

        }

        //3 page-----------------------------------------------------
        Image {
            source: "img/index_bg.png"
            Timer {
                id: timerGetUserId
                interval: 3000;
                repeat: true
                running: true
                triggeredOnStart: true
                onTriggered: {
                      workThread.onWork()
                      palservice.onPalm()
                      }
                 }
            Label {
                text: qsTr("Second page2")
                anchors.centerIn: parent
            }
        }
       //4 page-----------------------------------------------------
        Image {
            source: "img/index_bg.png"
            Label {
                text: qsTr("Second page3")
                anchors.centerIn: parent
            }
        }
        //5 page-----------------------------------------------------
        Image {
            source: "img/index_bg.png"
            Label {
                text: qsTr("Second page4")
                anchors.centerIn: parent
            }
        }
    }


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

}
