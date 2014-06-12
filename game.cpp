#include "game.h"
#include <QTimer>
#include <QGlobal.h>
#include <QDebug>

Game::Game(QObject *parent) : QObject(parent) {
    connect(&m_yourScore, SIGNAL(scoreChanged()), this, SLOT(scoreChanged()));
}

void Game::playTimeout() {
    // TODO: Impl
    // End Current Game
    // Update High Score if needed
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
    // reset playback index
    setPlayBackSequenceIndex(0);
}

int Game::playBackPosition() const {
    if(m_playBackSequenceindex >= 0 && m_playBackSequenceindex < m_sequence.size()) {
       return m_sequence.at(m_playBackSequenceindex);
    }

    return -1; // overflow
}

void Game::setPlayBackSequenceIndex(const int &value) {
    if(m_playBackSequenceindex == value) return;

    m_playBackSequenceindex = value;
    emit playBackPositionChanged();
}

int Game::incrementPlayBackPosition() {
    // use overflow to indicate playback finished
    setPlayBackSequenceIndex(m_playBackSequenceindex +1);
    return playBackPosition();
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
            setIsPlayBack(true);
        }
        emit cheatStringChanged();
    } else {
        // Game over man!
        resetGame();
    }
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
