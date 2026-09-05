import QtQuick
import QtQuick.Layouts

import org.kde.ksvg as KSvg
import org.kde.ksysguard.sensors as Sensors
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents3
import org.kde.plasma.plasmoid

Item {
    id: compactRepresentation

    enum LayoutType {
        HorizontalPanel,
        VerticalPanel,
        HorizontalDesktop,
        VerticalDesktop
    }

    readonly property real availableWidth: width
    readonly property real availableHeight: height
    readonly property real panelThickness:
    root.isVertical
    ? availableWidth
    : availableHeight

    readonly property int layoutForm: {
        if (root.inPanel) {
            return root.isVertical
            ? CompactRepresentation.LayoutType.VerticalPanel
            : CompactRepresentation.LayoutType.HorizontalPanel
        }

        if (compactRepresentation.width > 0 && compactRepresentation.height > 0) {
            if (compactRepresentation.width >= compactRepresentation.height) {
                return CompactRepresentation.LayoutType.HorizontalDesktop
            }

            return CompactRepresentation.LayoutType.VerticalDesktop
        }

        return CompactRepresentation.LayoutType.HorizontalPanel
    }

    implicitWidth: layout.implicitWidth
    implicitHeight: layout.implicitHeight

    Layout.minimumWidth: root.inPanel && !root.isVertical
    ? implicitWidth
    : 0

    Layout.minimumHeight: root.inPanel && root.isVertical
    ? implicitHeight
    : 0

    Layout.preferredWidth: implicitWidth
    Layout.preferredHeight: implicitHeight

    Sensors.Sensor {
        id: totalSensor

        sensorId: "cpu/all/usage"
    }

    TextMetrics {
        id: textMetrics

        font: label.font
        text: "100.0%"
    }

    Timer {
        id: switchTimer

        repeat: true
        running: icon.visible
        triggeredOnStart: true

        interval: {
            var value = Number(totalSensor.value)

            if (!isFinite(value)) {
                value = 0
            }

            return Math.max(
                50,
                Math.ceil(
                    5000 / Math.sqrt(Math.max(0, value) + 35) - 400
                )
            )
        }

        onTriggered: {
            var value = Number(totalSensor.value)

            if (!isFinite(value)) {
                value = 0
            }

            if (value < Number(Plasmoid.configuration.idle)) {
                icon.imagePath =
                Qt.resolvedUrl("../icons/my-idle-symbolic.svg")
                icon.sourceIndex = 0
                return
            }

            icon.imagePath = Qt.resolvedUrl(
                "../icons/my-active-" +
                icon.sourceIndex +
                "-symbolic.svg"
            )

            icon.sourceIndex = (icon.sourceIndex + 1) % 6
        }
    }

    GridLayout {
        id: layout

        anchors.fill: parent

        rowSpacing: Kirigami.Units.smallSpacing
        columnSpacing: Kirigami.Units.smallSpacing

        flow: {
            switch (compactRepresentation.layoutForm) {
                case CompactRepresentation.LayoutType.VerticalPanel:
                case CompactRepresentation.LayoutType.VerticalDesktop:
                    return GridLayout.TopToBottom
                default:
                    return GridLayout.LeftToRight
            }
        }

        KSvg.SvgItem {
            id: icon

            property int sourceIndex: 0

            Layout.alignment: Qt.AlignCenter

            Layout.preferredWidth: {
                if (root.inPanel) {
                    return root.isVertical
                    ? Math.max(1, compactRepresentation.availableWidth * 0.8)
                    : Math.max(1, compactRepresentation.availableHeight * 0.8)
                }

                return Math.max(
                    1,
                    Math.min(
                        compactRepresentation.availableWidth > 0
                        ? compactRepresentation.availableWidth
                        : 64,
                        compactRepresentation.availableHeight > 0
                        ? compactRepresentation.availableHeight
                        : 64
                    )
                )
            }

            Layout.preferredHeight: Layout.preferredWidth

            Layout.minimumWidth: 1
            Layout.minimumHeight: 1
            Layout.maximumWidth: 128
            Layout.maximumHeight: 128

            visible: Plasmoid.configuration.type !== 2

            imagePath: Qt.resolvedUrl("../icons/my-idle-symbolic.svg")
        }

        PlasmaComponents3.Label {
            id: label

            Layout.alignment: Qt.AlignCenter

            visible: Plasmoid.configuration.type !== 1

            text: totalSensor.formattedValue || "0.0%"

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            renderType: Text.NativeRendering

            Layout.preferredWidth: textMetrics.width
            Layout.preferredHeight: textMetrics.height

            Layout.minimumWidth: textMetrics.width
            Layout.minimumHeight: textMetrics.height

            font.pixelSize: {
                if (root.inPanel) {
                    if (compactRepresentation.panelThickness > 0) {
                        return Math.max(
                            8,
                            Math.min(
                                64,
                                compactRepresentation.panelThickness * 0.7
                            )
                        )
                    }

                    return 16
                }

                if (compactRepresentation.availableWidth > 0
                    && compactRepresentation.availableHeight > 0) {
                    return Math.max(
                        8,
                        Math.min(
                            64,
                            Math.min(
                                compactRepresentation.availableWidth,
                                compactRepresentation.availableHeight
                            ) * 0.3
                        )
                    )
                    }

                    return 16
            }
        }
    }
}
