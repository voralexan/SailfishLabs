#ifdef QT_QML_DEBUG
#include "classcounter.h"
#include "classstring.h"
#include <QtQuick>
#endif

#include <sailfishapp.h>

int main(int argc, char *argv[])
{
    QObject *obj = new ClassCounter;
    ClassCounter *counter = qobject_cast<ClassCounter *>(obj);
    qDebug() << counter->getCount();
    counter->add();
    qDebug() << counter->getCount();
    counter->add();
    qDebug() << counter->getCount();
    counter->reset();
    qDebug() << counter->getCount();

    qmlRegisterType<ClassCounter>("ClassCounter", 1, 0, "ClassCounter");
    qmlRegisterType<ClassString>("ClassString", 1, 0, "ClassString");

    return SailfishApp::main(argc, argv);
}
