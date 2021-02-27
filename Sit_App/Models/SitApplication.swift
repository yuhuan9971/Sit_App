//
//  SitApplication.swift
//  Sit_App
//
//  Created by YuHuan on 2021/2/26.
//

import Foundation


let Host = "http://127.0.0.1:9971"

class SitApplication {
    
    static let shared = SitApplication()
    
    func getFromServer(path:String,data:[String:AnyObject]?,complete: @escaping (_ data:Data)-> ()) {
        let queryString = self.getPostString(params: data ?? [:])
        print(queryString)
        let url = URL(string: Host + path + (queryString != "" ? "?\(queryString)" : ""))!
        baseRequest(url: url, data: data, method: "GET") { (data) in
            complete(data)
        }
    }
    
    func postToServer(path:String,data:[String:AnyObject]?,complete: @escaping (_ data:Data)-> ()) {
        let url = URL(string: Host + path)!
        baseRequest(url: url, data: data, method: "POST") { (data) in
            complete(data)
        }
    }
    
    func baseRequest(url:URL,data:[String:AnyObject]?,method: String,complete: @escaping (_ data:Data)-> ()) {
        do {
            var request = URLRequest(url: url)
            request.httpMethod = method
            if (method != "GET" && data != nil) {
                let data = try JSONSerialization.data(withJSONObject: data, options: .init())
                request.httpBody = data
            }
            request.setValue("application/json", forHTTPHeaderField: "content-type")
            URLSession.shared.dataTask(with: request) { (data, res, err) in
                guard let data = data else { return }
                complete(data)
            }.resume()
        }catch {
            print(error)
        }
    }
    
    func getPostString(params:[String:AnyObject]) -> String {
        var data = [String]()
        for(key, value) in params {
            let key = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let value = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }

    
}


