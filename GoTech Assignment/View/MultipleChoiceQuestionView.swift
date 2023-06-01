//
//  MultipleChoiceQuestionView.swift
//  GoTech Assignment
//
//  Created by Petr Blinov on 29.05.2023.
//

import SwiftUI

struct MultipleChoiceQuestionView: View {
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
            
            ForEach(question.options ?? [], id: \.self) { option in
                RadioButton(text: option, isSelected: isOptionSelected(option)) {
                    selectOption(option)
                }
            }
            .padding(.bottom, 6)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.white)
        )
    }
    
    private func selectOption(_ option: String) {
        if let answerIndex = answers.firstIndex(where: { $0.id == question.id }) {
            if var selectedOptions = answers[answerIndex].selectedOptions {
                if selectedOptions.contains(option) {
                    selectedOptions.removeAll(where: { $0 == option })
                } else {
                    selectedOptions.append(option)
                }
                answers[answerIndex].selectedOptions = selectedOptions
            } else {
                answers[answerIndex].selectedOptions = [option]
            }
        } else {
            let newAnswer = Answer(id: question.id, questionNumber: question.questionNumber, questionText: question.text, selectedOptions: [option], answerText: nil)
            answers.append(newAnswer)
        }
    }
    
    private func isOptionSelected(_ option: String) -> Bool {
        if let answerIndex = answers.firstIndex(where: { $0.id == question.id }) {
            return answers[answerIndex].selectedOptions?.contains(option) ?? false
        }
        return false
    }
}
