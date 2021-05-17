#ifndef CLASSSTRING_H
#define CLASSSTRING_H

#include <QObject>
#include<QVector>

class ClassString : public QObject
{
    Q_OBJECT
private:
    QVector<QString> list;
public:
    Q_INVOKABLE void push(QString str);
    Q_INVOKABLE void pop();
    Q_INVOKABLE QString getList();
signals:
    void mySignal();
};

#endif // CLASSSTRING_H
