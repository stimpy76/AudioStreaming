CONFIG += AUDIOSTREAMINGLIB

include(../../AudioStreamingLib.pri)

TARGET =    AudioStreamingLibCore
TEMPLATE =  lib
CONFIG +=   staticlib

INCLUDEPATH += $$PWD/3rdparty

SOURCES +=  $$PWD/audiostreaminglibcore.cpp \
            $$PWD/worker.cpp \
            $$PWD/discoverserver.cpp \
            $$PWD/discoverclient.cpp \
            $$PWD/abstractclient.cpp \
            $$PWD/abstractserver.cpp \
            $$PWD/client.cpp \
            $$PWD/server.cpp \
            $$PWD/encryptedclient.cpp \
            $$PWD/encryptedserver.cpp \
            $$PWD/webclient.cpp \
            $$PWD/sslclient.cpp \
            $$PWD/openssllib.cpp \
            $$PWD/tcpserver.cpp \
            $$PWD/audioinput.cpp \
            $$PWD/audiooutput.cpp \
            $$PWD/flowcontrol.cpp \
            $$PWD/levelmeter.cpp

HEADERS +=  $$PWD/audiostreaminglibcore.h \
            $$PWD/worker.h \
            $$PWD/discoverserver.h \
            $$PWD/discoverclient.h \
            $$PWD/abstractclient.h \
            $$PWD/abstractserver.h \
            $$PWD/client.h \
            $$PWD/server.h \
            $$PWD/encryptedserver.h \
            $$PWD/encryptedclient.h \
            $$PWD/webclient.h \
            $$PWD/sslclient.h \
            $$PWD/openssllib.h \
            $$PWD/tcpserver.h \
            $$PWD/audioinput.h \
            $$PWD/audiooutput.h \
            $$PWD/flowcontrol.h \
            $$PWD/common.h \
            $$PWD/levelmeter.h

WITH_OPUS {
DEFINES +=  NOMINMAX

SOURCES +=  $$PWD/opusencoderclass.cpp \
            $$PWD/opusdecoderclass.cpp \
            $$PWD/r8brain.cpp

HEADERS +=  $$PWD/opusencoderclass.h \
            $$PWD/opusdecoderclass.h \
            $$PWD/r8brain.h



win32{
INCLUDEPATH += $$WIN_R8BRAIN_RESAMPLER_INCLUDE
SOURCES += $$WIN_R8BRAIN_RESAMPLER_INCLUDE/r8bbase.cpp
}
android{
INCLUDEPATH += $$ANDROID_R8BRAIN_RESAMPLER_INCLUDE
SOURCES += $$ANDROID_R8BRAIN_RESAMPLER_INCLUDE/r8bbase.cpp
}
unix:!macx:!android{
INCLUDEPATH += $$LINUX_R8BRAIN_RESAMPLER_INCLUDE
SOURCES += $$LINUX_R8BRAIN_RESAMPLER_INCLUDE/r8bbase.cpp
}
macx{
INCLUDEPATH += $$MACOS_R8BRAIN_RESAMPLER_INCLUDE
SOURCES += $$MACOS_R8BRAIN_RESAMPLER_INCLUDE/r8bbase.cpp
}
}

#Copy header files

copyfile1.commands = $(COPY_FILE) $$PWD/AudioStreamingLibCore $$PWD/../include
copyfile2.commands = $(COPY_FILE) $$PWD/audiostreaminglibcore.h $$PWD/../include
copyfile3.commands = $(COPY_FILE) $$PWD/discoverclient.h $$PWD/../include

first.depends = $(first) copyfile1 copyfile2 copyfile3

QMAKE_EXTRA_TARGETS += first copyfile1 copyfile2 copyfile3

#Set output directory

KNOWNDEVICE:win32 { #Windows
contains(QT_ARCH, i386) {
CONFIG(debug, debug|release): DESTDIR = ../lib/x86/Debug
CONFIG(release, debug|release): DESTDIR = ../lib/x86/Release
}
contains(QT_ARCH, x86_64) {
CONFIG(debug, debug|release): DESTDIR = ../lib/x64/Debug
CONFIG(release, debug|release): DESTDIR = ../lib/x64/Release
}
}

KNOWNDEVICE:unix:!macx:!android { #Linux
contains(QT_ARCH, i386) {
CONFIG(debug, debug|release): DESTDIR = ../lib/x86/Debug
CONFIG(release, debug|release): DESTDIR = ../lib/x86/Release
}
contains(QT_ARCH, x86_64) {
CONFIG(debug, debug|release): DESTDIR = ../lib/x64/Debug
CONFIG(release, debug|release): DESTDIR = ../lib/x64/Release
}
}

KNOWNDEVICE:contains(QT_ARCH, x86_64):macx { #MACOS
CONFIG(debug, debug|release): DESTDIR = ../lib/x64/Debug
CONFIG(release, debug|release): DESTDIR = ../lib/x64/Release
}

KNOWNDEVICE:contains(ANDROID_TARGET_ARCH, armeabi):android { #ANDROID ARM
CONFIG(debug, debug|release): DESTDIR = ../android-lib/armeabi/Debug
CONFIG(release, debug|release): DESTDIR = ../android-lib/armeabi/Release
}

KNOWNDEVICE:contains(ANDROID_TARGET_ARCH, armeabi-v7a):android { #ANDROID ARMV7A
CONFIG(debug, debug|release): DESTDIR = ../android-lib/armeabi-v7a/Debug
CONFIG(release, debug|release): DESTDIR = ../android-lib/armeabi-v7a/Release
}

KNOWNDEVICE:contains(ANDROID_TARGET_ARCH, x86):android { #ANDROID x86
CONFIG(debug, debug|release): DESTDIR = ../android-lib/x86/Debug
CONFIG(release, debug|release): DESTDIR = ../android-lib/x86/Release
}

!KNOWNDEVICE { #UNKNOWN DEVICE
CONFIG(debug, debug|release): DESTDIR = ../unknown_device/Debug
CONFIG(release, debug|release): DESTDIR = ../unknown_device/Release
}

OBJECTS_DIR = $$DESTDIR/.obj
MOC_DIR = $$DESTDIR/.moc
RCC_DIR = $$DESTDIR/.qrc
UI_DIR = $$DESTDIR/.ui
