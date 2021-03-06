//
//  GameSession.swift
//  MillionaireGame
//
//  Created by Olya Ganeva on 02.02.2022.
//

import Foundation

protocol Strategy {
    var index: Int { get }
    func shuffle(_ questions: [Question]) -> [Question]
}

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

    private(set) var currentQuestionIndex = Observable<Int>(0)
    private var rightQuestionCount = 0

    weak var view: GameSessionView?
    
    func viewDidLoad() {
        Game.shared.shuffleQuestions()
        guard let question = Game.shared.question(with: currentQuestionIndex.value) else {
            return
        }
        view?.update(with: question)
    }

    func answerWasTapped(_ answer: Answer) {
        switch answer {
        case .right:
            rightQuestionCount += 1

            guard let nextQuestion = Game.shared.question(with: currentQuestionIndex.value + 1) else {
                view?.update(with: "You win!")
                saveResults()
                return
            }

            currentQuestionIndex.value += 1
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
