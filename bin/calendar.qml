import QtQuick 2.3
import QtQuick.Controls 1.2

Rectangle {
    // Rectangle to provide a container/border for the calendar widget
    visible: true
    width: 380
    height: 380
    color: "#f4f4f4"
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
    }
}
