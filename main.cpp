#include <QtGui/QGuiApplication>
#include <QQmlComponent>
#include "qtquick2applicationviewer.h"
#include "game.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<Game>();

    QtQuick2ApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/sheep/main.qml"));
    viewer.setTitle("Sheep It!");
    viewer.showMaximized();

    return app.exec();
}
