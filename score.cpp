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

int Score::incrementScoreIndex() {
    setScoreIndex(m_scoreIndex + 1);
    return m_scoreIndex;
}

QString Score::scoreString(int index) const {
    if(index < 0) return getScoreList().at(0);

    return getScoreList().at(index);
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

void Score::reset() {
    m_scoreIndex = 0;
    emit scoreReset();
}
