//
//  MovieCardCarousel.swift
//  Watowatch
//
//  Created by Stéphane Humblot on 15/03/2024.
//

import SwiftUI
import CoreMotion

struct MovieCardCarousel: View {
    @State private var currentIndex = 0
    @StateObject private var motion = MotionManager()
    @StateObject var feedState = FeedState()
    @Binding var selectedMovie: Movie?
    
    var cards: [MovieCard]
    var height: CGFloat
    var width: CGFloat
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentIndex) {
                ForEach(Array(cards.enumerated()), id: \.element) { index, card in
                    //  @TODO: Complete with proper data and actions
                    AsyncImage(url: TMDBService().getImageUrl(path: card.movie.posterPath?.absoluteString ?? "")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } placeholder: {
                        ProgressView().tint(.white).scaleEffect(1.5, anchor: .center).frame(width: width, height: height).background(.gray).clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    .frame(maxWidth: width, maxHeight: height)
                    .tag(index)
                    .onTapGesture {
                        self.selectedMovie = card.movie
                    }
                }
            }.tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
        .frame(maxWidth: .infinity)
        .rotation3DEffect(
            Angle(degrees: motion.y * 15), axis: (x: 1.0, y: 0.0, z: 0.0)
        )
        .rotation3DEffect(
            Angle(degrees: motion.x * 15), axis: (x: 0.0, y: 1.0, z: 0.0)
        )
    }
}
