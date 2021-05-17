# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = harbour-lighthouse

CONFIG += \
    sailfishapp \
    sailfishapp_i18n

QT += dbus

SOURCES += \
    src/cpu.cpp \
    src/memory.cpp \
    src/procreader.cpp \
    src/linehandler.cpp \
    src/types.cpp \
    src/process.cpp \
    src/monitor.cpp \
    src/lighthouse.cpp

OTHER_FILES += \
    qml/cover/CoverPage.qml \
    qml/pages/Summary.qml \
    qml/pages/CPU.qml \
    qml/pages/Memory.qml \
    qml/pages/Process.qml \
    qml/Lighthouse.qml \
    qml/components/ProcIndicator.qml \
    qml/components/DoubleIndicator.qml \
    rpm/lighthouse.yaml \
    rpm/lighthouse.spec \
    harbour-lighthouse.desktop

HEADERS += \
    src/cpu.h \
    src/memory.h \
    src/procreader.h \
    src/linehandler.h \
    src/types.h \
    src/process.h \
    src/monitor.h

icon86.files += icons/86x86/harbour-lighthouse.png
icon86.path = /usr/share/icons/hicolor/86x86/apps

icon108.files += icons/108x108/harbour-lighthouse.png
icon108.path = /usr/share/icons/hicolor/108x108/apps

icon128.files += icons/128x128/harbour-lighthouse.png
icon128.path = /usr/share/icons/hicolor/128x128/apps

icon256.files += icons/256x256/harbour-lighthouse.png
icon256.path = /usr/share/icons/hicolor/256x256/apps

INSTALLS += icon86 icon108 icon128 icon256

lupdate_only {
SOURCES += \
    qml/cover/CoverPage.qml \
    qml/pages/Summary.qml \
    qml/pages/CPU.qml \
    qml/pages/Memory.qml \
    qml/pages/Process.qml \
    qml/Lighthouse.qml \
    qml/components/ProcIndicator.qml \
    qml/components/DoubleIndicator.qml
}
