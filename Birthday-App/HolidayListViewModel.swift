//
//  HolidayListViewModel.swift
//  Birthday-App
//
//  Created by Sooni Mohammed on 2020-11-18.
//

import SwiftUI

final class HolidayListViewModel: ObservableObject {
    
    @Published var searchedHoliday              = ""
    @Published var holidays: [HolidayDetail]    = []
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    
    var holidayCount: String {
        "\(holidays.count) Holidays found in \(searchedHoliday == "" ? "US" : searchedHoliday)"
    }
    
    func getHoliday(countryCode: String = "US") {
        isLoading = true
        NetworkManager.shared.fetchHolidays(countryCode: countryCode) { [self] (result) in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let holidays):
                    self.holidays = holidays
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                        
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                        
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                        
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
}
