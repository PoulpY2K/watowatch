//
//  OnboardingView.swift
//  Watowatch
//
//  Created by Jérémy Laurent on 13/03/2024.
//

import SwiftUI

struct OnboardingView: View {
    // MARK: - PROPERTIES

    var presentations: [Presentation] = presentationData

    // MARK: - BODY
    var body: some View {
        TabView {
            ForEach(presentations) { item in
                PresentationCardView(presentation: item)
            } //: LOOP
        } //: TAB
        .tabViewStyle(PageTabViewStyle())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
    }
}

#Preview {
    OnboardingView()
}
