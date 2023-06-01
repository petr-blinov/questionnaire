//
//  Question.swift
//  GoTech Assignment
//
//  Created by Petr Blinov on 29.05.2023.
//

import Foundation

struct Question: Codable, Identifiable {
    var id: Int                     // Question id
    var questionNumber: Int         // Used to set the questions in the right order
    var text: String                // Text of the question
    var type: String                // Question type (singleChoice / multipleChoice / text)
    var options: [String]?          // Available answer options (for singleChoice and multipleChoice types)
    var isRequired: Bool            // Is question required or not
    
    var questionType: QuestionType {
        return QuestionType(rawValue: type)
    }
    
    enum QuestionType: Codable {
        case singleChoice
        case multipleChoice
        case text
        
        init(rawValue: String) {
            switch rawValue {
            case "singleChoice":
                self = .singleChoice
            case "multipleChoice":
                self = .multipleChoice
            case "text":
                self = .text
            default:
                self = .singleChoice
            }
        }
    }
}


