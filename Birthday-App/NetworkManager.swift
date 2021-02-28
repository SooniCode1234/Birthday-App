//
//  NetworkManager.swift
//  Birthday-App
//
//  Created by Sooni Mohammed on 2020-11-17.
//

import Foundation

final class NetworkManager {
    static var shared = NetworkManager()
    private init() {}
    
    func fetchHolidays(countryCode: String, completion: @escaping(Result<[HolidayDetail], HOError>) -> Void) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let currentYear = formatter.string(from: date)
        
        let countryURL = "https://calendarific.com/api/v2/holidays?&api_key=02b7bd47435e3edfd10ae5a604acc40c15b2648a&country=\(countryCode)&year=\(currentYear)"
        
        guard let url = URL(string: countryURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, response, error) in
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(HolidayResponse.self, from: data)
                completion(.success(decodedResponse.response.holidays))
            } catch {
                completion(.failure(.invalidData))
            }
            
        }
        
        task.resume()
        
    }
    
    private let baseURL = "https://calendarific.com/api/v2/holidays?&api_key=02b7bd47435e3edfd10ae5a604acc40c15b2648a&country=US&year=2019"
}
