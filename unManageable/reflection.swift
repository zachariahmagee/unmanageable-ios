//
//  Item.swift
//  unManageable
//
//  Created by Zachariah Magee on 10/25/23.
//

import Foundation
import SwiftData

@Model
class Reflection : Codable {
    
    enum CodingKeys: CodingKey {
        case month
        case day
        case title
        case quotation
        case citation
        case reading
    }
    
    let month: String
    let day: Int
    let title: String
    let quotation: String
    let citation: String
    let reading: String
//    var ordered: Float
    
    
    init(month: String, day: Int, title: String, quotation: String, citation: String, reading: String) {
        self.month = month
        self.day = day
        self.title = title
        self.quotation = quotation
        self.citation = citation
        self.reading = reading
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.month = try container.decode(String.self, forKey: .month)
        self.day = try container.decode(Int.self, forKey: .day)
        self.title = try container.decode(String.self, forKey: .title)
        self.quotation = try container.decode(String.self, forKey: .quotation)
        self.citation = try container.decode(String.self, forKey: .citation)
        self.reading = try container.decode(String.self, forKey: .reading)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(month, forKey: .month)
        try container.encode(day, forKey: .day)
        try container.encode(title, forKey: .title)
        try container.encode(quotation, forKey: .quotation)
        try container.encode(citation, forKey: .citation)
        try container.encode(reading, forKey: .reading)
    }
    
    init?(json: [String: Any]) {
        guard let month = json["month"] as? String,
              let day = json["day"] as? Int,
              let title = json["title"] as? String,
              let quotation = json["quotation"] as? String,
              let citation = json["citation"] as? String,
              let reading = json["reading"] as? String
        else {
            return nil
        }
        
        
        self.month = month.lowercased().capitalized
        self.day = day
        self.title = title
        self.quotation = quotation
        self.citation = citation
        self.reading = reading
    }
    
    func getOrder() -> Float {
        var order: Float = 0.0
        var m: Float = 0.0
        switch (self.month.lowercased().capitalized) {
        case "January":
            m = 1
            break
        case "February":
            m = 2
            break
        case "March":
            m = 3
            break
        case "April":
            m = 4
            break
        case "May":
            m = 5
            break
        case "June":
            m = 6
            break
        case "July":
            m = 7
            break
        case "August":
            m = 8
            break
        case "September":
            m = 9
            break
        case "October":
            m = 10
            break
        case "November":
            m = 11
            break
        case "December":
            m = 12
            break
        default:
            break
        }
        let addDay = (Float(self.day) / 100.0)
        order = m + addDay

        return order
    }
}

@Model
class BigBook: Codable {
    enum CodingKeys: CodingKey {
        case chapter
        case title
        case paragraph
        case body
    }
    
    let chapter: String
    let title: String
    let paragraph: Int
    let body: String
    
    init(chapter: String, title: String, paragraph: Int, body: String) {
        self.chapter = chapter
        self.title = title
        self.paragraph = paragraph
        self.body = body
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.chapter = try container.decode(String.self, forKey: .chapter)
        self.title = try container.decode(String.self, forKey: .title)
        self.paragraph = try container.decode(Int.self, forKey: .paragraph)
        self.body = try container.decode(String.self, forKey: .body)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(chapter, forKey: .chapter)
        try container.encode(title, forKey: .title)
        try container.encode(paragraph, forKey: .paragraph)
        try container.encode(body, forKey: .body)
    }
    
    func getOrder() -> Float {
        let c = Float(chapter)
        let p = Float(paragraph) / 100
        let order = c! + p
        return order
    }
    
}

private func readLocalJsonFile(file resource: String) -> Data? {
    do {
        if let filepath = Bundle.main.path(forResource: resource, ofType: "json") {
            let fileURL = URL(fileURLWithPath: filepath)
            let data = try Data(contentsOf: fileURL)
            return data
        }
    } catch {
        print("error \(error)")
    }
    return nil
}
