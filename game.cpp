#include "game.h"
#include <QTimer>
#include <QGlobal.h>
#include <QDebug>

Game::Game(QObject *parent) : QObject(parent) {
    connect(&m_yourScore, SIGNAL(scoreChanged()), this, SLOT(scoreChanged()));
    resetGame();
}

void Game::playTimeout() {
    // TODO: Impl
    // End Current Game
    // Update High Score if needed
}

void Game::resetGame() {
    m_sequence.clear();
    m_playerPosition = 0;
    yourScore()->reset();
    addRandomToSequence();
    //TODO: Play sequence
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

int Game::playBackPosition() {
    return m_playBackPosition;
}

void Game::incrementPlayBackPosition() {
    if(m_playBackPosition >= m_sequence.size()) {
        m_playBackPosition = 0;
        return;
    }
    m_playBackPosition++;
    emit playBackPositionChanged();
}

int Game::getExpectedBuzzerIndex() {
    return m_sequence.at(m_playerPosition);
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
        m_playerPosition++;
        if(m_playerPosition >= m_sequence.size()) {
            // Player has completed sequence
            m_playerPosition = 0;
            m_yourScore.incrementScoreIndex();
            qDebug() << "buttonPressed & scored m_playerPosition:" << m_playerPosition << "sequence size:" << m_sequence.size() << "m_yourScore.scoreIndex:" << m_yourScore.scoreIndex();
        } else {
            qDebug() << "buttonPressed & !scored m_playerPosition:" << m_playerPosition << "sequence size:" << m_sequence.size() << "m_yourScore.scoreIndex:" << m_yourScore.scoreIndex();
        }
        emit cheatStringChanged();
    } else {
        // Game over man!
        resetGame();
    }
}

QString Game::cheatString() const {
    QString cheatStr;
    cheatStr.append("Pos: ").append(QString::number(m_playerPosition)).append(" Seq: ");

    QString seqStr;

    for(int i=0; i < m_sequence.size(); ++i) {
        if(seqStr.size() > 0) {
            seqStr.append(", ");
        }
        if(i == m_playerPosition) {
            seqStr.append("<u>");
        }
        seqStr.append(QString::number(m_sequence.at(i)));
        if(i == m_playerPosition) {
            seqStr.append("</u>");
        }
    }
    return cheatStr.append(seqStr);
}
