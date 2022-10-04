cmake_minimum_required(VERSION 3.16)

project(ParseData VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 6.4 COMPONENTS Quick Core Network Concurrent Charts REQUIRED)

qt_add_executable(appParseData
    main.cpp
    dataparser.h
    dataparser.cpp
    resources.qrc
)

qt_add_qml_module(appParseData
    URI ParseData
    VERSION 1.0
    QML_FILES main.qml DataGrid.qml ChartStatistics.qml Style.qml StatisticsPage.qml
)
set_target_properties(appParseData PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appParseData
    PRIVATE Qt6::Quick Qt${QT_VERSION_MAJOR}::Concurrent Qt${QT_VERSION_MAJOR}::Charts)

install(TARGETS appParseData
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
