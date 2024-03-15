//
//  Presentation.swift
//  Watowatch
//
//  Created by Jérémy Laurent on 15/03/2024.
//

import Foundation
import SwiftUI

// MARK: - PRESENTATION DATA MODEL

struct Presentation: Identifiable {
    var id = UUID()
    var title: String
    var headline: String
    var image: String?
    var emoji: String
    var gradientColors: [Color]
}
