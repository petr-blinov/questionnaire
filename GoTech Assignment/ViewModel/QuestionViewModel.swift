//
//  QuestionViewModel.swift
//  GoTech Assignment
//
//  Created by Petr Blinov on 29.05.2023.
//

import Foundation

class QuestionViewModel: ObservableObject {
    @Published var questions: [Question]?
    @Published var answers: [Answer] = []

    var allRequiredQuestionsFilled: Bool {
        guard let questions = questions else { return false }
        
        for question in questions {
            if question.isRequired && !isQuestionFilled(question) {
                return false
            }
        }
        
        return true
    }
    
    func fetchQuestions() {
        guard let url = URL(string: "http://localhost:3000/questions") else {
            print("Questions URL is not valid")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("Error: No data received")
                return
            }

            do {
                let decoder = JSONDecoder()
                self.questions = try decoder.decode([Question].self, from: data)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        .resume()
    }

    func submitAnswers() {
        guard let url = URL(string: "http://localhost:3000/answers") else {
            print("Invalid URL")
            return
        }
        
        guard let jsonData = try? JSONEncoder().encode(answers) else {
            print("Error encoding answers")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error submitting answers: \(error)")
            } else {
                print("Answers submitted successfully")
                self.resetForm()
            }
        }.resume()
    }

    private func isQuestionFilled(_ question: Question) -> Bool {
        if let answer = answers.first(where: { $0.questionNumber == question.questionNumber }) {
            switch question.questionType {
            case .singleChoice:
                return !(answer.selectedOptions?.isEmpty ?? true)
            case .multipleChoice:
                return !(answer.selectedOptions?.isEmpty ?? true)
            case .text:
                return !(answer.answerText?.isEmpty ?? true)
            }
        }
        
        return false
    }
    
    private func resetForm() {
        answers.removeAll()
    }
}
