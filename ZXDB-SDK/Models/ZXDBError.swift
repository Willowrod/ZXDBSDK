//
//  ZXDBError.swift
//  ZXDB-SDK
//
//  Created by Mike Hall on 11/05/2021.
//

import Foundation

public class ZXDBError: Error{
    var code: Int = -1
    
    var messages: [String] = []
    
    /**
      Create a new error model with a defined error message
     * @param message An error message
     */
    public init(message: String) {
        addMessage(message: message)
    }
    /**
      Add a new error message to the array of messages
     * @param message An error message
     */
    public func addMessage(message: String){
        messages.append(message)
    }
    
    /**
      Returns all error messages as an array of Strings
     */
    public func getAllMessages() -> [String]{
        return messages
    }
    
    /**
      Returns an error code - generally HTTP - for a failed call
     * Returns -1 if no code is available
     */
    public func getErrorCode() -> Int{
        return code
    }
    
    /**
      Returns all error messages as a single concatted String
     */
    public func getMessages() -> String {
            var errorMessage: String = ""
        messages.forEach{message in
                    if (errorMessage != ""){
                            errorMessage += " | "
                    }
                    errorMessage += message
            }
            if (errorMessage == ""){
                    errorMessage = "No messages reported by API"
            }
            return errorMessage
    }
}
