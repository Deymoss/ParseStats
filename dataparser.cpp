#include "dataparser.h"

DataParser::DataParser(QObject *parent) : QObject(parent)
{
    m_networkManager = new QNetworkAccessManager(this);
    m_networkRequest = new QNetworkRequest;
    connect(m_networkManager, SIGNAL(finished(QNetworkReply*)),
            this, SLOT(replyFinished(QNetworkReply*)));
}



void DataParser::requestFunc(int date)
{
    pmRequestLink = "https://parimatch.betgames.tv/s/web/v1/game/results/parimatchby?game_id=8&page=1&date=2022-09-26&timezone=3";
    //    checkNextPage++;
    url.setUrl(pmRequestLink);
    m_networkRequest->setUrl(url);
    page++;
    m_networkManager->get(*m_networkRequest);
}

void DataParser::replyFinished(QNetworkReply *reply)
{
    data = reply->readAll();
    qDebug()<<data;
    QRegularExpression urlRegExp("\"run_time\":\"(.+) (.+)\"");
    auto it = urlRegExp.globalMatch(data);
    while( it.hasNext() ) {
        auto match = it.next();
        qDebug() << match.captured( 0 ) << ":" << match.captured( 1 );
    }
    qDebug()<<colors;
    QString Output;
}
DataParser::~DataParser()
{
    delete m_networkRequest;
}
