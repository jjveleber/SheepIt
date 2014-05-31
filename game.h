#ifndef GAME_H
#define GAME_H

#include <QObject>
#include <QList>
#include <QQmlListProperty>
#include "score.h"

class Game : public QObject
{
    Q_OBJECT
    Q_PROPERTY(Score *yourScore READ yourScore CONSTANT)
    Q_PROPERTY(Score *highScore READ highScore CONSTANT)
    Q_PROPERTY(int playBackPosition READ playBackPosition NOTIFY playBackPositionChanged)
    Q_PROPERTY(QString cheatString READ cheatString NOTIFY cheatStringChanged)
    Q_PROPERTY(bool isPlayBack READ isPlayBack WRITE setIsPlayBack NOTIFY isPlayBackChanged)

public:
    Game(QObject *parent = 0);
    Score *yourScore();
    Score *highScore();
    bool isPlayBack() const;
    void setIsPlayBack(const bool &);
    int playBackPosition() const;
    void setPlayBackSequenceIndex(const int &);
    QString cheatString() const;
    Q_INVOKABLE int incrementPlayBackPosition();
    Q_INVOKABLE void addRandomToSequence();
    Q_INVOKABLE void buttonPressed(int);
    Q_INVOKABLE void resetGame();

signals:
    void playBackPositionChanged();
    void playBackPositionsChanged();
    void cheatStringChanged();
    void isPlayBackChanged();

public slots:
    void playTimeout();
    void scoreChanged();

private:
    Score m_yourScore;
    Score m_highScore;
    QList<int> m_sequence;
    bool m_isPlayBack;
    int m_playBackSequenceindex;
    int m_playerSequenceindex;

    int getExpectedBuzzerIndex();
    int randomInt(int low, int high);

};

#endif // GAME_H
