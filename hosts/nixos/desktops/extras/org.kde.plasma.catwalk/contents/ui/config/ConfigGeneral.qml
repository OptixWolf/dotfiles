import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami
import org.kde.kcmutils as KCM

KCM.SimpleKCM {
    property alias cfg_idle: idleSlider.value
    property alias cfg_type: typeBox.currentIndex

    Kirigami.FormLayout {
        id: root

        RowLayout {
            Layout.fillWidth: true
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
            model: [i18n("Character and percentage"), i18n("Character only"), i18n("Percentage only")]
        }
    }
}
