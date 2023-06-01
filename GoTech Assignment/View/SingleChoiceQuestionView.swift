//
//  SingleChoiceQuestionView.swift
//  GoTech Assignment
//
//  Created by Petr Blinov on 29.05.2023.
//

import SwiftUI

struct SingleChoiceQuestionView: View {
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
            
            if let options = question.options {
                ForEach(options, id: \.self) { option in
                    HStack {
                        RadioButton(text: option, isSelected: isSelected(option)) {
                            selectOption(option)
                        }
                        
                        if option == "Other" {
                            TextField("", text: getAnswerBinding())
                                .background(VStack {
                                    Spacer()
                                    Rectangle()
                                        .frame(height: 0.7)
                                        .foregroundColor(.secondary.opacity(0.3))
                                })
                        }
                    }
                }
            }
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
                        
                        if newValue.count > 0 {
                            selectOption("Other")
                        }
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
                        
                        if newValue.count > 0 {
                            selectOption("Other")
                        }
                    }
                }
            )
        }
    }
    
    private func isSelected(_ option: String) -> Bool {
        return answers.first(where: { $0.id == question.id })?.selectedOptions?.contains(option) ?? false
    }
    
    private func selectOption(_ option: String) {
        if let answerIndex = answers.firstIndex(where: { $0.id == question.id }) {
            if question.questionType == .singleChoice {
                answers[answerIndex].selectedOptions = [option]
            } else if question.questionType == .multipleChoice {
                if let selectedIndex = answers[answerIndex].selectedOptions?.firstIndex(of: option) {
                    answers[answerIndex].selectedOptions?.remove(at: selectedIndex)
                } else {
                    answers[answerIndex].selectedOptions?.append(option)
                }
            }
        } else {
            var newAnswer = Answer(id: question.id, questionNumber: question.questionNumber, questionText: question.text, selectedOptions: [], answerText: nil)
            newAnswer.selectedOptions = [option]
            answers.append(newAnswer)
        }
    }
}
