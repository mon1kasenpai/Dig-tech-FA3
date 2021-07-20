//
//  weathermanager.swift
//  dig tech FA3
//
//  Created by Lachlan Forbes on 14/6/21.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation

class WeatherManager: ObservableObject {
static let key = "394fa91f1a59212b87ceff5067082ab2"
static let baseURL = "https://api.darksky.net/forecast/\(key)/"
}

class NetworkManager:ObservableObject {
    
    @Published var didChange = PassthroughSubject<NetworkManager, Never>()
    
    @Published var weather:Weather? {
        didSet {
            didChange.send(self)
        }
    }

    init(){
        getWeather()
    }
    
    @Published var locationViewModel = LocationViewModel()

    private func getWeather(){

        guard let url = URL(string: WeatherManager.baseURL +  "\(locationViewModel.userLatitude),\(locationViewModel.userLongitude)?units=ca") else {
            return
        }
        
        URLSession.shared.dataTask(with:url){ (data, response, error) in
            guard let data = data else {
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                
                let weatherObject = try decoder.decode(Weather.self, from: data)
                
                DispatchQueue.main.async {
                    self.weather = weatherObject
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
        
    }
}
