//
//  NetworkDataFetcher.swift
//  JSON
//
//  Created by Vladimir Pisarenko on 20.06.2022.
//

import Foundation

class NetworkDataFetcher {
    
    let networkService = NetworkService()
    
    func fetchTracks(urlString: String, response: @escaping (SearchResponse?) -> Void) {
        
        networkService.request(urlString: urlString) { result in
            switch result {
                
            case .success(let data):
                do {
                    let tracks = try JSONDecoder().decode(SearchResponse.self, from: data)
                    response(tracks)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    response(nil)
                }
            case .failure(let error):
                response(nil)
            }
        }
        
        
        
        
        
    }
}
