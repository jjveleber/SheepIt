#include "game.h"
#include <QTimer>
#include <QDebug>

Game::Game(QObject *parent) :
    QObject(parent)
{

}

void Game::playTimeout() {
    // TODO: Impl
    // End Current Game
    // Update High Score if needed
}

Score *Game::yourScore() {
    return &m_yourScore;
}


Score *Game::highScore() {
    return &m_highScore;
}
