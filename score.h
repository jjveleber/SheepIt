#ifndef SCORE_H
#define SCORE_H

#include <QObject>
#include <QString>

class Score : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int scoreIndex READ scoreIndex WRITE setScoreIndex NOTIFY scoreChanged)
    Q_PROPERTY(QString scoreString READ scoreString NOTIFY scoreChanged)
public:
    Score(QObject *parent = 0);
    int scoreIndex() const;
    void setScoreIndex(const int &);
    QString scoreString() const;

signals:
    void scoreChanged();

public slots:

private:
    int m_scoreIndex;
    QString m_scoreString;

};

#endif // SCORE_H
