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
}

public struct SearchItem: Codable {
    var data: ItemData = ItemData()
    var id: String = ""
    enum CodingKeys: String, CodingKey {
        case data = "_source"
        case id = "_id"
    }
}

public struct ItemData: Codable {
    var contentType: String? = ""
    var additionalDownloads: [DownloadData] = []
    var title: String? = ""
    var machineType: String? = ""
    var screens: [ImageData] = []
    var zxinfoVersion: String? = ""
    var releases: [ReleaseData] = []
    var availability: String? = ""
}

public struct DownloadData: Codable {
    var path: String? = ""
    var format: String? = ""
    var language: String? = "en"
    var type: String? = ""
    var size: Int = 0
}

public struct ImageData: Codable {
    var filename: String? = ""
    var size: Int = 0
    var scrUrl: String? = ""
    var format: String? = ""
    var type: String? = ""
    var title: String? = ""
    var url: String? = ""
}

public struct ReleaseData: Codable {
    var releaseSeq: Int = 0
    var publishers: [PublisherData] = []
    var files: [FileData] = []
}

public struct PublisherData: Codable {
  //  var  : String = ""
    var country: String? = ""
    var name: String? = ""
    var labelType: String? = ""
    var publisherSeq: Int = 0
}

public struct FileData: Codable {
    var path: String? = ""
    var format: String? = ""
    var origin: String? = ""
    var type: String? = ""
    var encodingScheme: String? = ""
    var size: Int = 0
}
