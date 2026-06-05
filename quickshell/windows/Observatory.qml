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

    margins {
        top: 46
        bottom: 10
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

    // -- LED blink: toggles opacity between 1.0 and 0.15 --
    property real ledBrightness: 1.0
    Timer {
        interval: 1800
        running: true
        repeat: true
        onTriggered: {
            ledBrightness = ledBrightness > 0.5 ? 0.15 : 1.0
        }
    }

    // -- signal pulse: driven by timer for reliability --
    property real signalPulse: 0.2
    property bool signalRising: true
    Timer {
        interval: 50
        running: true
        repeat: true
        onTriggered: {
            if (signalRising) {
                signalPulse += 0.012
                if (signalPulse >= 1.0) signalRising = false
            } else {
                signalPulse -= 0.012
                if (signalPulse <= 0.2) signalRising = true
            }
        }
    }

    // -- panel background --
    Rectangle {
        anchors.fill: parent
        color: "#111318"
        radius:0

        // left edge line
        Rectangle {
            width: 1
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 12
            anchors.bottomMargin: 12
            color: "#1e2028"
        }

        Flickable {
            anchors.fill: parent
            anchors.leftMargin: 1
            contentHeight: mainColumn.height + 56
            clip: true

            Column {
                id: mainColumn
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: 28
                spacing: 22

                // ═══ HEADER ═══
                Item {
                    width: parent.width
                    height: 30

                    Row {
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 10

                        // blinking status LED
                        Rectangle {
                            width: 7; height: 7; radius: 3.5
                            color: "#4d9b6a"
                            opacity: ledBrightness
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Text {
                            text: "LUNAR OBSERVATORY"
                            color: "#555b68"
                            font.family: "JetBrainsMono NF"
                            font.pixelSize: 11
                            font.letterSpacing: 4
                            font.weight: Font.Medium
                        }
                    }

                    Row {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 6

                        Rectangle {
                            width: 5; height: 5; radius: 2.5
                            color: "#4d9b6a"
                            opacity: signalPulse
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Text {
                            text: "LOCKED"
                            color: "#3a5e48"
                            font.family: "JetBrainsMono NF"
                            font.pixelSize: 9
                            font.letterSpacing: 2
                            opacity: signalPulse * 0.6 + 0.4
                        }
                    }
                }

                Rectangle {
                    width: parent.width; height: 1
                    color: "#1a1d24"
                }

                // ═══ CLOCK ═══
                Column {
                    width: parent.width
                    spacing: 6

                    Text {
                        text: currentTime
                        color: "#d4cfc8"
                        font.family: "JetBrainsMono NF"
                        font.pixelSize: 44
                        font.weight: Font.Light
                        font.letterSpacing: 6
                    }

                    Text {
                        text: currentDate.toUpperCase()
                        color: "#484e5a"
                        font.family: "JetBrainsMono NF"
                        font.pixelSize: 11
                        font.letterSpacing: 2
                    }
                }

                // ═══ MOON SECTION ═══
                Rectangle {
                    width: parent.width
                    height: moonContent.height + 44
                    radius: 6
                    color: "#151820"
                    border.width: 1
                    border.color: "#1e222c"

                    Column {
                        id: moonContent
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.margins: 22
                        spacing: 18

                        // section label
                        Row {
                            width: parent.width
                            spacing: 8

                            Rectangle {
                                width: 6; height: 6; radius: 3
                                color: "#7088b0"
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            Text {
                                text: "MOON TRACKING"
                                color: "#7088b0"
                                font.family: "JetBrainsMono NF"
                                font.pixelSize: 10
                                font.letterSpacing: 3
                                font.weight: Font.Medium
                            }

                            Item { width: 4; height: 1 }

                            Text {
                                text: "● ONLINE"
                                color: "#3d7a55"
                                font.family: "JetBrainsMono NF"
                                font.pixelSize: 9
                                font.letterSpacing: 1.5
                                anchors.verticalCenter: parent.verticalCenter
                                opacity: signalPulse * 0.5 + 0.5
                            }
                        }

                        // moon phase visual + primary info
                        Row {
                            width: parent.width
                            spacing: 24

                            Canvas {
                                id: moonCanvas
                                width: 84
                                height: 84

                                property string phase: moonPhase

                                onPhaseChanged: requestPaint()
                                onPaint: {
                                    var ctx = getContext("2d")
                                    ctx.reset()

                                    var cx = width / 2
                                    var cy = height / 2
                                    var r = 38

                                    // glow
                                    ctx.beginPath()
                                    ctx.arc(cx, cy, r + 4, 0, 2 * Math.PI)
                                    ctx.fillStyle = "rgba(180, 175, 165, 0.04)"
                                    ctx.fill()

                                    // disc
                                    ctx.beginPath()
                                    ctx.arc(cx, cy, r, 0, 2 * Math.PI)
                                    ctx.fillStyle = "#a8a098"
                                    ctx.fill()

                                    // phase shadow
                                    var p = phase.toLowerCase()
                                    var shadowSide = "right"
                                    var shadowAmount = 0.5

                                    if (p.indexOf("new") >= 0) {
                                        shadowAmount = 1.0
                                        shadowSide = "full"
                                    } else if (p.indexOf("full") >= 0) {
                                        shadowAmount = 0.0
                                    } else if (p.indexOf("waxing crescent") >= 0) {
                                        shadowAmount = 0.75
                                        shadowSide = "left"
                                    } else if (p.indexOf("first quarter") >= 0) {
                                        shadowAmount = 0.5
                                        shadowSide = "left"
                                    } else if (p.indexOf("waxing gibbous") >= 0) {
                                        shadowAmount = 0.25
                                        shadowSide = "left"
                                    } else if (p.indexOf("waning gibbous") >= 0) {
                                        shadowAmount = 0.25
                                        shadowSide = "right"
                                    } else if (p.indexOf("last quarter") >= 0 || p.indexOf("third quarter") >= 0) {
                                        shadowAmount = 0.5
                                        shadowSide = "right"
                                    } else if (p.indexOf("waning crescent") >= 0) {
                                        shadowAmount = 0.75
                                        shadowSide = "right"
                                    }

                                    if (shadowAmount > 0 && shadowSide !== "none") {
                                        ctx.save()
                                        ctx.beginPath()
                                        ctx.arc(cx, cy, r, 0, 2 * Math.PI)
                                        ctx.clip()

                                        ctx.fillStyle = "#151820"

                                        if (shadowSide === "full") {
                                            ctx.fillRect(0, 0, width, height)
                                        } else if (shadowSide === "left") {
                                            ctx.fillRect(cx - r, cy - r, r * 2 * shadowAmount, r * 2)
                                        } else {
                                            ctx.fillRect(cx + r - r * 2 * shadowAmount, cy - r, r * 2 * shadowAmount, r * 2)
                                        }

                                        ctx.restore()
                                    }

                                    // craters
                                    ctx.fillStyle = "rgba(0,0,0,0.1)"
                                    ctx.beginPath(); ctx.arc(cx - 8, cy - 12, 4, 0, 2*Math.PI); ctx.fill()
                                    ctx.beginPath(); ctx.arc(cx + 11, cy + 6, 3, 0, 2*Math.PI); ctx.fill()
                                    ctx.beginPath(); ctx.arc(cx - 4, cy + 15, 2.5, 0, 2*Math.PI); ctx.fill()
                                    ctx.beginPath(); ctx.arc(cx + 15, cy - 9, 2, 0, 2*Math.PI); ctx.fill()
                                }
                            }

                            Column {
                                spacing: 8
                                anchors.verticalCenter: parent.verticalCenter

                                Text {
                                    text: moonPhase || "—"
                                    color: "#d4cfc8"
                                    font.family: "JetBrainsMono NF"
                                    font.pixelSize: 16
                                }

                                Text {
                                    text: moonAge ? "AGE  " + moonAge + " days" : "—"
                                    color: "#7088b0"
                                    font.family: "JetBrainsMono NF"
                                    font.pixelSize: 11
                                    font.letterSpacing: 1
                                }
                            }
                        }

                        // telemetry readout
                        Row {
                            width: parent.width
                            spacing: 0

                            Column {
                                width: parent.width / 2
                                spacing: 4

                                Text {
                                    text: "DISTANCE"
                                    color: "#3e4452"
                                    font.family: "JetBrainsMono NF"
                                    font.pixelSize: 9
                                    font.letterSpacing: 2
                                }
                                Text {
                                    text: moonDistance ? moonDistance + " km" : "—"
                                    color: "#8a8580"
                                    font.family: "JetBrainsMono NF"
                                    font.pixelSize: 13
                                }
                            }

                            Column {
                                width: parent.width / 2
                                spacing: 4

                                Text {
                                    text: "DIAMETER"
                                    color: "#3e4452"
                                    font.family: "JetBrainsMono NF"
                                    font.pixelSize: 9
                                    font.letterSpacing: 2
                                }
                                Text {
                                    text: moonDiameter || "—"
                                    color: "#8a8580"
                                    font.family: "JetBrainsMono NF"
                                    font.pixelSize: 13
                                }
                            }
                        }

                        Rectangle {
                            width: parent.width; height: 1
                            color: "#1e222c"
                        }

                        // coordinates
                        Row {
                            width: parent.width
                            spacing: 0

                            Column {
                                width: parent.width / 2
                                spacing: 3

                                Text {
                                    text: "RA"
                                    color: "#2e3340"
                                    font.family: "JetBrainsMono NF"
                                    font.pixelSize: 9
                                    font.letterSpacing: 2
                                }
                                Text {
                                    text: moonRa || "—"
                                    color: "#555b68"
                                    font.family: "JetBrainsMono NF"
                                    font.pixelSize: 12
                                }
                            }

                            Column {
                                width: parent.width / 2
                                spacing: 3

                                Text {
                                    text: "DEC"
                                    color: "#2e3340"
                                    font.family: "JetBrainsMono NF"
                                    font.pixelSize: 9
                                    font.letterSpacing: 2
                                }
                                Text {
                                    text: moonDec || "—"
                                    color: "#555b68"
                                    font.family: "JetBrainsMono NF"
                                    font.pixelSize: 12
                                }
                            }
                        }
                    }
                }

                // ═══ WEATHER / CONDITIONS ═══
                Rectangle {
                    width: parent.width
                    height: weatherContent.height + 40
                    radius: 6
                    color: "#151820"
                    border.width: 1
                    border.color: "#1e222c"

                    Column {
                        id: weatherContent
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.margins: 20
                        spacing: 16

                        Row {
                            spacing: 8

                            Rectangle {
                                width: 6; height: 6; radius: 3
                                color: "#6a8058"
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            Text {
                                text: "OBS CONDITIONS"
                                color: "#6a8058"
                                font.family: "JetBrainsMono NF"
                                font.pixelSize: 10
                                font.letterSpacing: 3
                                font.weight: Font.Medium
                            }
                        }

                        // 2x2 grid
                        Row {
                            width: parent.width
                            spacing: 0

                            Column {
                                width: parent.width / 2
                                spacing: 4

                                Text {
                                    text: "TEMP"
                                    color: "#3e4452"
                                    font.family: "JetBrainsMono NF"
                                    font.pixelSize: 9
                                    font.letterSpacing: 2
                                }
                                Text {
                                    text: weatherTemp || "—"
                                    color: "#8a8580"
                                    font.family: "JetBrainsMono NF"
                                    font.pixelSize: 15
                                }
                            }

                            Column {
                                width: parent.width / 2
                                spacing: 4

                                Text {
                                    text: "HUMIDITY"
                                    color: "#3e4452"
                                    font.family: "JetBrainsMono NF"
                                    font.pixelSize: 9
                                    font.letterSpacing: 2
                                }
                                Text {
                                    text: weatherHumidity || "—"
                                    color: "#8a8580"
                                    font.family: "JetBrainsMono NF"
                                    font.pixelSize: 15
                                }
                            }
                        }

                        Row {
                            width: parent.width
                            spacing: 0

                            Column {
                                width: parent.width / 2
                                spacing: 4

                                Text {
                                    text: "CLOUD COVER"
                                    color: "#3e4452"
                                    font.family: "JetBrainsMono NF"
                                    font.pixelSize: 9
                                    font.letterSpacing: 2
                                }
                                Text {
                                    text: weatherClouds || "—"
                                    color: "#8a8580"
                                    font.family: "JetBrainsMono NF"
                                    font.pixelSize: 15
                                }
                            }

                            Column {
                                width: parent.width / 2
                                spacing: 4

                                Text {
                                    text: "WIND"
                                    color: "#3e4452"
                                    font.family: "JetBrainsMono NF"
                                    font.pixelSize: 9
                                    font.letterSpacing: 2
                                }
                                Text {
                                    text: weatherWind || "—"
                                    color: "#8a8580"
                                    font.family: "JetBrainsMono NF"
                                    font.pixelSize: 15
                                }
                            }
                        }
                    }
                }

                Rectangle {
                    width: parent.width; height: 1
                    color: "#1a1d24"
                }

                // ═══ AUDIO / MUSIC ═══
                Rectangle {
                    width: parent.width
                    height: musicContent.height + 40
                    radius: 6
                    color: "#151820"
                    border.width: 1
                    border.color: "#1e222c"

                    Column {
                        id: musicContent
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.margins: 20
                        spacing: 16

                        Row {
                            spacing: 8

                            Rectangle {
                                width: 6; height: 6; radius: 3
                                color: songStatus === "Playing" ? "#7a6db0" : "#383348"
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            Text {
                                text: "AUDIO FEED"
                                color: "#7a6db0"
                                font.family: "JetBrainsMono NF"
                                font.pixelSize: 10
                                font.letterSpacing: 3
                                font.weight: Font.Medium
                            }

                            Item { width: 6; height: 1 }

                            Text {
                                text: songStatus === "Playing" ? "▸ ACTIVE" : songStatus === "Paused" ? "‖ PAUSED" : "—"
                                color: songStatus === "Playing" ? "#4d9b6a" : "#3e4452"
                                font.family: "JetBrainsMono NF"
                                font.pixelSize: 9
                                font.letterSpacing: 1.5
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        Column {
                            width: parent.width
                            spacing: 5

                            Text {
                                width: parent.width
                                text: songTitle || "NO SIGNAL"
                                color: songTitle ? "#d4cfc8" : "#3e4452"
                                font.family: "JetBrainsMono NF"
                                font.pixelSize: 14
                                elide: Text.ElideRight
                                maximumLineCount: 2
                                wrapMode: Text.WordWrap
                            }

                            Text {
                                text: songArtist || "—"
                                color: "#555b68"
                                font.family: "JetBrainsMono NF"
                                font.pixelSize: 11
                            }
                        }

                        // transport controls
                        Row {
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: 20

                            // previous
                            Rectangle {
                                width: 38
                                height: 38
                                radius: 4
                                color: prevArea.containsMouse ? "#1e222c" : "#181c24"
                                border.width: 1
                                border.color: prevArea.containsMouse ? "#2a303c" : "#1e222c"

                                Behavior on color { ColorAnimation { duration: 120 } }

                                Text {
                                    anchors.centerIn: parent
                                    text: "⏮"
                                    color: "#6a6866"
                                    font.pixelSize: 13
                                }

                                MouseArea {
                                    id: prevArea
                                    anchors.fill: parent
                                    hoverEnabled: true

                                    onClicked: {
                                        previousProc.running = true
                                        musicRefreshTimer.start()
                                        musicProc.running = true
                                    }
                                }
                            }

                            // play/pause
                            Rectangle {
                                width: 46
                                height: 46
                                radius: 4
                                color: ppArea.containsMouse ? "#222630" : "#1a1e28"
                                border.width: 1
                                border.color: ppArea.containsMouse ? "#353a48" : "#262a34"

                                Behavior on color { ColorAnimation { duration: 120 } }

                                Text {
                                    anchors.centerIn: parent
                                    text: songStatus === "Playing" ? "⏸" : "▶"
                                    color: "#a8a098"
                                    font.pixelSize: 16
                                }

                                MouseArea {
                                    id: ppArea
                                    anchors.fill: parent
                                    hoverEnabled: true

                                    onClicked: {
                                        playPauseProc.running = true
                                        musicRefreshTimer.start()
                                        musicProc.running = true
                                    }
                                }
                            }

                            // next
                            Rectangle {
                                width: 38
                                height: 38
                                radius: 4
                                color: nextArea.containsMouse ? "#1e222c" : "#181c24"
                                border.width: 1
                                border.color: nextArea.containsMouse ? "#2a303c" : "#1e222c"

                                Behavior on color { ColorAnimation { duration: 120 } }

                                Text {
                                    anchors.centerIn: parent
                                    text: "⏭"
                                    color: "#6a6866"
                                    font.pixelSize: 13
                                }

                                MouseArea {
                                    id: nextArea
                                    anchors.fill: parent
                                    hoverEnabled: true

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

                // ═══ FOOTER TELEMETRY BAR ═══
                Item {
                    width: parent.width
                    height: 24

                    Row {
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 18

                        Row {
                            spacing: 5
                            Rectangle {
                                width: 4; height: 4; radius: 2
                                color: "#4d9b6a"
                                anchors.verticalCenter: parent.verticalCenter
                                opacity: ledBrightness
                            }
                            Text {
                                text: "TRK"
                                color: "#2e3340"
                                font.family: "JetBrainsMono NF"
                                font.pixelSize: 9
                                font.letterSpacing: 1.5
                            }
                        }

                        Row {
                            spacing: 5
                            Rectangle {
                                width: 4; height: 4; radius: 2
                                color: "#7088b0"
                                anchors.verticalCenter: parent.verticalCenter
                                opacity: signalPulse
                            }
                            Text {
                                text: "TEL"
                                color: "#2e3340"
                                font.family: "JetBrainsMono NF"
                                font.pixelSize: 9
                                font.letterSpacing: 1.5
                            }
                        }

                        Row {
                            spacing: 5
                            Rectangle {
                                width: 4; height: 4; radius: 2
                                color: "#6a8058"
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Text {
                                text: "ENV"
                                color: "#2e3340"
                                font.family: "JetBrainsMono NF"
                                font.pixelSize: 9
                                font.letterSpacing: 1.5
                            }
                        }
                    }
                }
            }
        }
    }
}