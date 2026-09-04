import QtQuick 2.15
import QtQuick.Layouts 1.15
import org.kde.ksysguard.sensors 1.0 as Sensors
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents3

Item {
    id: compactRepresentation
    Layout.minimumHeight: root.inPanel ? Layout.preferredHeight : -1
    Layout.preferredWidth: grid.width
    Layout.preferredHeight: grid.height
    enum LayoutType {
        HorizontalPanel,
        VerticalPanel,
        HorizontalDesktop,
        VerticalDesktop
    }
    property int layoutForm

    Binding on layoutForm {
        delayed: true
        value: {
            if (root.inPanel) {
                return root.isVertical ? CompactRepresentation.LayoutType.VerticalPanel : CompactRepresentation.LayoutType.HorizontalPanel
            }
            if (compactRepresentation.parent.width
                    - svgItem.Layout.preferredWidth >= label.contentWidth) {
                return CompactRepresentation.LayoutType.HorizontalDesktop
            }
            if (compactRepresentation.parent.height
                    - svgItem.Layout.preferredHeight >= label.contentHeight) {
                return CompactRepresentation.LayoutType.VerticalDesktop
            }
        }
    }

    GridLayout {
        id: grid
        width: {
            switch (compactRepresentation.layoutForm) {
            case CompactRepresentation.LayoutType.HorizontalPanel:
            case CompactRepresentation.LayoutType.HorizontalDesktop:
                return implicitWidth
            case CompactRepresentation.LayoutType.VerticalPanel:
            case CompactRepresentation.LayoutType.VerticalDesktop:
                return compactRepresentation.parent.width
            }
        }
        height: {
            switch (compactRepresentation.layoutForm) {
            case CompactRepresentation.LayoutType.HorizontalPanel:
            case CompactRepresentation.LayoutType.HorizontalDesktop:
            case CompactRepresentation.LayoutType.VerticalDesktop:
                return compactRepresentation.parent.height
            case CompactRepresentation.LayoutType.VerticalPanel:
                return implicitHeight
            }
        }
        rowSpacing: 0
        columnSpacing: rowSpacing
        flow: {
            switch (compactRepresentation.layoutForm) {
            case CompactRepresentation.LayoutType.VerticalPanel:
            case CompactRepresentation.LayoutType.VerticalDesktop:
                return GridLayout.TopToBottom
            default:
                return GridLayout.LeftToRight
            }
        }
        PlasmaCore.SvgItem {
            property int sourceIndex: 0
            id: svgItem
            opacity: 1
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            Layout.preferredWidth: Math.min(compactRepresentation.parent.width,
                                            compactRepresentation.parent.height)
            Layout.preferredHeight: Layout.preferredWidth
            Layout.maximumHeight: 128
            Layout.maximumWidth: 128
            visible: plasmoid.configuration.type !== 2
            svg: PlasmaCore.Svg {
                id: svg
                colorGroup: PlasmaCore.ColorScope.colorGroup
                imagePath: Qt.resolvedUrl("../icons/my-idle-symbolic.svg")
            }
        }
        ColumnLayout {
            id: labelLayout
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            Layout.fillWidth: layoutForm === CompactRepresentation.LayoutType.VerticalPanel
                              || layoutForm === CompactRepresentation.LayoutType.VerticalDesktop
            Layout.maximumWidth: {
                switch (layoutForm) {
                case CompactRepresentation.LayoutType.HorizontalPanel:
                    return PlasmaCore.Units.gridUnit * 10
                case CompactRepresentation.LayoutType.HorizontalDesktop:
                    return compactRepresentation.parent.width
                default:
                    return grid.Layout.preferredWidth
                }
            }
            Layout.maximumHeight: textMetrics.height
            visible: plasmoid.configuration.type !== 1
            spacing: parent.columnSpacing
            PlasmaComponents3.Label {
                property double fontHeightRatio: textMetrics.font.pixelSize / textMetrics.height
                id: label
                text: totalSensor.formattedValue
                Layout.fillWidth: parent.Layout.fillWidth
                Layout.maximumWidth: Layout.fillWidth ? -1 : textMetrics.width
                Layout.minimumWidth: root.isVertical ? parent.width : textMetrics.width
                                                       / textMetrics.height * height
                height: parent.height * 0.71
                // TODO
                font.pixelSize: isVertical ? width / fontHeightRatio
                                             * 0.3 : height * fontHeightRatio
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                renderType: Text.NativeRendering
            }

            TextMetrics {
                id: textMetrics
                font.pixelSize: 64
                text: "100,0%"
            }
            Sensors.Sensor {
                id: totalSensor
                sensorId: "cpu/all/usage"
            }
            Timer {
                id: switchTimer
                repeat: true
                running: true
                interval: Math.ceil(
                              5000 / Math.sqrt(
                                  totalSensor.value + 35) - 400) // Used from original widget
                onTriggered: {
                    if (svgItem.sourceIndex == 5) {
                        svgItem.sourceIndex = 0
                    }
                    svg.imagePath = (totalSensor.value < plasmoid.configuration.idle) ? Qt.resolvedUrl("../icons/my-idle-symbolic.svg") : Qt.resolvedUrl("../icons/my-active-" + svgItem.sourceIndex + "-symbolic.svg")
                    svgItem.sourceIndex += 1
                }
            }
        }
    }
}
