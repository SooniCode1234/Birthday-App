//
//  Holiday.swift
//  Birthday-App
//
//  Created by Sooni Mohammed on 2020-11-17.
//

import Foundation

struct HolidayResponse: Decodable {
    var response: Holidays
}

struct Holidays: Decodable {
    let holidays: [HolidayDetail]
}

struct HolidayDetail: Decodable {
    let name: String
    let date: DateInfo
}

struct DateInfo: Decodable {
    let iso: String
}

