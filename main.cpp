#include <QtGui/QGuiApplication>
#include <QQmlComponent>
#include <QFont>
#include <QFontDatabase>
#include "qtquick2applicationviewer.h"
#include "game.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

//    QFontDatabase fontDB;
//    fontDB.addApplicationFont(":/fonts/myfont");
//    QFont font("Hotel Coral Essex");
//    app.setFont(font);

    qmlRegisterType<Game>("Game", 1,0, "Game");
    qmlRegisterType<Score>("Score", 1,0, "Score");

    QtQuick2ApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/sheep/main.qml"));
    viewer.setTitle("Sheep It!");
    viewer.showNormal();

    return app.exec();
}
