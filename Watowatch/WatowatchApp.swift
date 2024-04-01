//
//  WatowatchApp.swift
//  Watowatch
//
//  Created by Jérémy Laurent on 13/03/2024.
//

import SwiftUI
import TMDb

@main
struct WatowatchApp: App {
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
        
    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                OnboardingView()
            } else {
                ContentView()
            }
        }
    }
}
