import QtQuick
import Quickshell
import Quickshell.Io

PanelWindow {
    property string moonAge: ""
    property string moonPhase: ""
    property string moonDistance: ""
    property string moonDiameter: ""
    property string moonRa: ""
    property string moonDec: ""
    property string moonTime: ""

    property string currentTime: ""
    property string currentDate: ""

    property string weatherTemp: ""
    property string weatherHumidity: ""
    property string weatherClouds: ""
    property string weatherWind: ""

    property string songStatus: ""
    property string songTitle: ""
    property string songArtist: ""
    visible: true

    anchors {
        right: true
        top: true
        bottom: true
    }

    implicitWidth: 450

    Process {
        id: moonProc
        command: ["bash", "-c", "~/.config/quickshell/scripts/moon.sh"]

        stdout: SplitParser {
            onRead: data => {

                if (data.startsWith("AGE="))
                    moonAge = data.substring(4)

                else if (data.startsWith("PHASE="))
                    moonPhase = data.substring(6)

                else if (data.startsWith("DISTANCE="))
                    moonDistance = data.substring(9)

                else if (data.startsWith("DIAMETER="))
                    moonDiameter = data.substring(9)

                else if (data.startsWith("RA="))
                    moonRa = data.substring(3)

                else if (data.startsWith("DEC="))
                    moonDec = data.substring(4)

                else if (data.startsWith("TIME="))
                    moonTime = data.substring(5)
            }
        }
    }

    Process {
        id: weatherProc
        command: ["bash", "-c", "~/.config/quickshell/scripts/weather.sh"]

        stdout: SplitParser {
            onRead: data => {

                if (data.startsWith("TEMP="))
                    weatherTemp = data.substring(5)

                else if (data.startsWith("HUMIDITY="))
                    weatherHumidity = data.substring(9)

                else if (data.startsWith("CLOUDS="))
                    weatherClouds = data.substring(7)

                else if (data.startsWith("WIND="))
                    weatherWind = data.substring(5)
            }
        }
    }

    Process {
        id: musicProc
        command: ["bash", "-c", "~/.config/quickshell/scripts/music.sh"]

        stdout: SplitParser {
            onRead: data => {

                if (data.startsWith("STATUS="))
                    songStatus = data.substring(7)

                else if (data.startsWith("TITLE="))
                    songTitle = data.substring(6)

                else if (data.startsWith("ARTIST="))
                    songArtist = data.substring(7)
            }
        }
    }
    Process {
        id: playPauseProc
        command: ["playerctl", "play-pause"]
    }

    Process {
        id: nextProc
        command: ["playerctl", "next"]
    }

    Process {
        id: previousProc
        command: ["playerctl", "previous"]
    }

    Timer {
        interval: 300000
        running: true
        repeat: true

        onTriggered: {
            weatherProc.running = true
        }
    }
    Timer {
        interval: 3600000
        running: true
        repeat: true

        onTriggered: {
            moonProc.running = true
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true

        onTriggered: {
            const now = new Date()

            currentTime = Qt.formatTime(now, "HH:mm:ss")
            currentDate = Qt.formatDate(now, "dddd, dd MMM yyyy")
        }
    }
    
    //clock
    Component.onCompleted: {
        const now = new Date()

        currentTime = Qt.formatTime(now, "HH:mm:ss")
        currentDate = Qt.formatDate(now, "dddd, dd MMM yyyy")

        moonProc.running = true
        weatherProc.running = true
        musicProc.running = true
    }
    Timer {
        id: musicRefreshTimer
        interval: 500
        repeat: false

        onTriggered: {
            musicProc.running = true
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "#cc000000"

        Column {
            anchors.centerIn: parent
            spacing: 8

            Text {
                color: "white"
                text: "Time: " + currentTime
            }
            Text {
                color: "white"
                text: currentDate
            }

            Text {
                color: "white"
                text: "Age: " + moonAge
            }

            Text {
                color: "white"
                text: "Phase: " + moonPhase
            }

            Text {
                color: "white"
                text: "Distance: " + moonDistance
            }

            Text {
                color: "white"
                text: "Diameter: " + moonDiameter
            }
            Text {
                color: "white"
                text: "RA: " + moonRa
            }

            Text {
                color: "white"
                text: "DEC: " + moonDec
            }

            

            Text {
                color: "white"
                text: "Temp: " + weatherTemp
            }

            Text {
                color: "white"
                text: "Humidity: " + weatherHumidity
            }

            Text {
                color: "white"
                text: "Clouds: " + weatherClouds
            }

            Text {
                color: "white"
                text: "Wind: " + weatherWind
            }

            Text {
                width: 350
                wrapMode: Text.WordWrap
                color: "white"
                text: "Song: " + songTitle
            }

            Text {
                color: "white"
                text: "Artist: " + songArtist
            }

            Text {
                color: "white"
                text: "Status: " + songStatus
            }
            Row {
                spacing: 20

                Rectangle {
                    width: 50
                    height: 50
                    radius: 25
                    color: "#303030"

                    Text {
                        anchors.centerIn: parent
                        text: "⏮"
                        color: "white"
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            previousProc.running = true
                            musicRefreshTimer.start()
                            musicProc.running = true
                        }
                    }
                }

                Rectangle {
                    width: 60
                    height: 60
                    radius: 30
                    color: "#505050"

                    Text {
                        anchors.centerIn: parent
                        text: songStatus === "Playing" ? "⏸" : "▶"
                        color: "white"
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            playPauseProc.running = true
                            musicRefreshTimer.start()
                            musicProc.running = true
                        }
                    }
                }

                Rectangle {
                    width: 50
                    height: 50
                    radius: 25
                    color: "#303030"

                    Text {
                        anchors.centerIn: parent
                        text: "⏭"
                        color: "white"
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            nextProc.running = true
                            musicRefreshTimer.start()
                            musicProc.running = true
                        }
                    }
                }
            }
        }
    }
}