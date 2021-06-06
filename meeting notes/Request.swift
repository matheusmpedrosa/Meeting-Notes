//
//  Request.swift
//  meeting notes
//
//  Created by Matheus Pedrosa on 05/06/21.
//

import Foundation

open class Request {
    
    // MARK: - Properties
    
    private let session: URLSession = URLSession.shared
    
    // MARK: - Fetch Array
    
    func fetch<T: Decodable>(target: API, model: T.Type, completion: @escaping (Result<[T], Error>) -> Void) {
        guard let url: URL = URL(string: target.path) else { return }
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = K.HTTPMethod.get
        
        session.dataTask(with: request) { (data, _, error) in
            guard let data = data else { return }
            do {
                let jsonDecoder = JSONDecoder()
                let response = try jsonDecoder.decode([T].self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // MARK: - Fetch Object
    
    func fetch<T: Decodable>(target: API, model: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url: URL = URL(string: target.path) else { return }
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = K.HTTPMethod.get
        
        session.dataTask(with: request) { (data, _, error) in
            guard let data = data else { return }
            do {
                let jsonDecoder = JSONDecoder()
                let response = try jsonDecoder.decode(T.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}
