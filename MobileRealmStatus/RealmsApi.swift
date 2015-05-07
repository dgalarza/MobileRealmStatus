//
//  RealmsApi.swift
//  MobileRealmStatus
//
//  Created by Damian Galarza on 5/4/15.
//  Copyright (c) 2015 dgalarza. All rights reserved.
//

import Foundation

class RealmsApi {
    let requestUrl = "http://us.battle.net/api/wow/realm/status"
    let session: NSURLSession
    
    init() {
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        sessionConfiguration.timeoutIntervalForRequest = 30.0
        sessionConfiguration.timeoutIntervalForResource = 30.0
        
        session = NSURLSession(configuration: sessionConfiguration)
    }
    
    func realmStatus(callback: ([Realm]) -> Void) {
        if let url = NSURL(string: requestUrl) {
            let request = NSURLRequest(URL: url)
            let task = session.dataTaskWithRequest(request) { (data, response, error) in
                var jsonErrorOptional: NSError?
                let jsonOptional: AnyObject? = NSJSONSerialization.JSONObjectWithData(
                    data,
                    options: NSJSONReadingOptions(0),
                    error: &jsonErrorOptional
                )
                
                if let json = jsonOptional as? [String: [[String: AnyObject]]] {
                    if let realmsJson = json["realms"] {
                        var realms = [Realm]()
                        for realmJson in realmsJson {
                            if let realm = self.parseRealm(realmJson) {
                                realms.append(realm)
                            }
                        }
                        
                        callback(realms)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    private func parseRealm(realmJson: [String: AnyObject]) -> Realm? {
        if let name = realmJson["name"] as? String {
            if let type = realmJson["type"] as? String {
                if let status = realmJson["status"] as? Bool {
                    return Realm(name: name, type: type, status: status)
                }
            }
        }
        
        return nil
    }
}