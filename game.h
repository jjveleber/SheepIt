#ifndef GAME_H
#define GAME_H

#include <QObject>
#include <QList>
#include "score.h"

class Game : public QObject
{
    Q_OBJECT
    Q_PROPERTY(Score *yourScore READ yourScore CONSTANT)
    Q_PROPERTY(Score *highScore READ highScore CONSTANT)
    Q_PROPERTY(int playBackPosition READ playBackPosition NOTIFY playBackPositionChanged)

public:
    Game(QObject *parent = 0);
    Score *yourScore();
    Score *highScore();
    int playBackPosition();
    Q_INVOKABLE void incrementPlayBackPosition();
    Q_INVOKABLE void addRandomToSequence();
    Q_INVOKABLE void buttonPressed(int);

signals:
    void playBackPositionChanged();

public slots:
    void playTimeout();
    void scoreChanged();

private:
    Score m_yourScore;
    Score m_highScore;
    QList<int> m_sequence;
    int m_playBackPosition;
    int m_playerPosition;

    int getExpectedBuzzerIndex();
    int randomInt(int low, int high);

};

#endif // GAME_H
