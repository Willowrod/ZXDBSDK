//
//  ZXDB.swift
//  ZXDB-SDK
//
//  Created by Mike Hall on 11/05/2021.
//

import Foundation

public class ZXDB {
    
    let SEARCHURL = "https://api.zxinfo.dk/v3/search?mode=full&size=25&offset=0&sort=rel_desc&query="
    
    public init() {}
    
    public func search(_ query: String) {
        Network.common.get("\(SEARCHURL)\(query)") { (result: Result<SearchResponse, ZXDBError>) in
            switch result {
            case .success(let data):
                data.logResponse(filter: query)
            case .failure(let error):
                print(error.getMessages())
            }
        }
    }
    
    public func asyncSearch(_ query: String) async throws -> [SearchItem] {
        return try await Network.common.getItems("\(SEARCHURL)\(query)")
    }
}
