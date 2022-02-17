//
//  SequentialStrategy.swift
//  MillionaireGame
//
//  Created by Olya Ganeva on 10.02.2022.
//

import Foundation

final class SequentialStrategy: Strategy {

    let index = 0

    func shuffle(_ questions: [Question]) -> [Question] {
        return questions
    }
}
