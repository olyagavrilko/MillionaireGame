//
//  GameSession.swift
//  MillionaireGame
//
//  Created by Olya Ganeva on 02.02.2022.
//

import Foundation

protocol GameSessionView: AnyObject {
    func update(with question: Question)
    func update(with text: String)
}

struct GameRecord: Codable {
    let date: Date
    let questionCount: Int
    let rightQuestionCount: Int
}

final class GameSession {

    typealias GameSessionSnapshot = Data

    private var currentQuestionIndex = 0
    private var rightQuestionCount = 0

    weak var view: GameSessionView?
    
    func viewDidLoad() {
        guard let question = Game.shared.question(with: currentQuestionIndex) else {
            return
        }
        view?.update(with: question)
    }

    func answerWasTapped(_ answer: Answer) {
        switch answer {
        case .right:
            currentQuestionIndex += 1
            rightQuestionCount += 1
            guard let nextQuestion = Game.shared.question(with: currentQuestionIndex) else {
                view?.update(with: "You win!")
                saveResults()
                return
            }
            view?.update(with: nextQuestion)
        case .wrong:
            view?.update(with: "You lose!")
            saveResults()
        }
    }

    func makeRecord() -> GameRecord {
        return GameRecord(
            date: Date(),
            questionCount: Game.shared.questionsCount,
            rightQuestionCount: rightQuestionCount)
    }

    private func saveResults() {
        let record = makeRecord()
        Game.shared.save(record: record)
    }
}
