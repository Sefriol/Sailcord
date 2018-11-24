import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    id: page

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All
    property alias pwd: pwdfield.text
    property alias email: emailfield.text
    canAccept: pwd.length && email.length
    Column {
        anchors.fill: parent
        DialogHeader {
            acceptText: defaultAcceptText
        }

        TextField {
             id: emailfield
             label: "Email"
             inputMethodHints: Qt.ImhEmailCharactersOnly | Qt.ImhNoPredictiveText
             placeholderText: label
             EnterKey.iconSource: "image://theme/icon-m-enter-next"
             EnterKey.onClicked: pwdfield.focus = true
         }

         PasswordField {
             id: pwdfield
             EnterKey.iconSource: "image://theme/icon-m-enter-accept"
             EnterKey.onClicked: dialog.accept()
         }
    }
}
