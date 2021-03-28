//
//  ContentView.swift
//  Shared
//
//  Created by Theo on 24/3/21.
//

import SwiftUI

extension Color {
    static let myGray =  Color(red: 182/255, green: 195/255, blue: 204/255)
    static let offWhite =  Color(red: 255/255, green: 255/255, blue: 235/255)
    static let offBlack =  Color(red: 45/255, green: 49/255, blue: 51/255)
}

let defaultTimeRemaining : CGFloat = 10
let lineWidth : CGFloat = 3
let radius : CGFloat = 100

struct ContentView: View {
    
    @State private var isActive = false
    @State private var timeRemaining : CGFloat = defaultTimeRemaining
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            ZStack {
              Rectangle()
                   .fill(LinearGradient(gradient: Gradient(colors: [Color(red:0.69, green: 0.80, blue: 0.89), Color(red:0.37, green: 0.53, blue: 0.64), Color(red:0.11, green: 0.26, blue: 0.38), Color(red:0, green: 0.06, blue: 0.13)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .ignoresSafeArea()
                VStack(spacing: 25) {
                    ZStack {
                        Circle()
                            .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                            .shadow(color: Color.offBlack.opacity(0.3), radius: 8, x: 10, y: 10)
                            .shadow(color: Color.myGray.opacity(0.7), radius: 10, x: -5, y: -5)
                        Circle()
                            .trim(from: 0, to: 1 - ((defaultTimeRemaining - timeRemaining)/defaultTimeRemaining))
                            .stroke(timeRemaining > defaultTimeRemaining / 2 ? Color(red: 61/255, green: 184/255, blue: 184/255) : timeRemaining  > defaultTimeRemaining  / 5 ? Color.yellow : Color.red, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                            .rotationEffect(.degrees(-90))
                            .animation(.easeInOut)
                            .shadow(color: Color.offBlack.opacity(0.6), radius: 10, x: 10, y: 10)
                            .shadow(color: Color.myGray.opacity(0.3), radius: 10, x: -5, y: -5)
                        Text("\(Int(timeRemaining))")
                            .foregroundColor(Color.offWhite)
                            .fontWeight(.light)
//                        Picker("", selection: $selectedColor) {
//                            ForEach(colors, id: \.self) {
//                                Text($0)
//                                .foregroundColor(Color.offWhite)
//                                }
//                        }
//                        Text("\(Int(timeRemaining))").font(.largeTitle)
//                            .foregroundColor(Color.offWhite)
                    }
                    .frame(width: radius * 2, height: radius * 2)
                    
                    HStack(spacing: 25){
                        Label("", systemImage: "\(isActive ? "pause.fill" : "play.fill")")
                            .foregroundColor(isActive ? .yellow : Color(red: 61/255, green: 184/255, blue: 184/255)).font(.title).onTapGesture {
                                isActive.toggle()
                            }
                            .shadow(color: Color.offBlack.opacity(0.3), radius: 10, x: 10, y: 10)
                        Label("", systemImage: "backward.fill")
                            .foregroundColor(Color(red: 255/255, green: 255/255, blue: 235/235)).font(.title).onTapGesture {
                                isActive = false
                                timeRemaining = defaultTimeRemaining
                            }
                            .shadow(color: Color.offBlack.opacity(0.3), radius: 10, x: 10, y: 10)
                    }
                }
                .onReceive(timer, perform: { _ in
                    guard isActive else {return }
                    if timeRemaining > 0  {
                        timeRemaining -= 1
                    } else {
                        isActive = false
                        timeRemaining = defaultTimeRemaining
                    }
                })
            }
            .navigationBarTitle("Title", displayMode: .automatic)
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    Stepper("", value: $timeRemaining, in: 5...50, step: 5.0)
                }
            }
            .font(.title)
        }
    }
    //Make the Navigation Bar Title White
    init() {
            // this is not the same as manipulating the proxy directly
            let appearance = UINavigationBarAppearance()
            
            // this overrides everything you have set up earlier.
            appearance.configureWithTransparentBackground()
            
            // this only applies to big titles
            appearance.largeTitleTextAttributes = [
                .font : UIFont.systemFont(ofSize: 46),
                NSAttributedString.Key.foregroundColor : UIColor.white
            ]
            // this only applies to small titles
            appearance.titleTextAttributes = [
                .font : UIFont.systemFont(ofSize: 50),
                NSAttributedString.Key.foregroundColor : UIColor.white
            ]
            
            //In the following two lines you make sure that you apply the style for good
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().standardAppearance = appearance
            
            // This property is not present on the UINavigationBarAppearance
            // object for some reason and you have to leave it til the end
            UINavigationBar.appearance().tintColor = .white
            
        }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
