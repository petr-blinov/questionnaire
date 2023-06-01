//
//  ContentView.swift
//  GoTech Assignment
//
//  Created by Petr Blinov on 29.05.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = QuestionViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            VStack(alignment: .leading) {
                Rectangle()
                    .frame(height: 9)
                    .foregroundColor(.brandAccentColor)
                
                Text("GoTech\nQuestionnaire")
                    .foregroundColor(.primary)
                    .font(.system(size: 30))
                    .padding(.leading)
                    .padding(.top, 4)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text("Show me what you got!")
                    .foregroundColor(.primary)
                    .font(.system(size: 13))
                    .padding(.leading)
                    .padding(.top, 2)
                
                Divider()
                
                Text("* Required")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.red)
                    .padding(.leading)
                    .padding(.top, 3)
                    .padding(.bottom, 10)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.white)
            )
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            if let questions = viewModel.questions?.sorted { $0.questionNumber < $1.questionNumber } {
                ForEach(questions) { question in
                    switch question.questionType {
                    case .singleChoice:
                        SingleChoiceQuestionView(question: question, answers: $viewModel.answers)
                    case .multipleChoice:
                        MultipleChoiceQuestionView(question: question, answers: $viewModel.answers)
                    case .text:
                        TextQuestionView(question: question, answers: $viewModel.answers)
                    }
                }
                Spacer()
                
                HStack {
                    Button(action: {
                        viewModel.submitAnswers()
                    }) {
                        Text("Submit")
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                            .frame(width: 100, height: 35)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .foregroundColor(.brandAccentColor)
                            )
                    }
                    .disabled(!viewModel.allRequiredQuestionsFilled)
                    
                    Spacer()
                }
            }
        }
        .padding()
        .background(Color.brandSecondaryColor)
        .onAppear {
            viewModel.fetchQuestions()
        }
    }
}
