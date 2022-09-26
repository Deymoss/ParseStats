#ifndef DATAPARSER_H
#define DATAPARSER_H

#include <QObject>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QNetworkAccessManager>
#include <QString>
#include <QUrl>
#include <QDebug>
#include <QVector>
#include <QRegularExpression>

class DataParser : public QObject
{
    Q_OBJECT
public:
    DataParser(QObject *parent = nullptr);
    void requestFunc(int date);
    ~DataParser();
private:
    QNetworkAccessManager *m_networkManager = nullptr;
    QNetworkRequest       *m_networkRequest = nullptr;
    QString m_domain;
    QString m_request;
    QString data;
    QString pmRequestLink;
    QUrl url;
    QVector<QString> colors;
    int page=12;
    void requestFunc(int date, int page);
    QString formingCorrectLink(QString request);
private slots:
    void replyFinished(QNetworkReply *reply);
};

#endif // DATAPARSER_H
