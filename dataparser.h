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
    Q_INVOKABLE QVector<int> takeStats();
    Q_INVOKABLE QString subDate();
    Q_INVOKABLE QString addDate();
    Q_INVOKABLE QString currentDate();
    ~DataParser();
private:
    QScopedPointer<QNetworkAccessManager> m_networkManager;
    QScopedPointer<QNetworkRequest> m_networkRequest;
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
    QVector<int> stats = QVector<int>(20);
    int counter = 1;
    bool lastResult = true;
    QVariantList parseData();
private slots:
    void replyFinished(QNetworkReply *reply);
signals:
    void sendData(QVariantList data);
    void endOfProcess();
    void connectionError();
};

#endif // DATAPARSER_H
