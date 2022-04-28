//
//  File.swift
//  
//
//  Created by Mike Hall on 13/05/2021.
//

import Foundation

public struct SearchResponse: Codable {
    var timed_out: Bool = false
    var hits: SearchHits = SearchHits()
    
    func logResponse(filter: String) {
        hits.hits.filter({
            $0.data.contentType == "SOFTWARE" && $0.data.availability == "Available" && $0.data.title != nil && $0.data.title!.contains(filter)
        }).forEach {item in
            print("... Item ... \(item) \n\n")
        }
    }
    
    func getAvailableGames(filter: String) -> [SearchItem] {
        return hits.hits.filter({
            $0.data.contentType == "SOFTWARE" && $0.data.availability == "Available" && $0.data.title != nil && $0.data.title!.contains(filter)
        })
    }
    
    func getAvailableGames() -> [SearchItem] {
        return hits.hits.filter({
            $0.data.contentType == "SOFTWARE" && $0.data.availability == "Available" && $0.data.title != nil
        })
    }
}

public struct SearchHits: Codable{
    var hits: [SearchItem] = []
    var max_score: Double = 0
    var total: SearchTotals = SearchTotals()
}

public struct SearchTotals: Codable{
    var value: Int? = 0
}

public struct SearchItem: Codable, Hashable {
    public static func == (lhs: SearchItem, rhs: SearchItem) -> Bool {
       return lhs.id == rhs.id
    }
    
public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
}
    
    public var data: ItemData = ItemData()
    public var id: String = ""
    enum CodingKeys: String, CodingKey {
        case data = "_source"
        case id = "_id"
    }
}

public struct ItemData: Codable {
    public var contentType: String? = ""
    public var additionalDownloads: [DownloadData] = []
    public var title: String? = ""
    public var machineType: String? = ""
    public var screens: [ImageData] = []
    public var zxinfoVersion: String? = ""
    public var releases: [ReleaseData] = []
    public var availability: String? = ""
}

public struct DownloadData: Codable {
    public var path: String? = ""
    public var format: String? = ""
    public var language: String? = "en"
    public var type: String? = ""
    public var size: Int? = 0
}

public struct ImageData: Codable {
    public var filename: String? = ""
    public var size: Int? = 0
    public var scrUrl: String? = ""
    public var format: String? = ""
    public var type: String? = ""
    public var title: String? = ""
    public var url: String? = ""
}

public struct ReleaseData: Codable {
    public var releaseSeq: Int? = 0
    public var publishers: [PublisherData] = []
    public var files: [FileData] = []
}

public struct PublisherData: Codable {
  //  var  : String = ""
    public var country: String? = ""
    public var name: String? = ""
    public var labelType: String? = ""
    public var publisherSeq: Int? = 0
}

public struct FileData: Codable, Hashable {

    
public func hash(into hasher: inout Hasher) {
    hasher.combine(path)
}
    public var path: String? = ""
    public var format: String? = ""
    public var origin: String? = ""
    public var type: String? = ""
    public var encodingScheme: String? = ""
    public var size: Int? = 0

    public func fileName() -> String {
        let filePath = path
        let allSections = filePath?.split(separator: "/")
        if let lastSection = allSections?.last, let fName = lastSection.split(separator: ".").first {
return String(fName)
        }
        return "Unknown"
    }
}
