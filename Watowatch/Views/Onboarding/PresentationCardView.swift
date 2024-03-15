//
//  PresentationCardView.swift
//  Watowatch
//
//  Created by Jérémy Laurent on 15/03/2024.
//

import Foundation
import SwiftUI

struct PresentationCardView: View {
    // MARK: - PROPERTIES
    
    var presentation: Presentation
    
    @State private var isAnimating: Bool = false
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                if presentation.image != nil {
                    // presentation: IMAGE
                    Image(presentation.image!)
                        .resizable()
                        .scaledToFit()
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
                        .scaleEffect(isAnimating ? 1.0 : 0.6)
                }
                
                Text(presentation.emoji)
                    .foregroundColor(Color.white)
                    .font(.system(size: 108))
                    .fontWeight(.heavy)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
                
                // presentation: TITLE
                Text(presentation.title)
                    .foregroundColor(Color.white)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
                
                // presentation: HEADLINE
                Text(presentation.headline)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                    .frame(maxWidth: 480)
                
                // BUTTON: START
                StartButtonView().padding(.top, 50)
            } //: VSTACK
            .frame(maxHeight: .infinity, alignment: .center)
            
        } //: ZSTACK
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) {
                isAnimating = true
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(LinearGradient(gradient: Gradient(colors: presentation.gradientColors), startPoint: .top, endPoint: .bottom))
        .ignoresSafeArea()
        
    }
}

#Preview {
    PresentationCardView(presentation: presentationData[0])
}
