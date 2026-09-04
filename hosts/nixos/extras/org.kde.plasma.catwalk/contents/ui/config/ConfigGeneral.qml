import QtQuick 2.9
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.2 as Controls
import org.kde.kirigami 2.8 as Kirigami

Kirigami.FormLayout {
    id: root
    property alias cfg_idle: idleSlider.value
    property alias cfg_type: typeBox.currentIndex
    RowLayout {
        Kirigami.FormData.label: i18n("Idle threshold")
        Controls.Slider {
            Layout.fillWidth: true
            id: idleSlider
            from: 0
            to: 100
            stepSize: 1
        }
        Controls.Label {
            id: label
            text: idleSlider.value + "%"
            Layout.minimumWidth: textMetrics.width
            Layout.minimumHeight: textMetrics.height
            horizontalAlignment: Text.AlignRight
        }
        TextMetrics {
            id: textMetrics
            text: "199%" // for prevent distortion
        }
    }
    Controls.ComboBox {
        Layout.fillWidth: true
        Kirigami.FormData.label: i18n("Displaying items")
        id: typeBox
        model: [i18n("Character and percentage"), i18n("Character only"), i18n(
                "Percentage only")]
    }
}
