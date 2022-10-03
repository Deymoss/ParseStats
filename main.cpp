#include <QApplication>
#include <QQmlApplicationEngine>
#include <dataparser.h>


int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    qmlRegisterType<DataParser>("com.myself", 1, 0, "Provider");
    qmlRegisterSingletonType(QUrl("qrc:/ParseData/Style.qml"), "Style", 1, 0, "Style");
    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/ParseData/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
