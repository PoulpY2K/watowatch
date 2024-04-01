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
            VStack {
                if (!userList.isEmpty) {
                    List(userList) { list in
                        NavigationLink(list.name, destination: ListDetailView(list: list))
                    }
                } else {
                    Text("Aucune liste trouvée...")
                }
            }
        .navigationTitle("Listes")
    }
}

#Preview {
    MainActor.assumeIsolated {
        ListView()
            .modelContainer(PreviewSampleData.previewContainer)
    }
}
