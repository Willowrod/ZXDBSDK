//
//  Logger.swift
//  ZXDB-SDK
//
//  Created by Mike Hall on 11/05/2021.
//

import Foundation

public enum LogType {
    case ALL, NETWORK, LISTS, BOOLVALUES, STANDARD
}

func log(data: String, tag: String = "ZXDB-SDK") {
    Logger.instance.log(entry: data, tag: tag)
}

func logNetwork(data: String, tag: String = "ZXDB-SDK") {
    Logger.instance.logNetwork(entry: data, tag: tag)
}

func logList(data: String, tag: String = "ZXDB-SDK") {
    Logger.instance.logList(entry: data, tag: tag)
}

func logBool(data: Bool, description: String, tag: String = "ZXDB-SDK") {
    Logger.instance.logBool(condition: data, description: description, tag: tag)
}

func logError(data: String?, tag: String = "ZXDB-SDK") {
    Logger.instance.logError(entry: data, tag: tag)
}

class Logger {
    
    public static let instance: Logger = Logger()
    
    private var LOGGIN_ON = true 
    private var LOG_STANDARD = true
    private var LOG_ERRORS = true
    private var LOG_NETWORK = true
    private var LOG_LISTS = true
    private var LOG_BOOLS = true
    
    func turnLoggingOff(){
            LOGGIN_ON = false
            LOG_STANDARD = false
            LOG_ERRORS = true
            LOG_NETWORK = false
            LOG_LISTS = false
            LOG_BOOLS = false
        }

    func turnLoggingOn(){
            LOGGIN_ON = true
            LOG_STANDARD = true
            LOG_ERRORS = true
            LOG_NETWORK = true
            LOG_LISTS = true
            LOG_BOOLS = true
        }
    
    func setLoggingForComponents(shouldLog: Bool, components: [LogType]){
            if (shouldLog){
                LOGGIN_ON = true
            }
        components.forEach{ type in
            switch type {
            case .ALL:
                      if (shouldLog) {
                          turnLoggingOn()
                      } else {
                          turnLoggingOff()
                      }
                return
            case .NETWORK:
            LOG_NETWORK = shouldLog
            case .BOOLVALUES:
            LOG_BOOLS = shouldLog
            case .LISTS:
            LOG_LISTS = shouldLog
            case .STANDARD:
            LOG_STANDARD = shouldLog
                }
            }
        }
    
    func log(entry: String) {
        if (logsNormalLogEntries()) {
            print(entry)
        }
    }
    
    func log(entry: String, tag: String = "ZXDB-SDK") {
        if (logsNormalLogEntries()) {
            log(entry: "▶️ - \(tag): \(entry)")
        }
    }
    
    func logBool(condition: Bool, description: String, tag: String = "ZXDB-SDK") {
        if (logsBools()) {
            log(entry: "❓ - \(tag): \(description): \(condition ? "TRUE" : "FALSE")")
        }
    }
    
    func logNetwork(entry: String, tag: String = "ZXDB-SDK") {
        if (logsNetworkEntries()) {
            log(entry: "🔃 - \(tag): \(entry)")
        }
    }
    
    func logList(entry: String, tag: String = "ZXDB-SDK") {
        if (logsLists()) {
            log(entry: "🔽 - \(tag): \(entry)")
         }
    }
    
    func logError(entry: String?, tag: String = "ZXDB-SDK") {
        if (logsErrors()) {
            if let error = entry {
            log(entry: "⛔️ - \(tag): \(error)")
            } else {
            log(entry: "⛔️ - \(tag): An unknown error occurred")
            }
        }
    }
    
    internal func logsNormalLogEntries() -> Bool {
        return LOGGIN_ON && LOG_STANDARD
    }

    internal func logsErrors() -> Bool {
        return LOG_ERRORS
    }
    
    internal func logsBools() -> Bool {
        return LOGGIN_ON && LOG_BOOLS
    }

    internal func logsNetworkEntries() -> Bool {
        return LOGGIN_ON && LOG_NETWORK
    }

    internal func logsLists() -> Bool {
        return LOGGIN_ON && LOG_LISTS
    }
    
}
