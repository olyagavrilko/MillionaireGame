//
//  RandomStrategy.swift
//  MillionaireGame
//
//  Created by Olya Ganeva on 10.02.2022.
//

import Foundation

final class RandomStrategy: Strategy {

    let index = 1

    func shuffle(_ questions: [Question]) -> [Question] {
        return questions.shuffled()
    }    
}
