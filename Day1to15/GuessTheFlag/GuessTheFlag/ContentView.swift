//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Ayush Patra on 21/05/24.
//

import SwiftUI

struct ContentView: View {
    @State var countries = ["Germany", "Estonia", "France", "Italy", "Ireland", "Monaco", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    
    @State var score:Int = 0
    
    @State var isGameStarted:Bool = false
    @State var isGameStopped:Bool = false
    
    func startGame(){
        isGameStarted = true
        isGameStopped = false
    }
    
    func resetGame(){
        score = 0
        isGameStarted = false
        isGameStopped = true
    }
    
    func updatedScore(num: Int){
        if(correctAnswer == num){
            score+=1
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0..<3)
        
        if(score == 10){
            isGameStarted = false
            isGameStopped = true
        }
    }

    
    @State var correctAnswer:Int = Int.random(in: 0..<3)
    var body: some View {
        ZStack {
            
            //COLOR:
            
            LinearGradient(colors: [.indigo, .black], startPoint: .topLeading, endPoint: .bottomTrailing)
            
            
            VStack{
                //TITLE
                Text("GuessTheFlag")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .foregroundColor(Color.orange)
                
                if(isGameStarted == false){
                    Group {
                        Button{
                            startGame()
                        }label: {
                            Text("Start Game")
                        }.alert("Game Over", isPresented: $isGameStopped) {
                            Button("Play Again") {
                                // Logic to restart the game
                                resetGame()
                            }
                    }message: {
                        Text("You have won the game.")
                    }
                    }
                }else{
                    VStack{
                        
                        Text("Your Current Score: \(score)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                        
                        Text("Choose the correct flag: \n")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                        
                        Text("\(countries[correctAnswer])")
                            .font(.system(size: 38))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        
                        ForEach(0..<3){
                            number in
                            Button{
                                //Button Was tapped
                                updatedScore(num: number)
                            }label: {
                                Image("\(countries[number])")
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                    .shadow(radius: 10)
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 10)
                }
            }
            .padding(.top, 70)
            .padding(.bottom, 50)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
