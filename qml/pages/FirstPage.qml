import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    SilicaListView {
        keyNavigationWraps:true
        id: serverView
        anchors {
            fill: parent
            bottomMargin: panel.margin
        }
        snapMode: ListView.SnapOneItem
        quickScrollEnabled: false
        clip: panel.expanded
        highlightFollowsCurrentItem: true
        model: serverModel
        onMovementEnded: currentIndex = indexAt(0,contentY)
        onDragStarted: panel.open = true
        onDragEnded: indexIndicatorTimer.start()
        focus: true
        delegate: Item {
            id: column
            width: serverView.width
            height: Screen.height
            Label {
                anchors.centerIn: parent
                id: contactInfo
                text: name
            }
        }
        Timer {
            id: indexIndicatorTimer
            interval: 500
            repeat: false
            triggeredOnStart: false
            onTriggered: {
                panel.open = !panel.open
                indexIndicatorTimer.stop()
            }
        }
    }

    DockedPanel {
        id: panel

        width: Theme.itemSizeExtraLarge + Theme.paddingLarge
        height: parent.height

        dock: Dock.Left

        SilicaListView {
            currentIndex: serverView.currentIndex
            anchors.fill: parent
            height: parent.height
            width: parent.width
            anchors.centerIn: parent
            model:serverModel
            delegate: BackgroundItem {
                highlighted: ListView.isCurrentItem
                Label {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    text: name
                }
            }
        }
    }
}
