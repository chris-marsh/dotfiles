import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.3

Rectangle {
    // Rectangle to provide a container/border for the calendar widget
    visible: true
    width: 380
    height: 380
    //color: "#f4f4f4"
    color: "#000000"
    signal closeCalendar()

    Calendar {
        // using the built-in Calendar widget
        id: calendar
        anchors.fill: parent
        anchors.margins: 10
        frameVisible: true
        weekNumbersVisible: true
        selectedDate: new Date() // Todays date
        focus: true

        Keys.onEscapePressed: {
            parent.closeCalendar()
        }

        style: CalendarStyle {
            gridVisible: false
            navigationBar: Rectangle {
                anchors.centerIn: Parent;
                width: parent.width;
                color: "#285577"
            }    

            dayDelegate: Rectangle {
                color: styleData.selected ? "#00a5ff" : (styleData.visibleMonth && styleData.valid ? "#285577" : "#222222");

                Label {
                    text: styleData.date.getDate()
                    anchors.centerIn: parent
                    color: styleData.valid ? "white" : "grey"
                }

                Rectangle {
                    // Horizontal grid line
                    width: parent.width
                    height: 1
                    color: "green"
                    anchors.bottom: parent.bottom
                }

                Rectangle {
                    // Vertical grid line
                    width: 1
                    height: parent.height
                    color: "green"
                    anchors.right: parent.right
                }
            }
        }
    }
}
