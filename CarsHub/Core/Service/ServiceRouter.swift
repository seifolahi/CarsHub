//
//  ServiceRouter.swift
//  CarsHub
//
//  Created by Hamid reza Seifolahi on 12/31/21.
//

import UIKit

public enum HTTPMethod: String, Encodable {
    case get = "GET"
    case post = "POST"
}

protocol ServiceRouter {
    
    associatedtype ResponseType: Codable
    static var method: HTTPMethod { get }
    static var path: String { get }
    
    func buildRequest(withBase: String) -> URLRequest
}

extension ServiceRouter {
    func buildRequest(withBase: String) -> URLRequest {
        
        guard let url = URL(string: withBase + Self.path) else {
            fatalError("Malformed URL")
        }
        
        let urlReq = URLRequest(url: url)
        
        return urlReq
    }
}
