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

void Game::yourScoreChanged() {
    // TODO: react to score deltas
}

void Game::highScoreChanged() {
    // TODO: react to high score deltas
}
