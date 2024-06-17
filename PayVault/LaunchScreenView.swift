//
//  LaunchScreenView.swift
//  PayVault
//
//  Created by Shubhada Martha on 1/17/24.
//

import SwiftUI

struct LaunchScreenView: View {
    @State private var isActive = false
    @EnvironmentObject var user : UserViewModel

        var body: some View {
            NavigationStack {
                VStack {
                    VStack {
                        Image("frogVault")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 400, height: 400)
                        
                        Text("FroggyVault")
                            .bold()
                            .font(.largeTitle)
                            .padding()
                            .foregroundColor(Color("DarkBrown"))
                        
                        Spacer(minLength: 200)
                        
                        //Bottom Footer of My information
                        Text("HW 1 - Shubhada Martha ECS 189E")
                            .font(.caption)
                            .padding()
                            .foregroundColor(Color("DarkBrown"))
                        
                        Spacer()
                    }
                    .containerRelativeFrame([.horizontal, .vertical])
                    .background(Gradient(colors: [.teal, .cyan, .green]).opacity(0.6))
                    .padding()
                    .fullScreenCover(isPresented: $isActive) {
                            LogInScreenView().environmentObject(self.user)
                        }
                }
                .onAppear(perform: {
                    Task {
                        // Schedule navigation after a delay
                        self.gotoLoginScreen(time:  1.5)
                    }
                })
            }
        }

        func gotoLoginScreen(time: Double) {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(time)) {
                self.isActive = true
            }
        }
}

#Preview {
    LaunchScreenView()
}
