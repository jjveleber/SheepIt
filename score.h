#ifndef SCORE_H
#define SCORE_H

#include <QObject>
#include <QString>

class Score : public QObject
{
    Q_OBJECT
//    Q_PROPERTY(quint32 scoreIndex  MEMBER m_scoreIndex NOTIFY scoreIndexChanged)
//    Q_PROPERTY(QString scoreString MEMBER m_scoreString NOTIFY scoreStringChanged)
public:
    explicit Score(QObject *parent = 0);

signals:

public slots:

private:
    quint32 m_scoreIndex;
    QString m_scoreString;

};

#endif // SCORE_H
