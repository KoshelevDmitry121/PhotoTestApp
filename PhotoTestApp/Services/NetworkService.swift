//
//  NetworkService.swift
//  PhotoTestApp
//
//  Created by Dmitry Koshelev on 02.09.2023.
//

import Foundation

enum NetworkHTTPMethod: String {
    case options = "OPTIONS"
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    case trace = "TRACE"
    case connect = "CONNECT"
}

struct NetworkTarget {
    let baseURL: URL
    let path: String
    let httpMethod: NetworkHTTPMethod
}

protocol NetworkServiceInterface {
    func asyncTask<T: Decodable>(target: NetworkTarget) async -> T?
}

struct NetworkService: NetworkServiceInterface {
    
    func asyncTask<T: Decodable>(target: NetworkTarget) async -> T? {
        let url = target.baseURL.appendingPathComponent(target.path)
        var request = URLRequest(url: url)
        request.httpMethod = target.httpMethod.rawValue
        
        guard let (data, response) = try? await URLSession.shared.data(for: request),
              let response = response as? HTTPURLResponse else { return nil }
        
        let statusCode = response.statusCode
        switch statusCode {
        case 200..<299:
            return try? JSONDecoder().decode(T.self, from: data)
        default:
            return nil
        }
    }
    
}
