//
//  ContentView.swift
//  BetterRest
//
//  Created by Ayush Patra on 27/05/24.
//

import CoreML
import SwiftUI

struct ContentView: View {
    
    @State private var sleepHours = 8.0
    @State private var wakeUp = Date.now
    @State private var coffeeAmount = 0
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        //Stepper
        NavigationStack {
            VStack (spacing: 10){
                Text("When do you want to get up?")
                    .font(.headline)
                
                //Date Picker:
                DatePicker("Please enter the Date and Time: ", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                
                Text("Desired Amount of Sleep?")
                    .font(.headline)
                
                Stepper(" \(sleepHours) Hours", value: $sleepHours, in: 4...12, step: 0.25)
                
                Text("How much coffee do you drink?")
                    .font(.headline)
                
                Stepper("\(coffeeAmount) cup(s)", value: $coffeeAmount, in: 0...20)
                
                
            }
            .padding()
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
            .navigationTitle("BetterRest")
            .toolbar{
                Button("Calculate Bed Time", action: calculateBedTime)
                
            }
        }
    }
    
    func calculateBedTime() {
        //Here, we will use Core ML to use the ML model
        //which we trained using Create ML.
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            //do more
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            //basically, we converted the time into seconds
            
            //then, we are passing the time in seconds, number of hours to sleep, and the number of cups of coffees in the model.
            
            //what we will get back, is the number of hours we actually need to sleep
            
            let prediction = try model.prediction(wake: Double(hour+minute), estimatedSleep: sleepHours, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is…"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        }catch{
            //something went wrong
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        showingAlert = true
    }
}

#Preview {
    ContentView()
}


//NOTE: CreatML: Train ; CoreML: Use Model
