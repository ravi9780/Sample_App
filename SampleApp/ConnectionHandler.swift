//
//  ConnectionHandler.swift
//  SampleApp
//

import Foundation

class ConnectionHandler {
    func startConnection(withUrlString urlString: String, completion: @escaping (Data?, APIError?) -> ()) {
        guard let url = URL(string: urlString) else {
            Logger.error("Invalid request URL")
            completion(nil, APIError.InvalidRequestURL)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(nil, APIError.reason(error.localizedDescription))
                }
            } else {
                DispatchQueue.main.async {
                    completion(data, nil)
                }
            }
        }.resume()
    }
}
