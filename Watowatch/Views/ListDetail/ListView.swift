//
//  ListView.swift
//  Watowatch
//
//  Created by Jérémy Laurent on 01/04/2024.
//

import SwiftUI
import SwiftData

struct ListView: View {
    // MARK: - PROPERTIES
    @Query var userList: [UserList]
    @Environment(\.modelContext) private var modelContext
    
    // MARK: - BODY
    var body: some View {
        List(userList) { list in
            NavigationLink(list.name, destination: ListDetailView(list: list))
        }.modelContainer(PreviewSampleData.previewContainer)
    }
}

#Preview {
    MainActor.assumeIsolated {
        ListView()
                .modelContainer(PreviewSampleData.previewContainer)
        }
}
