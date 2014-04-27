#include "score.h"

Score::Score(QObject *parent) :
    QObject(parent)
{
    m_scoreIndex = 0;
    m_scoreString = "";
}
