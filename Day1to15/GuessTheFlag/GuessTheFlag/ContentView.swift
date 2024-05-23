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
    
    //TESTING
    //@State var isGameStarted:Bool = true
    //PROD:
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
            
            LinearGradient(colors: [.indigo, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
            
            
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
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                                .frame(width: 200)
                                .padding()
                                .background(.regularMaterial)
                                .clipShape(.rect(cornerRadius: 20))
                                .padding()
                        }.alert("Game Over!", isPresented: $isGameStopped) {
                            Button("Play Again?") {
                                // Logic to restart the game
                                resetGame()
                            }
                    }message: {
                        Text("You have won the game!")
                    }
                    }
                }else{
                    VStack{
                        
                        Text("Choose the correct flag for: \n")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                        
                        Text("\(countries[correctAnswer])")
                            .font(.system(size: 38))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        
                        VStack (spacing: 15){
                            ForEach(0..<3){
                                number in
                                Button{
                                    //Button Was tapped
                                    updatedScore(num: number)
                                }label: {
                                        Image("\(countries[number])")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: 200)
                                            .clipShape(Capsule())
                                            .overlay(Capsule().stroke(Color.white, lineWidth: 2))
                                            .shadow(radius: 5)
                                }.padding(.vertical, 15)
                            }
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .background(.thinMaterial)
                        .clipShape(.rect(cornerRadius: 20))
                        .padding(.vertical, 20)
                        
                        
                        Spacer()
                        
                        Text("Your Current Score: \(score)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 10)
                    .padding(.horizontal, 20)
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
