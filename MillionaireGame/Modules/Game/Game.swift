//
//  Game.swift
//  MillionaireGame
//
//  Created by Olya Ganeva on 02.02.2022.
//

import Foundation

final class Game {

    enum Consts {
        static let storageKey = "gameRecords"
    }

    static let shared = Game()

    private let storage = UserDefaults.standard

    private var questions: [Question] = []

    var questionsCount: Int {
        questions.count
    }

    private init() {
        loadQuestions()
    }

    func question(with index: Int) -> Question? {
        if index < questions.count {
            return questions[index]
        }
        return nil
    }

    private func loadQuestions() {
        do {
            if let bundlePath = Bundle.main.path(forResource: "questions", ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {

                self.questions = try JSONDecoder().decode([Question].self, from: jsonData)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func save(record: GameRecord) {
        guard let recordsData = storage.data(forKey: Consts.storageKey) else {
            do {
                let updatedRecordsData = try JSONEncoder().encode([record])
                storage.set(updatedRecordsData, forKey: Consts.storageKey)
            } catch {
                print(error.localizedDescription)
            }
            return
        }
        do {
            var records = try JSONDecoder().decode([GameRecord].self, from: recordsData)
            records.append(record)
            let updatedRecordsData = try JSONEncoder().encode(records)
            storage.set(updatedRecordsData, forKey: Consts.storageKey)
        } catch {
            print(error.localizedDescription)
        }
    }

    func loadRecords() -> [GameRecord] {
        guard let data = storage.data(forKey: Consts.storageKey) else {
            return []
        }

        do {
            return try JSONDecoder().decode([GameRecord].self, from: data)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
