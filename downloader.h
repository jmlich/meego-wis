#ifndef DOWNLOADER_H
#define DOWNLOADER_H

#include <QtNetwork>
#include <QDebug>
#include <QObject>
#include <QSettings>

class Downloader : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString login READ getLogin WRITE setLogin NOTIFY loginChanged)
    Q_PROPERTY(QString password READ getPassword WRITE setPassword NOTIFY passwordChanged)
    Q_PROPERTY(QString response READ getResponse NOTIFY downloadFinished)
    Q_PROPERTY(QString errorMessage READ getErrorMessage NOTIFY errorOccured)


public:
    explicit Downloader(QObject *parent = 0);
    ~Downloader();

    void setLogin(QString _login) {
        m_login = _login;
        config->setValue("login", m_login);
        emit loginChanged();
    }
    QString getLogin() { return m_login; }
    void setPassword(QString _password) {
        m_password = _password;
        config->setValue("password", m_password);
        emit passwordChanged();
    }

    QString getErrorMessage() { return m_errorMessage; }

    QString getPassword() { return m_password; }

    QString getResponse() { return m_response; }

    Q_INVOKABLE void reload();


signals:
    void loginChanged();
    void passwordChanged();
    void errorOccured();

    void downloadFinished();
    void downloadStarted();


public slots:
    void finished(QNetworkReply *reply);
    void slotError(QNetworkReply::NetworkError);
    void slotSslErrors(QList<QSslError>);


private:
    QSettings* config;
    QString m_login;
    QString m_password;
    QString m_response;
    QString m_errorMessage;

    QNetworkAccessManager *manager;

};

#endif // DOWNLOADER_H
