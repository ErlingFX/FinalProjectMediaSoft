//
//  WebService.swift
//  FinalProjectMediaSoft
//
//  Created by Alexander Nazarov on 03.05.2021.
//

import Foundation
import RxSwift
import RxCocoa

enum RequestError: Error {
    case invalidParameter(String, Any)
    case invalidURL(String)
}


protocol Requestable {
    func request(host: String, endpoint: String, query: [String: Any]) -> Observable<[String: Any]>
}


class WebService: Requestable {
    
    var urlSession: URLSession // Can add abstraction layer for mocking
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func request(host: String, endpoint: String, query: [String : Any]) -> Observable<[String : Any]> {
        do {
            guard let url = URL(string: host),
                  var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                throw RequestError.invalidURL(endpoint)
            }
            
            components.queryItems = try query.compactMap { (key, value) in
                guard let v = value as? CustomStringConvertible else {
                    throw RequestError.invalidParameter(key, value)
                }
                
                return URLQueryItem(name: key, value: v.description)
            }
            
            guard let finalURL = components.url else {
                throw RequestError.invalidURL(endpoint)
            }
            
            let request = URLRequest(url: finalURL)
            
            return urlSession.rx.response(request: request)
                .map { _, data in
                    guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
                          let result = jsonObject as? [String: Any] else {
                        return [:]
                    }
                    return result
                }
        } catch {
            return Observable.empty()
        }
    }
}

