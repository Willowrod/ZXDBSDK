//
//  Network.swift
//  ZXDB-SDK
//
//  Created by Mike Hall on 11/05/2021.
//

import Foundation

public class Network {
    public static let common: Network = Network()
    
//
    
    public func get<T: Codable>(_ url: String, completion: ((Result<T, ZXDBError>) -> Void)?) {
        logNetwork(data: "URL: \(url)")
        guard let validURL = URL(string: url.replacingOccurrences(of: " ", with: "%20")) else {
            logError(data: "Invalid URL requested...... \(url)")
            let error = ZXDBError.init(message: "Invalid URL requested - \(url)")
            completion?(.failure(error))
            return
        }
        let session = URLSession(configuration: .default)
        var urlRequest = URLRequest(url: validURL)
        urlRequest.httpMethod = "GET"
        let request = session.dataTask(with: urlRequest) {data, response, error in
            if let err = error {
                DispatchQueue.main.async {
                    let streamError = ZXDBError.init(message: err.localizedDescription)
                    if let httpResponse = response as? HTTPURLResponse {
                        streamError.code = httpResponse.statusCode
                        }
                    logError(data: streamError.getMessages())
                    completion?(.failure(streamError))
                }
                return
                       }
            
            guard response != nil, let data = data else {
                return
            }
            
            DispatchQueue.main.async {
                do {
                    let responseObject = try JSONDecoder().decode(T.self, from: data)
                completion?(.success(responseObject))
                } catch {
                    logError(data: error.localizedDescription)
                }
            }
            
        }
        request.resume()
    }
    
    public func download(url: URL, completion: @escaping (String?, ZXDBError?) -> Void)
    {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)

        if FileManager().fileExists(atPath: destinationUrl.path)
        {
            print("File already exists [\(destinationUrl.path)]")
            completion(destinationUrl.path, nil)
        }
        else if let dataFromURL = NSData(contentsOf: url)
        {
            if dataFromURL.write(to: destinationUrl, atomically: true)
            {
                print("file saved [\(destinationUrl.path)]")
                completion(destinationUrl.path, nil)
            }
            else
            {
                print("error saving file")
                let error = ZXDBError(code: 1001, message: "Error saving file")  
                completion(destinationUrl.path, error)
            }
        }
        else
        {
            let error = ZXDBError(code: 1002, message: "Error downloading file")
            completion(destinationUrl.path, error)
        }
    }
}
 
