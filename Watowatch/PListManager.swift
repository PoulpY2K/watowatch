//
//  PListManager.swift
//  Watowatch
//
//  Created by Jérémy Laurent on 15/03/2024.
//

import Foundation

struct ConfigData: Codable {
    let apiKey: String
    
    enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
    }
}

class ConfigurationManager {
    
    static var instance = ConfigurationManager()
    
    internal let plistDictionnary: ConfigData
    
    init() {
        let url = Bundle.main.url(forResource: "environment", withExtension:"plist")!
        do {
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode(ConfigData.self, from: data)
            self.plistDictionnary = result
        } catch { fatalError("Could not boot app without configuration plist") }
    }
}
