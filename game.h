#ifndef GAME_H
#define GAME_H

#include <QObject>
#include "score.h"

class Game : public QObject
{
    Q_OBJECT
    Q_PROPERTY(Score *yourScore READ yourScore CONSTANT)
    Q_PROPERTY(Score *highScore READ highScore CONSTANT)

public:
    Game(QObject *parent = 0);
    Score *yourScore();
    Score *highScore();
signals:


public slots:
    void playTimeout();
private:
    Score m_yourScore;
    Score m_highScore;
    QString twinPrimes[100000];

};

#endif // GAME_H
