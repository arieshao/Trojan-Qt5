#
# Copyright (C) 2015-2016 Symeon Huang <hzwhuang@gmail.com>
# Copyright (C) 2019-2020 TheWanderingCoel <thewanderingcoel@protonmail.com>
#
# Trojan-Qt5 is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published
# by the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# Trojan-Qt5 is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Trojan-Qt5; see the file LICENSE. If not, see
# <http://www.gnu.org/licenses/>.
#

requires(qtHaveModule(httpserver))

QT       += core gui network httpserver

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

RC_ICONS = $$PWD/resources/icons/trojan-qt5.ico
ICON = $$PWD/resources/icons/trojan-qt5.icns

TARGET = trojan-qt5

# Use OpenSource Version of Qt5
QT_EDITION = OpenSource

CONFIG += c++11
CONFIG += sdk_no_version_check

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
#DEFINES += QT_DEPRECATED_WARNINGS

# Define App Version
DEFINES += "APP_VERSION=\"\\\"0.0.3\\\"\""

# Trojan
#DEFINES += ENABLE_MYSQL
DEFINES += TCP_FASTOPEN
#DEFINES += TCP_FASTOPEN_CONNECT
DEFINES += ENABLE_SSL_KEYLOG
#DEFINES += ENABLE_NAT
DEFINES += ENABLE_TLS13_CIPHERSUITES
#DEFINES += ENABLE_REUSE_PORT

# Privoxy
DEFINES += FEATURE_GRACEFUL_TERMINATION

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

win32 {
    SOURCES += \
        src/sysproxy/windows.c
    HEADERS += \
        src/sysproxy/windows.h
    INCLUDEPATH += $$PWD\src\trojan\src
    INCLUDEPATH += C:\TQLibraries\ZBar\include
    INCLUDEPATH += C:\TQLibraries\boost_1_72_0
    INCLUDEPATH += C:\TQLibraries\OpenSSL-Win32\include
    INCLUDEPATH += C:\TQLibraries\QREncode\include
    LIBS += -LC:\TQLibraries\ZBar\lib -llibzbar-0
    LIBS += -LC:\TQLibraries\OpenSSL-Win32\lib -llibcrypto -llibssl
    LIBS += -LC:\TQLibraries\boost_1_72_0\lib32-msvc-14.1
    LIBS += -LC:\TQLibraries\boost_1_72_0\lib32-msvc-14.2
    LIBS += -LC:\TQLibraries\QREncode\lib -lqrcodelib
    LIBS += -lwsock32 -lws2_32
    LIBS += -lCrypt32
    DEFINES += WIN32_LEAN_AND_MEAN
    # Otherwise lupdate will not work
    TR_EXCLUDE += C:\TQLibraries\boost_1_72_0\*
}

