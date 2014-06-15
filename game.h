#ifndef GAME_H
#define GAME_H

#include <QObject>
#include <QList>
#include <QQmlListProperty>
#include <QSerialPort>
#include <QTimer>
#include "score.h"


class Game : public QObject
{
    Q_OBJECT
    Q_PROPERTY(Score *yourScore READ yourScore CONSTANT)
    Q_PROPERTY(Score *highScore READ highScore CONSTANT)
    Q_PROPERTY(QString cheatString READ cheatString NOTIFY cheatStringChanged)
    Q_PROPERTY(bool isPlayBack READ isPlayBack WRITE setIsPlayBack NOTIFY isPlayBackChanged)
    Q_PROPERTY(QString playBackAnimationQml READ playBackAnimationQml NOTIFY playBackAnimationQmlChanged)
    Q_PROPERTY(int externalButton READ externalButton CONSTANT NOTIFY externalButtonPressed)
    Q_PROPERTY(QString comPortName READ comPortName WRITE setComportName NOTIFY comPortNameChanged)

public:
    Game(QObject *parent = 0);
    Score *yourScore();
    Score *highScore();
    bool isPlayBack() const;
    void setIsPlayBack(const bool &);
    int externalButton() const;
    QString cheatString() const;
    QString playBackAnimationQml() const;
    QString comPortName() const;
    void setComportName(const QString &);
    Q_INVOKABLE void addRandomToSequence();
    Q_INVOKABLE void buttonPressed(int);
    Q_INVOKABLE void resetGame();
    Q_INVOKABLE void close();

signals:
    void cheatStringChanged();
    void isPlayBackChanged();
    void playBackAnimationQmlChanged();
    void gameOver();
    void externalButtonPressed();
    void comPortNameChanged();

public slots:
    void scoreChanged();
    void dataReady();
    void timeout();

private:
    Score m_yourScore;
    Score m_highScore;
    QList<int> m_sequence;
    bool m_isPlayBack;
    int m_playBackSequenceindex;
    int m_playerSequenceindex;
    int m_externalbuttonPressed;
    QString m_PlayBackAnimationTemplate;
    QSerialPort *m_serial;
    QTimer *m_timer;
    QString m_comPortName;

    int getExpectedBuzzerIndex();
    int randomInt(int low, int high);
    void persistHighScore();
    void openSerialPort();

};

#endif // GAME_H
