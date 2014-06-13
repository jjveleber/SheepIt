#include "game.h"
#include <QTimer>
#include <QGlobal.h>
#include <QDebug>
#include <QStringBuilder>
#include <QFile>
#include <QTextStream>
#include <QDataStream>
#include <QFileInfo>

Game::Game(QObject *parent) : QObject(parent) {

    // Load m_PlayBackAnimationTemplate
    QFile templateFile(":/templates/PlayBackAnimationTemplate");
    templateFile.open(QFile::ReadOnly | QFile::Text);
    QTextStream in(&templateFile);
    m_PlayBackAnimationTemplate = in.readAll();
    templateFile.close();

    QFile highScoreFile("highscore");
    QFileInfo fileInfo(highScoreFile.fileName());
    qDebug() << "In" << fileInfo.absoluteFilePath();
    if(highScoreFile.exists()) {
        highScoreFile.open(QFile::ReadOnly);
        QDataStream highScoreIn(&highScoreFile);
        int highScoreIndex;
        highScoreIn >> highScoreIndex;
        qDebug() << "highScoreIndex" << highScoreIndex;
        m_highScore.setScoreIndex(highScoreIndex);
    }

    connect(&m_yourScore, SIGNAL(scoreChanged()), this, SLOT(scoreChanged()));

}

void Game::resetGame() {

    m_sequence.clear();
    m_playerSequenceindex = 0;
    yourScore()->reset();
    addRandomToSequence();
    setIsPlayBack(true);
}

Score *Game::yourScore() {
    return &m_yourScore;
}

void Game::scoreChanged() {
    // This assumes scores always go up.
    addRandomToSequence();
}

Score *Game::highScore() {
    return &m_highScore;
}

bool Game::isPlayBack() const{
    return m_isPlayBack;
}

void Game::setIsPlayBack(const bool &value) {
    if(m_isPlayBack == value) return;

    m_isPlayBack = value;
    emit isPlayBackChanged();
}

int Game::getExpectedBuzzerIndex() {
    return m_sequence.at(m_playerSequenceindex);
}

void Game::addRandomToSequence() {
    m_sequence.append(randomInt(0, 3));
    emit cheatStringChanged();
}

int Game::randomInt(int low, int high) {
    // Random number between low and high
    return qrand() % ((high + 1) - low) + low;
}

void Game::buttonPressed(int position) {
    if(getExpectedBuzzerIndex() == position) {
        m_playerSequenceindex++;
        if(m_playerSequenceindex >= m_sequence.size()) {
            // Player has completed sequence
            m_playerSequenceindex = 0;
            m_yourScore.incrementScoreIndex();
            if(m_yourScore.scoreIndex() > m_highScore.scoreIndex()) {
                m_highScore.setScoreIndex(m_yourScore.scoreIndex());
                persistHighScore();
            }
        }
        emit cheatStringChanged();
    } else {
        // Game over man!
        resetGame();
    }
}

QString Game::playBackAnimationQml() const {
    QString animationQml("import QtQuick 2.0\n SequentialAnimation { \n");
    QHash<int, QString> buttonLookup;
    buttonLookup.insert(0, "blueButton");
    buttonLookup.insert(1, "orangeButton");
    buttonLookup.insert(2, "purpleButton");
    buttonLookup.insert(3, "greenButton");

    foreach (int pos, m_sequence) {
        animationQml = animationQml % m_PlayBackAnimationTemplate
                            .arg(buttonLookup.value(pos));
    }
    return animationQml % "\n ScriptAction{script:{gameInstance.isPlayBack = false;}}}";
}

void Game::persistHighScore() {
    QFile file("highscore");
    QFileInfo fileInfo(file.fileName());
    qDebug() << "Out" << fileInfo.absoluteFilePath();
    file.open(QFile::WriteOnly);
    QDataStream out(&file);
    out.setVersion(QDataStream::Qt_5_2);
    out << m_highScore.scoreIndex();
}

QString Game::cheatString() const {
    QString cheatStr;
    cheatStr.append("Pos: ").append(QString::number(m_playerSequenceindex)).append(" Seq: ");

    QString seqStr;

    for(int i=0; i < m_sequence.size(); ++i) {
        if(seqStr.size() > 0) {
            seqStr.append(", ");
        }
        if(i == m_playerSequenceindex) {
            seqStr.append("<u>");
        }
        seqStr.append(QString::number(m_sequence.at(i)));
        if(i == m_playerSequenceindex) {
            seqStr.append("</u>");
        }
    }
    return cheatStr.append(seqStr);
}

