#include "classstring.h"


Q_INVOKABLE void ClassString::push(QString str){
    if (str == "") return;
    list.push_back(str.toLower());
    emit mySignal();
}
Q_INVOKABLE void ClassString::pop(){
    if (list.empty()) return;
    list.pop_back();
    emit mySignal();
}
Q_INVOKABLE QString ClassString::getList(){
    QString res;
    if(list.empty()) return res;
    for(int i = 0; i < list.count() - 1; i++) {
        res += list[i];
        res += ", ";
    }
    res += list[list.count() - 1];
    return res;
}

