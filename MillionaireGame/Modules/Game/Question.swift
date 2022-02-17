//
//  Question.swift
//  MillionaireGame
//
//  Created by Olya Ganeva on 01.02.2022.
//

import Foundation

enum Answer: Codable {
    case right(String)
    case wrong(String)

    var text: String {
        switch self {
        case .right(let text):
            return text
        case .wrong(let text):
            return text
        }
    }

    var isRight: Bool {
        if case .right = self {
            return true
        }
        return false
    }

    enum CodingKeys: String, CodingKey {
        case text
        case isRight
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let text = try container.decode(String.self, forKey: CodingKeys.text)
        let isRight = try container.decode(Bool.self, forKey: CodingKeys.isRight)

        self = isRight ? .right(text) : .wrong(text)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(text, forKey: .text)
        try container.encode(isRight, forKey: .isRight)
    }
}

struct Question: Codable {
    let text: String
    let answers: [Answer]
}
