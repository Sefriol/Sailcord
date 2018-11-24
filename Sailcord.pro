# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = Sailcord

CONFIG += sailfishapp

SOURCES += src/Sailcord.cpp

DISTFILES += qml/Sailcord.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/SecondPage.qml \
    rpm/Sailcord.changes.in \
    rpm/Sailcord.changes.run.in \
    rpm/Sailcord.spec \
    rpm/Sailcord.yaml \
    translations/*.ts \
    Sailcord.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/Sailcord-de.ts

# Required 3rd party libraries for Discord to work. Not made by me
# Discord.py https://discordpy.readthedocs.io/en/latest
discord.path = /usr/share/$${TARGET}
discord.files = res/discord

# websockets-3.4
websockets.path = /usr/share/$${TARGET}
websockets.files = res/websockets

# aiohttp-1.0.5
aiohttp.path = /usr/share/$${TARGET}
aiohttp.files = res/aiohttp

# multidict
multidict.path = /usr/share/$${TARGET}
multidict.files = res/multidict

# async-timeout-2.0.1
async_timeout.path = /usr/share/$${TARGET}
async_timeout.files = res/async_timeout

# chardet-3.0.4
chardet.path = /usr/share/$${TARGET}
chardet.files = res/chardet

INSTALLS += discord websockets aiohttp multidict async_timeout chardet
