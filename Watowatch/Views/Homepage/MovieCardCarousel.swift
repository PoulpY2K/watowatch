//
//  MovieCardCarousel.swift
//  Watowatch
//
//  Created by Stéphane Humblot on 15/03/2024.
//

import SwiftUI

struct MovieCardCarousel: View {
    
    @State private var currentIndex = 0
    
    var cards: [MovieCard]
    var height: CGFloat
    var width: CGFloat
    
    var body: some View {
        VStack(spacing: 0) {
            
            TabView(selection: $currentIndex) {
                ForEach(0..<cards.count, id: \.self) { cardIndex in
                    let card = cards[cardIndex]
                    //  @TODO: Complete with proper data and actions
                    VStack {
                        Text("Card")
                    }
                    .frame(maxWidth: width, maxHeight: height)
                    .cornerRadius(20)
                    .tag(cardIndex)
                    .background(card.colors.randomElement())
                }
            }.tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
        .frame(maxWidth: .infinity)
        
    }
}
