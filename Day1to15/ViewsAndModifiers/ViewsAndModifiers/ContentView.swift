//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Ayush Patra on 24/05/24.
//

import SwiftUI

struct CustomTextView : View {
    var text : String
    
    var body: some View{
        Text(text)
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .clipShape(Capsule())
    }
}

struct CustomModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .padding(30)
            .foregroundColor(.white)
            .background(.blue)
            .clipShape(.rect(cornerRadius: 20))
    }
}

//IMPORTANT:

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding(2)
                .background(.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

struct ContentView: View {
    
        //"some" View: "one object that conforms to the View protocol, but we don’t want to say what."
        
        //Environment modifier (can be overwritten)
        //Regular: No.
        
        
//    let motto1 = Text("Draco dormiens")
//    let motto2 = Text("nunquam titillandus")
//    
//    
//    //Important to use @ViewBuilder
//    @ViewBuilder var spells: some View {
//        Text("Lumos")
//        Text("Obliviate")
//    }
//
//    var body: some View {
//        VStack {
//            motto1
//                .foregroundStyle(.red)
//            motto2
//                .foregroundStyle(.blue)
//            
//            spells
//        }
//    }
    

    //WE CAN ALSO CREATE VIEW COMPOSITIONS:
    var body: some View{
        CustomTextView(text: "Hello")
        
        Text("Custom View Modifier")
            .modifier(CustomModifier())
            .watermarked(with: "sample message")
    }
}

#Preview {
    ContentView()
}
