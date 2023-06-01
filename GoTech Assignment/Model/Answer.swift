//
//  Answer.swift
//  GoTech Assignment
//
//  Created by Petr Blinov on 29.05.2023.
//

import Foundation

struct Answer: Codable {
    var id: Int                             // Id
    var questionNumber: Int                 // Number of the corresponding question
    var questionText: String                // Text of the corresponding question
    var selectedOptions: [String]?          // Selected answer options (for non-text question types)
    var answerText: String?                 // Provided answer text (for text question type)
}
