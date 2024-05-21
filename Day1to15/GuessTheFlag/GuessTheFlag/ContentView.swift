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
    
    func updatedScore(num: Int){
        if(correctAnswer == num){
            score+=1
        }
        else{
            score-=1
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0..<3)
    }
    
    @State var correctAnswer:Int = Int.random(in: 0..<3)
    var body: some View {
        ZStack {
            
            //COLOR:
            
            Color.blue
            
            VStack(spacing: 20){
                
                Text("GuessTheFlag")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.orange)
                    
                
                Text("Your Current Score: \(score)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                
                Text("Which of the following is the flag of: \(countries[correctAnswer])")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                
                ForEach(0..<3){
                    number in
                    Button{
                        //Button Was tapped
                        updatedScore(num: number)
                    }label: {
                        Image("\(countries[number])")
                    }
                }
                
                Spacer()
            }
            .padding(.top, 100)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
