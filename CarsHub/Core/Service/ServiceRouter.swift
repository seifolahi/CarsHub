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
    
    associatedtype ResponseType: Decodable
    var method: HTTPMethod { get }
    var path: String { get }
    
    var pagination: ServicePagination? { get set }
    var urlParams: [String: String]? { get set }
    
    func buildRequest(withBase: String, token: String?) -> URLRequest
}

extension ServiceRouter {
    func buildRequest(withBase: String, token: String?) -> URLRequest {
        
        guard let url = makeUrl(withBase: withBase, token: token) else {
            fatalError("Malformed URL")
        }
        
        var urlReq = URLRequest(url: url)
        urlReq.httpMethod = method.rawValue
        
        return urlReq
    }
    
    private func makeUrl(withBase: String, token: String?) -> URL? {
        
        var queryItem: [URLQueryItem] = []
        var components = URLComponents()
        
        if let token = token {
            queryItem.append(URLQueryItem(name: "wa_key", value: token))
        }
        
        if let pagination = pagination {
            queryItem.append(URLQueryItem(name: "page", value: "\(pagination.page)"))
            queryItem.append(URLQueryItem(name: "pageSize", value: "\(pagination.pageSize)"))
        }
        
        if let urlParams = urlParams {
            urlParams.keys.forEach { key in
                queryItem.append(URLQueryItem(name: key,
                                              value: "\(urlParams[key] ?? "")"))
            }
        }
        
        components.queryItems = queryItem
        
        let urlGetParams = components.url?.absoluteString ?? ""
        let urlString = withBase + path + urlGetParams
        
        return URL(string: urlString)
    }
}

struct ServicePagination {
    var pageSize: Int
    var page: Int
}
