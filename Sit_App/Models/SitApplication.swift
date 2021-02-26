//
//  SitApplication.swift
//  Sit_App
//
//  Created by YuHuan on 2021/2/26.
//

import Foundation


let Host = "http://127.0.0.1:9971"

class SitApplication {
    
    func test() {
        getFromServer(path: "/account/new", data: nil) { (Str) in
            print(Str)
        }
    }
    
    func getFromServer(path:String,data:[String:AnyObject]?,complete: @escaping (_ data:Data)-> ()) {
        let url = URL(string: Host + path)!
        baseRequest(url: url, data: data, method: "GET") { (data) in
            complete(data)
        }
    }
    
    func postFromServer(path:String,data:[String:AnyObject]?,complete: @escaping (_ data:Data)-> ()) {
        let url = URL(string: Host + path)!
        baseRequest(url: url, data: data, method: "POST") { (data) in
            complete(data)
        }
    }
    
    func baseRequest(url:URL,data:[String:AnyObject]?,method: String,complete: @escaping (_ data:Data)-> ()) {
        var request = URLRequest(url: url)
        request.httpMethod = method
        URLSession.shared.dataTask(with: request) { (data, res, err) in
            guard let data = data else { return }
            complete(data)
        }.resume()
    }
    
    
}


