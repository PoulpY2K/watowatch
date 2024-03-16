//
//  DetailSheetView.swift
//  Watowatch
//
//  Created by Jérémy Laurent on 16/03/2024.
//

import Foundation
import SwiftUI

struct DetailSheetView: View {
    // MARK: - PROPERTIES
    var movie: Movie
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Text("LMAO")
        }
    }
}

#Preview {
    DetailSheetView(
        movie: Movie(id: 3, title: "Le Château Déambulant")
    )
}
