#include "dataparser.h"

DataParser::DataParser(QObject *parent)
    : QObject(parent)
    , m_networkManager(new QNetworkAccessManager(this))
    , m_networkRequest(new QNetworkRequest)
{
    connect(m_networkManager.data(),
            &QNetworkAccessManager::finished,
            this,
            &DataParser::replyFinished);
    stats.reserve(20);
}

void DataParser::takeData(const int amount)
{
    this->amount = amount;
    pmRequestLink
        = "https://parimatch.betgames.tv/s/web/v1/game/results/parimatchby?game_id=8&page="
          + QString::number(page) + "&date=2022-" + QString::number(date.month()) + "-"
          + QString::number(date.day()) + "&timezone=3";
    url.setUrl(pmRequestLink);
    m_networkRequest->setUrl(url);
    page != 1 ? page-- : page = 0;
    m_networkManager->get(*m_networkRequest);
}

QVector<int> DataParser::takeStats()
{
    return stats;
}

QString DataParser::subDate()
{
    date = date.addDays(-1);
    return date.toString("dd.MM.yyyy");
}

QString DataParser::addDate()
{
    date = date.addDays(1);
    return date.toString("dd.MM.yyyy");
}

QString DataParser::currentDate()
{
    return date.toString("dd.MM.yyyy");
}

void DataParser::replyFinished(QNetworkReply *reply)
{
    data = reply->readAll();
    QJsonDocument d = QJsonDocument::fromJson(data.toUtf8()); //data to JsonDocument
    QJsonObject sett2 = d.object();
    if (page > sett2["pages"].toInt()) {
        page = sett2["pages"].toInt();
        takeData(amount);
    } else if (page == 0) {
        date = date.addDays(-1);
        page = 100;
        takeData(amount);
    } else {
        QFuture<QVariantList> dataGrabber = QtConcurrent::run(&DataParser::parseData, this);

        dataGrabber.waitForFinished();
        QList result = dataGrabber.result().toList();
        emit sendData(dataGrabber.result());
        for (QVariant &a : result) {
            if (lastResult == a.toBool()) {
                ++counter;
            } else {
                stats[counter] += 1;
                counter = 1;
            }
            lastResult = a.toBool();
        }
        if (currentAmount <= amount) {
            takeData(amount);
        } else {
            emit endOfProcess();
        }
    }
}
DataParser::~DataParser() {}

QVariantList DataParser::parseData()
{
    QVariantList results;
    QJsonDocument d = QJsonDocument::fromJson(data.toUtf8()); //data to JsonDocument
    QJsonObject sett2 = d.object();                           // take object from document
    QJsonArray array = sett2["runs"].toArray();               // take array of runs
    for (qsizetype i = array.size(); i != 0; i--) {
        QJsonValue val = array.at(i); // take element of array (0,1,2 runs)
        QJsonObject loopObj = val.toObject();
        QJsonObject resultsObj = loopObj["results"].toObject(); //take nested json results
        if (resultsObj["player"].toString().contains('d')
            || resultsObj["player"].toString().contains('h')) {
            results.push_back(true);
        } else {
            results.push_back(false);
        }
        if (resultsObj["dealer"].toString().contains('d')
            || resultsObj["dealer"].toString().contains('h')) {
            results.push_back(true);
        } else {
            results.push_back(false);
        }
    }

    currentAmount += array.size() * 2;
    //qDebug()<<currentAmount;
    return results;
}
