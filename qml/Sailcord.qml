import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"
import io.thp.pyotherside 1.4

ApplicationWindow
{
    id: appWindow
    property string pwd
    property string email
    property variant serverModel: serverModel

    ListModel{
       id:serverModel
    }
    initialPage: Component { FirstPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")

    Python {
        id: python
        Component.onCompleted: {
            console.debug('PyOtherSide version: ' + pluginVersion());
            console.debug('Python version: ' + pythonVersion());
            addImportPath(Qt.resolvedUrl('../'));
            addImportPath(Qt.resolvedUrl('.'));
            importModule('discord', function () {})
            importModule('asyncio',function(){})
            importModule('DiscordClient', function () {
                if (!appWindow.pwd && !appWindow.email){
                    var credentialsDialog = pageStack.push(Qt.resolvedUrl("./pages/SecondPage.qml"))
                    credentialsDialog.accepted.connect(function() {
                        appWindow.pwd = credentialsDialog.pwd
                        appWindow.email = credentialsDialog.email
                        call('DiscordClient.run', [appWindow.email, appWindow.pwd], function() {

                        })
                    })
                }
            })
            setHandler('Discord-Servers', function(servers){
                console.log(servers)
                for (var i=0; i<servers.length; i++) {
                    console.log(servers[i])
                    serverModel.append(servers[i]);
                }
            });
            setHandler('Discord-Message', function(message){
                console.log(message)
            });
            setHandler('Discord-Status', function(message){
                console.log(message)
            });
         }
        onImport: {
            console.debug("Python module was succesfully imported" )
        }
        onError: {
            // when an exception is raised, this error handler will be called
            console.log('Python Error: ' + traceback);
        }

        onReceived: {
            // asychronous messages from Python arrive here
            // in Python, this can be accomplished via pyotherside.send()
            console.log('Python Message: ' + data);
        }
    }

    allowedOrientations: defaultAllowedOrientations
}
