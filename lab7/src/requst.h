#ifndef CLASS1_H
#define CLASS1_H
#include <QObject>
#include <QNetworkAccessManager>
#include <QUrl>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QImageReader>
#include <QBuffer>
#include <QJsonDocument>
#include <QJsonObject>
#include <unistd.h>

class Request: public QObject
{
    Q_OBJECT
private:
    QString respond;
    QImage image;
public:
    Request();
    Q_INVOKABLE void sendGetRequest() {
        QNetworkAccessManager * manager = new QNetworkAccessManager(this);
        QNetworkReply *reply = manager->get(QNetworkRequest(QUrl("http://httpbin.org/ip")));
        connect(reply, SIGNAL(finished()), this, SLOT(getReplyFinished()));
    }

    Q_INVOKABLE void sendPostRequest(QString body) {
        QNetworkAccessManager * manager = new QNetworkAccessManager(this);
        QByteArray postBody;
        postBody.append(body);
        QNetworkReply *reply = manager->post(QNetworkRequest(QUrl("http://httpbin.org/post")), postBody);
        connect(reply, SIGNAL(finished()), this, SLOT(postReplyFinished()));
    }

    Q_INVOKABLE void sendImageRequest() {
        QNetworkAccessManager * manager = new QNetworkAccessManager(this);
        QNetworkReply *reply = manager->get(QNetworkRequest(QUrl("http://httpbin.org/image/png")));
        connect(reply, SIGNAL(finished()), this, SLOT(ImageReplyFinished()));
    }

    Q_INVOKABLE void sendPutRequest(QString body) {
        QNetworkAccessManager * manager = new QNetworkAccessManager(this);
        QByteArray putBody;
        putBody.append(body);
        QNetworkReply *reply = manager->put(QNetworkRequest(QUrl("http://httpbin.org/put")), putBody);
        connect(reply, SIGNAL(finished()), this, SLOT(putReplyFinished()));
    }

    Q_INVOKABLE QString getRespond() {
        return respond;
    }

    Q_INVOKABLE QString getImage() {
        QByteArray bArray;
        QBuffer buffer(&bArray);
        buffer.open(QIODevice::WriteOnly);
        image.save(&buffer, "PNG");

        QString imagePath("data:image/png;base64,");
        imagePath.append(QString::fromLatin1(bArray.toBase64().data()));

        return imagePath;
    }

    void setRespond(QString str) {respond = str; }
    void setImage(QImage img) {image = img; }
public slots:
    void getReplyFinished() {
        QNetworkReply *reply = qobject_cast<QNetworkReply*>(sender());
        if(reply->error() == QNetworkReply::NoError) {
            QJsonDocument jsonDoc = QJsonDocument::fromJson(reply->readAll());
            QJsonObject json = jsonDoc.object();
            respond = json["origin"].toString();
            qDebug() << respond;
            emit respondChanged();
        }
    }
    void postReplyFinished() {
        QNetworkReply *reply = qobject_cast<QNetworkReply*>(sender());
        if(reply->error() == QNetworkReply::NoError) {
            QJsonDocument jsonDoc = QJsonDocument::fromJson(reply->readAll());
            respond = jsonDoc.toJson(QJsonDocument::Indented);
            qDebug() << respond;
            emit respondChanged();
        }
    }
    void ImageReplyFinished() {
        QNetworkReply *reply = qobject_cast<QNetworkReply*>(sender());
        if(reply->error() == QNetworkReply::NoError) {
            QImageReader imageReader(reply);
            imageReader.setFormat("png");
            image = imageReader.read();
            emit imageChanged();
        }
    }
    void putReplyFinished() {
        QNetworkReply *reply = qobject_cast<QNetworkReply*>(sender());
        if(reply->error() == QNetworkReply::NoError) {
            QJsonDocument jsonDoc = QJsonDocument::fromJson(reply->readAll());
            QJsonObject json = jsonDoc.object();
            respond = json["form"].toString();
            qDebug() << json["form"].toString();
            emit respondChanged();
        }
    }
signals:
    void respondChanged();
    void imageChanged();
};

#endif // REQUEST_H
