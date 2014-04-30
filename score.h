#ifndef SCORE_H
#define SCORE_H

#include <QObject>
#include <QString>
#include <QStringList>

class Score : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int scoreIndex READ scoreIndex WRITE setScoreIndex NOTIFY scoreChanged)
public:
    explicit Score(QObject *parent = 0);
    int scoreIndex() const;
    void setScoreIndex(const int &);
    int incrementScoreIndex();
    Q_INVOKABLE QString scoreString(int index) const;

signals:
    void scoreChanged();
public slots:

private:
    int m_scoreIndex;
    static QStringList getScoreList();
};

#endif // SCORE_H
