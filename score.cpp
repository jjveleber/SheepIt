#include "score.h"
#include <QDebug>
#include <QFile>
#include <QTextStream>

Score::Score(QObject *parent) :
    QObject(parent), m_scoreIndex(0)
{
}

int Score::scoreIndex() const {
    return m_scoreIndex;
}

void Score::setScoreIndex(const int &value) {
    if(value == m_scoreIndex) return;

    m_scoreIndex = value;
    emit scoreChanged();
}

QString Score::scoreString() const {
    return getScoreList().at(m_scoreIndex);
}

QString Score::nextScoreString() const {
    if(getScoreList().size() >= m_scoreIndex + 1) {
        return getScoreList().at(m_scoreIndex + 1);
    } else {
        return "SuX";//scoreString(); // This is cheap, but I don't expect people to get to level 100K
    }
}

QStringList Score::getScoreList() {
    static QStringList instance;
    if(instance.size() == 0) {
        QFile data(":/data/TwinPrimes");
        if (data.open(QFile::ReadOnly)) {
            QTextStream stream(&data);
            QString line;
            do {
                line = stream.readLine();
                if(!line.isEmpty()) {
                    instance.append(line);
                }
            } while (!line.isNull());
        }
    }
    return instance;
}
