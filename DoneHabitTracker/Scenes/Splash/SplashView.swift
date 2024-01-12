//
//  SplashView.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 11/1/24.
//

import SwiftUI

struct SplashView: View {
    
    @Binding var showSplash: Bool
    @EnvironmentObject private var appModel: ApplicationModel

    var body: some View {
        VStack {
            Image("logo")
            Text("Done App Splash")
                .font(.largeTitle)
                .bold()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    showSplash = false
                }
            }
        }
    }
}

#Preview {
    SplashView(showSplash: .constant(true))
}
