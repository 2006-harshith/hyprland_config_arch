import QtQuick
import QtQuick3D
import Quickshell
import Quickshell.Services.UPower
import Quickshell.Io
import "windows"

ShellRoot {

    property bool showAnimation: false
    property bool showObservatory: false
    

    Process {
        id: enterSound
        command: [
            "pw-play",
            "/home/harshith/.config/quickshell/assets/enter_sound.wav"
        ]
    }

    Process {
        id: exitSound
        command: [
            "pw-play",
            "/home/harshith/.config/quickshell/assets/exit.wav"
        ]
    }

    Connections {
        target: UPower

        function onOnBatteryChanged() {
            console.log("BATTERY EVENT")
            console.log("On battery:", UPower.onBattery)
            if (!UPower.onBattery) {
                showAnimation = true
                console.log("CHARGER CONNECTED")
                enterSound.running = true
                chargingWindow.playAnimation()
            }
        }
    }

    Charging {
        id: chargingWindow
        visible: showAnimation
        
        onPlayExitSound: {
            exitSound.running = true
        }
        onAnimationFinished: {
            showAnimation = false
        }
    }

    FileView {
        id: observatoryToggle

        path: "/tmp/observatory-toggle"
        watchChanges: true

        onFileChanged: {
            showObservatory = !showObservatory
        }
    }    

    Observatory {
        visible: showObservatory
    }
}
