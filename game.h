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
    Q_PROPERTY(QString cheatString READ cheatString NOTIFY cheatStringChanged)
    Q_PROPERTY(bool isPlayBack READ isPlayBack WRITE setIsPlayBack NOTIFY isPlayBackChanged)
    Q_PROPERTY(QString playBackAnimationQml READ playBackAnimationQml NOTIFY playBackAnimationQmlChanged)

public:
    Game(QObject *parent = 0);
    Score *yourScore();
    Score *highScore();
    bool isPlayBack() const;
    void setIsPlayBack(const bool &);
    QString cheatString() const;
    QString playBackAnimationQml() const;
    Q_INVOKABLE void addRandomToSequence();
    Q_INVOKABLE void buttonPressed(int);
    Q_INVOKABLE void resetGame();

signals:
    void cheatStringChanged();
    void isPlayBackChanged();
    void playBackAnimationQmlChanged();

public slots:
    void scoreChanged();

private:
    Score m_yourScore;
    Score m_highScore;
    QList<int> m_sequence;
    bool m_isPlayBack;
    int m_playBackSequenceindex;
    int m_playerSequenceindex;
    QString m_PlayBackAnimationTemplate;

    int getExpectedBuzzerIndex();
    int randomInt(int low, int high);
    void persistHighScore();

};

#endif // GAME_H
