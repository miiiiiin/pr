//
//  WebService.swift
//  Weather
//
//  Created by 민송경 on 10/06/2019.
//  Copyright © 2019 민송경. All rights reserved.
//

import Foundation


//<T> : Type that i'm requesting
// type of the generic type when the service return
struct Resource<T> {
    
    let url: URL
    let parse: (Data) -> T? //closure
    //resource will have the core to parse the data that is being returned from the network call. and then convert it to the appropriate type that we need
    //going to give data and get you the return type
    
}

final class WebService {
    
    func load<T>(resource: Resource<T>, completion: @escaping (T?) -> ()) {
        
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            
            print("data: \(data)")
            if let data = data {
                
                //calling the service from the main thread -> update the tableview
                //going to be calling this from our vc -> controllers are on main thread that they can only be refreshed
                DispatchQueue.main.async { 
                    completion(resource.parse(data))
                }
                
            } else {
                completion(nil)
            }
        }.resume()
    }
}
