#ifdef QT_QML_DEBUG
#include <QtQuick>
#include "requst.h"
#endif

#include <sailfishapp.h>

int main(int argc, char *argv[])
{
    qmlRegisterType<Request>("Request", 1, 0, "Request");

    return SailfishApp::main(argc, argv);
}
