//
//  ConnectionManager.swift
//  For Qantas Loyalty
//
//  Created by Dmitrii Zverev on 26/6/18.
//  Copyright © 2018 Dmitrii Zverev. All rights reserved.
//

import Foundation

import Foundation
import UIKit

enum JSONError: String, Error {
    case NoData = "ERROR: No data"
    case ConversionFailed = "ERROR: conversion from JSON failed"
}


struct ImageLoader {
    var imageLoadingDataTask: URLSessionDataTask?
    mutating func downloadImageFrom(urlString: String, completion: @escaping (UIImage?)->()) {
        imageLoadingDataTask?.cancel()
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        if let cachedImage = Constants.imageCache.object(forKey:  url.absoluteString as NSString) {
            completion(cachedImage)
            return
        }
        imageLoadingDataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {completion(nil)}
                return
            }
            let img = UIImage(data: data)
            DispatchQueue.main.async {
                completion(img)
                if img != nil {
                    Constants.imageCache.setObject(img!, forKey:  url.absoluteString as NSString)
                }
            }
        }
        imageLoadingDataTask?.resume()
    }
}

import Foundation

struct SearchResults: Codable {
    var allRecipes: [Recipe]
}

struct Recipe: Codable {
    var title: Int
    var href: String
    var ingredients: String
    var thumbnail: String

    var hrefUrl: URL? {
        return URL(string: self.href)
    }
    var imageUrl: URL? {
        return URL(string: self.thumbnail)
    }
    
}



struct ConnectionManager {
    static let recipesBaseUrl = "https://g525204.github.io/recipes.json."
    
    static func getRecipes(completion: @escaping (_ recipes: [Recipe], _ errorMessage: String)->()) {
        guard let url = URL(string: recipesBaseUrl) else {
            completion([], "Error creating url")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                guard let data = data else {
                    throw JSONError.NoData
                }
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let jsonSearchResults  = try? decoder.decode(SearchResults.self, from: data) else {
                    throw JSONError.ConversionFailed
                }
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    completion(jsonSearchResults.allRecipes, "")
                }
            } catch let error as JSONError {
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    completion([], error.rawValue)
                }
            } catch let error as NSError {
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    completion([], error.debugDescription)
                }
            }
        }.resume()
    }
    
}
