//
//  Connector.swift
//  Series
//
//  Created by Jose Mendez on 22/10/21.
//

import Foundation

class Connector {
    
    func httpRequest(url: URL, completion: @escaping (Bool, Int, String) -> ()){
        URLSession.shared.dataTask(with: url){
            (data, response, error) in
            
            //print(url.absoluteURL)
            
            if let data = data, let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                
                let message = String(decoding: data, as: UTF8.self)
                
                //print(message.prefix(100))
                
                completion(false, response.statusCode, message);
            }
            else{
                completion(false, 0, "ERROR");
            }
        }.resume()
    }
}
