#include <QtGui/QApplication>
#include <QtDeclarative>
#include "qmlapplicationviewer.h"
#include "downloader.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{

    QScopedPointer<QApplication> app(createApplication(argc, argv));

    QString locale = "cs_CZ"; //QLocale::system().name();
    QTranslator *translator = new QTranslator();

    if (translator->load("wis_" + locale, ":/")) {
      app->installTranslator(translator);
      qDebug() << "installing translations";
    }


    QTextCodec::setCodecForCStrings(QTextCodec::codecForName("UTF-8"));
    QTextCodec::setCodecForLocale(QTextCodec::codecForName("UTF-8"));
    QTextCodec::setCodecForTr(QTextCodec::codecForName("UTF-8"));

    QScopedPointer<QmlApplicationViewer> viewer(QmlApplicationViewer::create());




    qmlRegisterType<Downloader>("cz.vutbr.fit.pcmlich", 1, 0, "Downloader");

    viewer->setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer->setMainQmlFile(QLatin1String("qml/wis/main.qml"));
    viewer->showExpanded();

    return app->exec();
}
