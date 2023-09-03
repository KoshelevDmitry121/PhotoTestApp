//
//  NetworkService.swift
//  PhotoTestApp
//
//  Created by Dmitry Koshelev on 02.09.2023.
//

import UIKit

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
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else { return nil }
            let statusCode = response.statusCode
            
            switch statusCode {
            case 200..<299:
                do {
                    return try JSONDecoder().decode(T.self, from: data)
                } catch {
                    await showError(title: "Error", message: error.localizedDescription)
                    return nil
                }
            default:
                await showError(title: "Error", message: "statusCode - \(statusCode)")
                return nil
            }
        } catch {
            await showError(title: "Error", message: error.localizedDescription)
            return nil
        }
    }
    
    private func showError(title: String, message: String) async {
        let alertController = await UIAlertController(title: title, message: message, preferredStyle: .alert)
        await alertController.addAction(
            UIAlertAction(
                title: "Ok",
                style: .cancel
            )
        )
        
        var rootViewController = await UIApplication.shared.keyWindow?.rootViewController
        if let navigationController = rootViewController as? UINavigationController {
            rootViewController = await navigationController.viewControllers.first
        }
        if let tabBarController = rootViewController as? UITabBarController {
            rootViewController = await tabBarController.selectedViewController
        }
        await rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
}
