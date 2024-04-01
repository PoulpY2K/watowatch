//
//  PreviewSampleData.swift
//  Watowatch
//
//  Created by Jérémy Laurent on 01/04/2024.
//

import SwiftData

@MainActor
class PreviewSampleData {
    static let previewContainer: ModelContainer = {
            do {
                let config = ModelConfiguration(isStoredInMemoryOnly: true)
                let container = try ModelContainer(for: UserList.self, configurations: config)

                for i in 1...9 {
                    let userList = UserList(name: "Example UserList \(i)", movies: [Movie(id: i, title: "Le film \(i)")], thumbnailURL: "photo \(i)")
                    container.mainContext.insert(userList)
                }

                return container
            } catch {
                fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
            }
        }()
}
