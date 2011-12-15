#include "downloader.h"
#include <QSettings>

Downloader::Downloader(QObject *parent) :
    QObject(parent)
{
    config = new QSettings("cz.vutbr.fit.pcmlich", "wis");
    m_login = config->value("login", "").toString();
    m_password = config->value("password", "").toString();
    emit loginChanged();
    emit passwordChanged();

    manager = new QNetworkAccessManager();
    connect (manager, SIGNAL(finished(QNetworkReply*)), this, SLOT(finished(QNetworkReply*)));
}

void Downloader::reload() {
    m_errorMessage = tr("");
    emit errorOccured();
    emit downloadStarted();

    QNetworkRequest  request;
#if 0
    int ran = random()%3;
    switch (ran) {
    case 0: request.setUrl(QUrl("http://pcmlich.fit.vutbr.cz/tmp/w/c.xml")); break;
    case 1: request.setUrl(QUrl("http://pcmlich.fit.vutbr.cz/tmp/w/d.xml")); break;
    case 2: request.setUrl(QUrl("https://wis.fit.vutbr.cz/FIT/st/get-courses.php")); break;
    }
#else
    request.setUrl(QUrl("https://wis.fit.vutbr.cz/FIT/st/get-courses.php"));
#endif
    QString concatenated = m_login + ":" + m_password;
    QByteArray data = concatenated.toLocal8Bit().toBase64();
    QString headerData = "Basic " + data;
    request.setRawHeader("Authorization", headerData.toLocal8Bit());


    QNetworkReply *reply = manager->get(request);
    reply->ignoreSslErrors();
    connect(reply, SIGNAL(error(QNetworkReply::NetworkError)), this, SLOT(slotError(QNetworkReply::NetworkError)));

    connect(reply, SIGNAL(sslErrors(QList<QSslError>)), this, SLOT(slotSslErrors(QList<QSslError>)));

}

void Downloader::finished(QNetworkReply *reply) {
    if (reply->error() != QNetworkReply::NoError) {
        qDebug() << reply->errorString();
    }

    m_response = reply->readAll();
    emit downloadFinished();
}



Downloader::~Downloader() {
    delete config;
}

void Downloader::slotError(QNetworkReply::NetworkError e) {
    switch(e) {
    case QNetworkReply::NoError: m_errorMessage = tr(""); break;
    case QNetworkReply::ConnectionRefusedError: m_errorMessage = tr("Connection Refused"); break;
    case QNetworkReply::RemoteHostClosedError: m_errorMessage = tr("Remote Host Closed"); break;
    case QNetworkReply::HostNotFoundError: m_errorMessage = tr("Host Not Found"); break;
    case QNetworkReply::TimeoutError: m_errorMessage = tr("Timeout"); break;
    case QNetworkReply::OperationCanceledError: m_errorMessage = tr("Operation Canceled"); break;
    case QNetworkReply::SslHandshakeFailedError: m_errorMessage = tr("Ssl Handshake Failed"); break;
    case QNetworkReply::TemporaryNetworkFailureError: m_errorMessage = tr("Temporary Network Failure"); break;
    case QNetworkReply::ProxyConnectionRefusedError: m_errorMessage = tr("Proxy Connection Refused"); break;
    case QNetworkReply::ProxyConnectionClosedError: m_errorMessage = tr("Proxy Connection Closed"); break;
    case QNetworkReply::ProxyNotFoundError: m_errorMessage = tr("Proxy Not Found"); break;
    case QNetworkReply::ProxyTimeoutError: m_errorMessage = tr("Proxy Timeout"); break;
    case QNetworkReply::ProxyAuthenticationRequiredError: m_errorMessage = tr("Proxy Authentication Required"); break;
    case QNetworkReply::ContentAccessDenied: m_errorMessage = tr("Access Denied"); break;
    case QNetworkReply::ContentOperationNotPermittedError: m_errorMessage = tr("Operation Not Permitted"); break;
    case QNetworkReply::ContentNotFoundError: m_errorMessage = tr("Not Found"); break;
    case QNetworkReply::AuthenticationRequiredError: m_errorMessage = tr("Authentication Required"); break;
    case QNetworkReply::ContentReSendError: m_errorMessage = tr("Content Re Send"); break;
    case QNetworkReply::ProtocolUnknownError: m_errorMessage = tr("Unknown protocol"); break;
    case QNetworkReply::ProtocolInvalidOperationError: m_errorMessage = tr("Invalid Operation"); break;
    case QNetworkReply::UnknownNetworkError: m_errorMessage = tr("Unknown Network Error"); break;
    case QNetworkReply::UnknownProxyError: m_errorMessage = tr("Unknown Proxy Error"); break;
    case QNetworkReply::UnknownContentError: m_errorMessage = tr("Unknown Content Error"); break;
    case QNetworkReply::ProtocolFailure: m_errorMessage = tr("Protocol Failure"); break;

    }

    emit errorOccured();


}

void Downloader::slotSslErrors(QList<QSslError>) {
    // FIXME
}
