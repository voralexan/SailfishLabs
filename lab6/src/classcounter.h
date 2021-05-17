#ifndef CLASSCOUNTER_H
#define CLASSCOUNTER_H

#include <QObject>

class ClassCounter : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int count READ getCount WRITE setCount NOTIFY mySignal)
private:
    int count;
public:
    ClassCounter();
    Q_INVOKABLE void add();
    Q_INVOKABLE void reset();
    Q_INVOKABLE int getCount();
    Q_INVOKABLE void setCount(int Count);
signals:
    void mySignal();
};

#endif // CLASSCOUNTER_H
