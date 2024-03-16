//
//  Models.swift
//  Quizzler-iOS13
//
//  Created by Dileep Guntamadugu on 10/3/2024.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import Foundation

struct Question: Codable {
    var id: String
    var question: String
    var option1: String
    var option2: String
    var option3: String
    var option4: String
    var answer: String
    
    func correctAnswer() -> String {
        switch answer {
        case "option1":
            return option1
        case "option2":
            return option2
        case "option3":
            return option3
        case "option4":
            return option4
        default:
            fatalError("Invalid answer reference")
        }
    }

    func isCorrect(answer selectedAnswer: String) -> Bool {
        return correctAnswer() == selectedAnswer
    }
}
