//
//  ZXDB.swift
//  ZXDB-SDK
//
//  Created by Mike Hall on 11/05/2021.
//

import Foundation

public class ZXDB {
    
    let pageSize = 12
    
    let SEARCHURL = "https://api.zxinfo.dk/v3/search?mode=full&sort=rel_desc&"
    
    public init() {}
    
    public static var shared = ZXDB()
    
    var currentFormatType = ""
    
    var currentSearchTerm = ""
    
    var currentOffset = 0
    
    var totalItems = 0
    
    public func next(completion: @escaping (([SearchItem]) -> Void)) {
        if totalItems <= 0 {
            currentOffset = 0
        } else if (currentOffset + 1) * pageSize < totalItems {
            currentOffset += 1
        } else {
            currentOffset = Int(totalItems/pageSize)
        }
        search(currentSearchTerm, offset: currentOffset, format: currentFormatType, completion: completion)
    }
    
    public func previous(completion: @escaping (([SearchItem]) -> Void)) {
        if totalItems <= 0 {
            currentOffset = 0
        } else if (currentOffset - 1) >= 0 {
            currentOffset -= 1
        } else {
            currentOffset = 0
        }
        search(currentSearchTerm, offset: currentOffset, format: currentFormatType, completion: completion)
    }
    
    public func reset(){
        totalItems = 0
        currentOffset = 0
        currentSearchTerm = ""
    }
    
    public func search(_ query: String, offset: Int = 0, format: String = "tzx", completion: @escaping (([SearchItem]) -> Void)) {
        currentSearchTerm = query
        currentOffset = offset
        currentFormatType = format
        let url = "\(SEARCHURL)offset=\(offset)&size=\(pageSize)&tosectype=\(currentFormatType)&query=\(query)"
        Network.common.get(url) { (result: Result<SearchResponse, ZXDBError>) in
            switch result {
            case .success(let data):
                data.logResponse(filter: query)
                self.totalItems = data.hits.total.value ?? 0
                completion(data.hits.hits)
            case .failure(let error):
                print(error.getMessages())
                completion([])
            }
        }
    }
    
//    public func asyncSearch(_ query: String) async throws -> [SearchItem] {
//        return try await Network.common.getItems("\(SEARCHURL)\(query)")
//    }
}
