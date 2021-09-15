//
//  Quiz.swift
//  UIParts
//
//  Created by Ryo Hanma on 2021/08/25.
//

import SwiftUI

class QuizModel: Codable, ObservableObject {
    var question: String
    var answer: String
    var choice: [String]
    var isShufle: Bool
}

class Result: ObservableObject {
    @Published var quizName: String = ""
    @Published var numberOfQuestion: Int = 0
    @Published var numberOfCorrect: Int = 0
    @Published var correctRate: Float = 0
    @Published var answerdChoice = [String]()
    @Published var isCorrect = [Bool]()
}


struct QuizView: View {
    @ObservedObject var quiz = QuizesManager()
    
    var body: some View {
        VStack {
            Text("No.\(quiz.questionNumber + 1)/\(quiz.quizes.count)")
            Spacer()
            Text(quiz.presentQuestion).font(.title)
            Spacer()
            ForEach( 0..<4) { i in
                Button(action: {
                    quiz.judge(i)
                }){
                    HStack {
                        Text("   \(i + 1).")
                            .frame(width: 50, height: 50)
                        Text(quiz.presantChoice[i])
                            .frame(width: UIScreen.main.bounds.width - 60, height: 50, alignment: .leading)
                    }
                }.frame(width: UIScreen.main.bounds.width - 10, height: 50)
                .disabled(quiz.isFinished)
                .background(Color.white)
                .cornerRadius(25)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color(red: 9/255, green: 64/255, blue: 103/255), lineWidth: 4)
                )
                .padding(2)
            }
        }.onAppear(perform: {
            loadQuiz()
            self.quiz.prepareQuestion()
        })
    }
    
    func loadQuiz() {
        quiz.quizes = load(".json")
    }
}

class QuizesManager: ObservableObject {
    @Published var presentQuestion: String = ""
    @Published var presantChoice = ["","","",""]
    @Published var isFinished:Bool = false
    @Published var quizes = [QuizModel]()
    @Published var result = Result()
    @Published var questionNumber: Int = 0
    private var clear: Int = 0
    
    func prepareQuestion() {
        presentQuestion = quizes[questionNumber].question
        for i in 0 ..< quizes[questionNumber].choice.count {
            presantChoice[i] = quizes[questionNumber].choice[i]
        }
        
        if quizes[questionNumber].isShufle {
            for i in 0 ..< presantChoice.count {
                let r = Int(arc4random_uniform(UInt32(presantChoice.count)))
                presantChoice.swapAt(i, r)
            }
        }
    }
    
    func judge(_ answeredNumber: Int) {
        if presantChoice[answeredNumber] == quizes[questionNumber].answer {
            self.clear += 1
            result.isCorrect.append(true)
        } else {
            result.isCorrect.append(false)
        }
        questionNumber += 1
        result.answerdChoice.append(presantChoice[answeredNumber])
            
        if questionNumber >= quizes.count {
            result.numberOfQuestion = questionNumber
            result.numberOfCorrect = clear
            result.correctRate = Float(clear) / Float(questionNumber)
            self.isFinished = true
        } else {
            self.prepareQuestion()
        }
    }
}

struct Quiz_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}
