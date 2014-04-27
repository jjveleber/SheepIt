#include "score.h"

Score::Score(QObject *parent) :
    QObject(parent), m_scoreIndex(0), m_scoreString(QString(""))
{
}

int Score::scoreIndex() const {
    return m_scoreIndex;
}

void Score::setScoreIndex(const int &value) {
    m_scoreIndex = value;
}

QString Score::scoreString() const {
    return m_scoreString;
}
