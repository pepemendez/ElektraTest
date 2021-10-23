//
//  Connector.swift
//  Series
//
//  Created by Jose Mendez on 22/10/21.
//

import Foundation

extension Connector {
    func getMovieVideos(itemId: Int,completion: @escaping (_ success: Bool, _ response: [Video], _ itemId: Int) -> ()){
        guard let url = URL(string: String(format: Endpoints.movieVideos, arguments: [String(itemId)])) else { return }
        
        httpRequest(url: url){
            success,_,response in
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(ListVideos.self, from: response.data(using: .utf8)!)
                completion(true, response.results, itemId)
            } catch let error {
                completion(false, [], 0)
                print("Ha ocurrido un error: \(error.localizedDescription)")
            }
        }
    }
    
    func getMovieDetails(itemId: Int,completion: @escaping (_ success: Bool, _ response: ItemDetail) -> ()){
        guard let url = URL(string: String(format: Endpoints.movieDetails, arguments: [String(itemId)])) else { return }
        
        httpRequest(url: url){
            success,_,response in
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(ItemDetail.self, from: response.data(using: .utf8)!)
                completion(true, response)
            } catch let error {
                completion(false, ItemDetail())
                print("Ha ocurrido un error: \(error.localizedDescription)")
            }
        }
    }
    
    func getSerieVideos(itemId: Int,completion: @escaping (_ success: Bool, _ response: [Video], _ itemId: Int) -> ()){
        guard let url = URL(string: String(format: Endpoints.serieVideos, arguments: [String(itemId)])) else { return }
        
        httpRequest(url: url){
            success,_,response in
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(ListVideos.self, from: response.data(using: .utf8)!)
                completion(true, response.results, itemId)
            } catch let error {
                completion(false, [], 0)
                print("Ha ocurrido un error: \(error.localizedDescription)")
            }
        }
    }
    
    func getSerieDetails(itemId: Int,completion: @escaping (_ success: Bool, _ response: ItemDetail) -> ()){
        guard let url = URL(string: String(format: Endpoints.serieDetails, arguments: [String(itemId)])) else { return }
        
        httpRequest(url: url){
            success,_,response in
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(ItemDetail.self, from: response.data(using: .utf8)!)
                completion(true, response)
            } catch let error {
                completion(false, ItemDetail())
                print("Ha ocurrido un error: \(error.localizedDescription)")
            }
        }
    }
    
    func getSerieSeasonsDetails(itemId: Int,completion: @escaping (_ success: Bool, _ response: [Season], _ itemId: Int) -> ()){
        guard let url = URL(string: String(format: Endpoints.serieDetails, arguments: [String(itemId)])) else { return }
        
        httpRequest(url: url){
            success,_,response in
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(ListSeasons.self, from: response.data(using: .utf8)!)
                completion(true, response.seasons, itemId)
            } catch let error {
                completion(false, [], 0)
                print("Ha ocurrido un error: \(error.localizedDescription)")
            }
        }
    }
    
    func getMovieNowPlaying(completion: @escaping (_ success: Bool, _ response: [Item]) -> ()){
        guard let url = URL(string: Endpoints.movieNowPlaying) else { return }
        
        httpRequest(url: url){
            success,_,response in
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(List.self, from: response.data(using: .utf8)!)
                completion(true, response.results)
            } catch let error {
                completion(false, [])
                print("Ha ocurrido un error: \(error.localizedDescription)")
            }
        }
    }
    
    func getMoviePopular(completion: @escaping (_ success: Bool, _ response: [Item]) -> ()){
        guard let url = URL(string: Endpoints.moviePopular) else { return }
        
        httpRequest(url: url){
            success,_,response in
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(List.self, from: response.data(using: .utf8)!)
                completion(true, response.results)
            } catch let error {
                completion(false, [])
                print("Ha ocurrido un error: \(error.localizedDescription)")
            }
        }
    }
    
    func getSerieNowPlaying(completion: @escaping (_ success: Bool, _ response: [Item]) -> ()){
        guard let url = URL(string: Endpoints.serieNowPlaying) else { return }
        
        httpRequest(url: url){
            success,_,response in
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(List.self, from: response.data(using: .utf8)!)
                completion(true, response.results)
            } catch let error {
                completion(false, [])
                print("Ha ocurrido un error: \(error.localizedDescription)")
            }
        }
    }
    
    func getSeriePopular(completion: @escaping (_ success: Bool, _ response: [Item]) -> ()){
        guard let url = URL(string: Endpoints.seriePopular) else { return }
        
        httpRequest(url: url){
            success,_,response in
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(List.self, from: response.data(using: .utf8)!)
                completion(true, response.results)
            } catch let error {
                completion(false, [])
                print("Ha ocurrido un error: \(error.localizedDescription)")
            }
        }
    }
}
