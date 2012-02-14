#include <QtGui/QApplication>
#include <QtDeclarative>
#include "qmlapplicationviewer.h"
#include "downloader.h"

/*
void myMessageOutput(QtMsgType type, const char *msg)
{
    //QFile file("C:/data/out.txt");
    QFile file("/home/user/out.txt");
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text))
        return;

    QTextStream out(&file);
    out << "The magic number is: " << 49 << "\n";

    switch (type) {
    case QtDebugMsg:
        out << msg << "\n";
        fprintf(stderr, "Debug: %s\n", msg);
        break;
    case QtWarningMsg:
        out << msg << "\n";
        fprintf(stderr, "Warning: %s\n", msg);
        break;
    case QtCriticalMsg:
        out << msg << "\n";
        fprintf(stderr, "Critical: %s\n", msg);
        break;
    case QtFatalMsg:
        out << msg << "\n";
        fprintf(stderr, "Fatal: %s\n", msg);
        abort();
    }
}

*/

Q_DECL_EXPORT int main(int argc, char *argv[])
{
//     qInstallMsgHandler(myMessageOutput);
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

#if defined(Q_WS_MAEMO_5)
    viewer->engine()->addImportPath(QLatin1String("/opt/qtm12/imports"));
    viewer->engine()->addPluginPath(QLatin1String("/opt/qtm12/plugins"));
#endif


    qmlRegisterType<Downloader>("cz.vutbr.fit.pcmlich", 1, 0, "Downloader");

    viewer->setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer->setMainQmlFile(QLatin1String("qml/wis/main.qml"));
    viewer->showExpanded();

    return app->exec();
}
