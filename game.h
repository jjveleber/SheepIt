#ifndef GAME_H
#define GAME_H

#include <QObject>
#include "score.h"

class Game : public QObject
{
    Q_OBJECT
    Q_PROPERTY(Score *yourScore MEMBER m_yourScore NOTIFY yourScoreChanged)
    Q_PROPERTY(Score *highScore MEMBER m_highScore NOTIFY highScoreChanged)
public:
    explicit Game(QObject *parent = 0);

signals:
    void yourScoreChanged();
    void highScoreChanged();

public slots:
    void playTimeout();
private:
    Score *m_yourScore;
    Score *m_highScore;
    QString twinPrimes[100000];

};

#endif // GAME_H
