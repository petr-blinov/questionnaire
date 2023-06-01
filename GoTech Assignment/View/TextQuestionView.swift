//
//  TextQuestionView.swift
//  GoTech Assignment
//
//  Created by Petr Blinov on 29.05.2023.
//

import SwiftUI

struct TextQuestionView: View {
    let question: Question
    @Binding var answers: [Answer]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 3) {
                Text("\(question.text)")
                    .font(.system(size: 15))
                
                if question.isRequired {
                    Text("*")
                        .foregroundColor(.red)
                }
            }
            .padding(.bottom)
            
            TextField("Your answer", text: getAnswerBinding())
                .background(VStack {
                    Spacer()
                    Rectangle()
                        .frame(height: 0.7)
                        .foregroundColor(.secondary.opacity(0.3))
                })
                .padding(.bottom, 12)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.white)
        )
    }
    
    private func getAnswerBinding() -> Binding<String> {
        if let answerIndex = answers.firstIndex(where: { $0.id == question.id }) {
            return Binding<String>(
                get: { answers.indices.contains(answerIndex) ? answers[answerIndex].answerText ?? "" : "" },
                set: { newValue in
                    if answers.indices.contains(answerIndex) {
                        answers[answerIndex].answerText = newValue
                    }
                }
            )
        } else {
            let newAnswer = Answer(id: question.id, questionNumber: question.questionNumber, questionText: question.text, answerText: "")
            answers.append(newAnswer)
            let lastIndex = answers.count - 1
            return Binding<String>(
                get: { answers.indices.contains(lastIndex) ? answers[lastIndex].answerText ?? "" : "" },
                set: { newValue in
                    if answers.indices.contains(lastIndex) {
                        answers[lastIndex].answerText = newValue
                    }
                }
            )
        }
    }
    
    
    
    
}
