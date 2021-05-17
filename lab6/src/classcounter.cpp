#include "classcounter.h"

ClassCounter::ClassCounter() : QObject() {
    count = 0;
}
Q_INVOKABLE void ClassCounter::add() {
    count++;
    emit mySignal();
}
Q_INVOKABLE void ClassCounter::reset() {
    count = 0;
    emit mySignal();
}
Q_INVOKABLE int ClassCounter::getCount() {
   return count;
}
Q_INVOKABLE void ClassCounter::setCount(int Count) {
    count = Count;
}
