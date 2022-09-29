#ifndef DATAPARSER_H
#define DATAPARSER_H

#include <QObject>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QNetworkAccessManager>
#include <QString>
#include <QUrl>
#include <QDate>
#include <QDebug>
#include <QVector>
#include <QJsonDocument>
#include <QtConcurrent>
#include <QFuture>
#include <QJsonObject>
#include <QJsonArray>
#include <QRegularExpression>

class DataParser : public QObject
{
    Q_OBJECT
public:
    DataParser(QObject *parent = nullptr);
    void requestFunc(int date);
    Q_INVOKABLE void takeData(const int amount);
    ~DataParser();
private:
    QNetworkAccessManager *m_networkManager = nullptr;
    QNetworkRequest       *m_networkRequest = nullptr;
    QString m_domain;
    QString m_request;
    QString data;
    QString pmRequestLink;
    QUrl url;
    QDate date = QDate::currentDate();
    QVector<QString> colors;
    int currentAmount = 0;
    int amount = 0;
    int page=100; // set 100 for check last page
    QString formingCorrectLink(QString request);
    QVariantList parseData();
private slots:
    void replyFinished(QNetworkReply *reply);
signals:
    void sendData(QVariantList data);
};

#endif // DATAPARSER_H
