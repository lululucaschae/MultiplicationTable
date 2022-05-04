//
//  ContentView.swift
//  MultiplicationTable
//
//  Created by Lucas Chae on 5/4/22.
//

import SwiftUI



struct ContentView: View {
    
    @State private var settingsShowing = true
    @State private var singleModeLevel = 2
    @State private var userAnswer = 0
    @State private var singleModeLevelList = Array(2...9)
    @State private var currentQuestion = 0
    @State private var userScore = 0
    
    static var singleModeMultiplier = 9
    static var singleModeQuestions = 10
    
    let multiplierList = (1...singleModeQuestions).map( {_ in Int.random(in: 2...singleModeMultiplier)})
    

    

    
    var body: some View {
        NavigationView{
            if settingsShowing {
            VStack {
                Form {
                    Section {
                        Text("Choose your difficulty")
                        Picker("Level", selection: $singleModeLevel) {
                            ForEach(singleModeLevelList, id: \.self) {mode in
                                Text("\(mode)")
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(.bottom, 10)
                    }
                    .listRowSeparator(.hidden)
                    
                    Section {
                        Button("Start game") {
                                settingsShowing.toggle()
                        }
                        
                    }
                    
                }
                 
               
            }
            .navigationTitle("Game Settings")


            
            } else {

                VStack {
                    HStack {
                        ForEach(multiplierList, id: \.self) {multiplier in
                                Text("\(multiplier)")
                        }
                    }
                    Text("Your current score is \(userScore)")
                    Text("Answer the following")
                    Text("What is \(singleModeLevel) X \(multiplierList[currentQuestion])")
                    TextField("Answer", value: $userAnswer, format: .number)
                    Button("Submit") {
                        if multiplicationChecker(number1: singleModeLevel, number2: multiplierList[currentQuestion], userAnswer: userAnswer) {
                            userScore += 1
                        } else {
                            userScore -= 1
                        }
                        currentQuestion += 1
                    }
                    Button("New game") {
                            settingsShowing.toggle()
                    }
                }
                .navigationTitle("Level \(singleModeLevel)")
            }
            
        }
        
    }
    
    func startGame() {
        settingsShowing.toggle()
    }
    
    func multiplicationChecker(number1: Int, number2: Int, userAnswer: Int) -> Bool {
        let correctAnswer = number1 * number2
        let result = correctAnswer == userAnswer ? true : false
        return result
    }
    
    func generateQuestions(questions: Int, multipliers: Int) -> [Int] {
        return (1...questions).map( {_ in Int.random(in: 2...multipliers)} )
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