mac {
    INCLUDEPATH += $$PWD/src/trojan/src
    INCLUDEPATH += /usr/local/opt/zbar/include
    INCLUDEPATH += /usr/local/opt/qrencode/include
    INCLUDEPATH += /usr/local/opt/openssl@1.1/include
    INCLUDEPATH += /usr/local/opt/boost/include
    INCLUDEPATH += /usr/local/opt/pcre/include
    INCLUDEPATH += /usr/local/opt/zlib/include
    LIBS += -L/usr/local/opt/zbar/lib -lzbar
    LIBS += -L/usr/local/opt/qrencode/lib -lqrencode
    LIBS += -L/usr/local/opt/openssl@1.1/lib -lcrypto -lssl
    LIBS += -L/usr/local/opt/boost/lib -lboost_system
    LIBS += -L/usr/local/opt/zlib/lib -lz
    LIBS += -L/usr/local/opt/pcre/lib -lpcre
    LIBS += -framework Security -framework Cocoa
    # Otherwise lupdate will not work
    TR_EXCLUDE += /usr/local/opt/boost/*
}

unix:!mac {
    QT += dbus
    INCLUDEPATH += $$PWD/src/trojan/src
    INCLUDEPATH += /usr/local/zbar/include
    INCLUDEPATH += /usr/local/qrencode/include
    INCLUDEPATH += /usr/local/openssl/include
    INCLUDEPATH += /usr/local/boost/include
    INCLUDEPATH += /usr/local/pcre/include
    INCLUDEPATH += /usr/local/zlib/include
    LIBS += -L/usr/local/zbar/lib -lzbar
    LIBS += -L/usr/local/qrencode/lib -lqrencode
    LIBS += -L/usr/local/openssl/lib -lcrypto -lssl
    LIBS += -L/usr/local/boost/lib -lboost_system
    LIBS += -L/usr/local/zlib/lib -lz
    LIBS += -L/usr/local/pcre/lib -lpcre
    # Otherwise lupdate will not work
    TR_EXCLUDE += /usr/local/boost/*

    isEmpty(PREFIX) {
        PREFIX = /usr/local
    }

    target.path = $$PREFIX/bin
    shortcutfiles.files = src/trojan-qt5.desktop
    shortcutfiles.path = $$PREFIX/share/applications/
    data.files += icons/trojan-qt5.png
    data.path = $$PREFIX/share/hicolor/512x512/trojan-qt5.png

    INSTALLS += shortcutfiles
    INSTALLS += data
}

unix {
    SOURCES += \
        src/privoxy/list.c \
        src/privoxy/pcrs.c \
        src/privoxy/miscutil.c \
        src/privoxy/fuzz.c \
        src/privoxy/parsers.c \
        src/privoxy/loadcfg.c \
        src/privoxy/filters.c \
        src/privoxy/cgi.c \
        src/privoxy/loaders.c \
        src/privoxy/encode.c \
        src/privoxy/errlog.c \
        src/privoxy/gateway.c \
        src/privoxy/actions.c \
        src/privoxy/urlmatch.c \
        src/privoxy/jcc.c \
        src/privoxy/deanimate.c \
        src/privoxy/cgisimple.c \
        src/privoxy/cgiedit.c \
        src/privoxy/client-tags.c \
        src/privoxy/jbsockets.c \
        src/privoxy/ssplit.c

    HEADERS += \
        src/privoxy/actionlist.h \
        src/privoxy/urlmatch.h \
        src/privoxy/jcc.h \
        src/privoxy/actions.h \
        src/privoxy/gateway.h \
        src/privoxy/acconfig.h \
        src/privoxy/cygwin.h \
        src/privoxy/strptime.h \
        src/privoxy/deanimate.h \
        src/privoxy/client-tags.h \
        src/privoxy/jbsockets.h \
        src/privoxy/ssplit.h \
        src/privoxy/cgiedit.h \
        src/privoxy/cgisimple.h \
        src/privoxy/pcrs.h \
        src/privoxy/list.h \
        src/privoxy/miscutil.h \
        src/privoxy/project.h \
        src/privoxy/parsers.h \
        src/privoxy/errlog.h \
        src/privoxy/encode.h \
        src/privoxy/loaders.h \
        src/privoxy/cgi.h \
        src/privoxy/filters.h \
        src/privoxy/loadcfg.h \
        src/privoxy/config.h
}

!isEmpty(target.path): INSTALLS += target

SOURCES += \
    src/pacserver.cpp \
    src/privoxythread.cpp \
    src/resourcehelper.cpp \
    src/servicethread.cpp \
    src/addresstester.cpp \
    src/confighelper.cpp \
    src/connection.cpp \
    src/connectionitem.cpp \
    src/connectiontablemodel.cpp \
    src/editdialog.cpp \
    src/ip4validator.cpp \
    src/main.cpp \
    src/mainwindow.cpp \
    src/portvalidator.cpp \
    src/qrcodecapturer.cpp \
    src/qrwidget.cpp \
    src/settingsdialog.cpp \
    src/sharedialog.cpp \
    src/systemproxyhelper.cpp \
    src/tqprofile.cpp \
    src/statusnotifier.cpp \
    src/trojanvalidator.cpp \
    src/urihelper.cpp \
    src/uriinputdialog.cpp \
    src/trojan/src/core/authenticator.cpp \
    src/trojan/src/core/config.cpp \
    src/trojan/src/core/log.cpp \
    src/trojan/src/core/service.cpp \
    src/trojan/src/core/version.cpp \
    src/trojan/src/proto/socks5address.cpp \
    src/trojan/src/proto/trojanrequest.cpp \
    src/trojan/src/proto/udppacket.cpp \
    src/trojan/src/session/clientsession.cpp \
    src/trojan/src/session/forwardsession.cpp \
    src/trojan/src/session/natsession.cpp \
    src/trojan/src/session/serversession.cpp \
    src/trojan/src/session/session.cpp \
    src/trojan/src/session/udpforwardsession.cpp \
    src/trojan/src/ssl/ssldefaults.cpp \
    src/trojan/src/ssl/sslsession.cpp

HEADERS += \
    src/pacserver.h \
    src/privoxythread.h \
    src/resourcehelper.h \
    src/servicethread.h \
    src/addresstester.h \
    src/confighelper.h \
    src/connection.h \
    src/connectionitem.h \
    src/connectiontablemodel.h \
    src/editdialog.h \
    src/ip4validator.h \
    src/mainwindow.h \
    src/portvalidator.h \
    src/qrcodecapturer.h \
    src/qrwidget.h \
    src/settingsdialog.h \
    src/sharedialog.h \
    src/systemproxyhelper.h \
    src/tqprofile.h \
    src/statusnotifier.h \
    src/trojanvalidator.h \
    src/urihelper.h \
    src/uriinputdialog.h \
    src/trojan/src/core/authenticator.h \
    src/trojan/src/core/config.h \
    src/trojan/src/core/log.h \
    src/trojan/src/core/service.h \
    src/trojan/src/core/version.h \
    src/trojan/src/proto/socks5address.h \
    src/trojan/src/proto/trojanrequest.h \
    src/trojan/src/proto/udppacket.h \
    src/trojan/src/session/clientsession.h \
    src/trojan/src/session/forwardsession.h \
    src/trojan/src/session/natsession.h \
    src/trojan/src/session/serversession.h \
    src/trojan/src/session/session.h \
    src/trojan/src/session/udpforwardsession.h \
    src/trojan/src/ssl/ssldefaults.h \
    src/trojan/src/ssl/sslsession.h \

FORMS += \
    ui/editdialog.ui \
    ui/mainwindow.ui \
    ui/settingsdialog.ui \
    ui/sharedialog.ui \
    ui/uriinputdialog.ui

TRANSLATIONS += \
    i18n/trojan-qt5_zh_CN.ts \
    i18n/trojan-qt5_zh_TW.ts

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin

RESOURCES += \
    resources/bin.qrc \
    resources/icons.qrc \
    resources/pac.qrc \
    resources/translations.qrc
