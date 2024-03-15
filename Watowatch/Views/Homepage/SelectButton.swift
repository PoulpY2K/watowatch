//
//  SelectButton.swift
//  Watowatch
//
//  Created by Stéphane Humblot on 15/03/2024.
//

import SwiftUI

struct SelectButton: View {
    var isSelected: Bool
    @State var color: Color
    @State var text: String
    
    var body: some View {
        ZStack {
            Capsule()
                .frame(height: 40)
                .foregroundColor(isSelected ? color : .gray)
            Text(text)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    SelectButton(isSelected: false, color: .blue, text: "Select")
}
