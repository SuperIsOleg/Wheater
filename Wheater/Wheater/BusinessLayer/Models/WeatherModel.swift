//
//  WeatherModel.swift
//  Wheater
//
//  Created by Oleg Kalistratov on 18.06.23.
//

import Foundation

struct WeatherModel: Codable {
    let timezone: String
    let current: CurrentWeather
    let hourly: [Hourly]
    let daily: [Daily]
    
    var currentTime: String = ""

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.timezone = try container.decode(String.self, forKey: .timezone)
        self.current = try container.decode(CurrentWeather.self, forKey: .current)
        self.hourly = try container.decode([Hourly].self, forKey: .hourly)
        self.daily = try container.decode([Daily].self, forKey: .daily)
        
        self.currentTime = convertToDate(identifier: timezone, format: "dd-MM-yyyy'T'HH:mm:ss")
    }
    
    private func convertToDate(identifier: String, format: String) -> String {
        let dateString = Date.convertToTime(format: format, identifier: identifier)
        return dateString ?? ""
    }
}

struct CurrentWeather: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Double
    let feelsLike: Double
    let humidity: Int
    let visibility: Int
    let windSpeed: Double
    let weather: [Weather]
    
    var currentDate: String = ""
    var sunriseTime: String = ""
    var sunsetTime: String = ""
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.dt = try container.decode(Int.self, forKey: .dt)
        self.sunrise = try container.decode(Int.self, forKey: .sunrise)
        self.sunset = try container.decode(Int.self, forKey: .sunset)
        self.temp = try container.decode(Double.self, forKey: .temp)
        self.feelsLike = try container.decode(Double.self, forKey: .feelsLike)
        self.humidity = try container.decode(Int.self, forKey: .humidity)
        self.visibility = try container.decode(Int.self, forKey: .visibility)
        self.windSpeed = try container.decode(Double.self, forKey: .windSpeed)
        self.weather = try container.decode([Weather].self, forKey: .weather)
        
        self.currentDate = convertToDate(timeInterval: dt, format: "dd-MM-yyyy'T'HH:mm:ss")
        self.sunriseTime = convertToDate(timeInterval: sunrise, format: "dd-MM-yyyy'T'HH:mm:ss")
        self.sunsetTime = convertToDate(timeInterval: sunset, format: "dd-MM-yyyy'T'HH:mm:ss")
    }
    
    private func convertToDate(timeInterval: Int, format: String) -> String {
        let date = Date(timeIntervalSince1970: Double(timeInterval))
        let dateString = date.convertToDate(format: format)
        return dateString ?? ""
    }
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.main = try container.decode(String.self, forKey: .main)
        self.description = try container.decode(String.self, forKey: .description)
        self.icon = try container.decode(String.self, forKey: .icon)
    }
}

struct Hourly: Codable {
    let dt: Int
    let temp: Double
    let feelsLike: Double
    let humidity: Int
    let visibility: Int
    let windSpeed: Double
    let weather: [Weather]
    
    var hourlyWeather: String = ""
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.dt = try container.decode(Int.self, forKey: .dt)
        self.temp = try container.decode(Double.self, forKey: .temp)
        self.feelsLike = try container.decode(Double.self, forKey: .feelsLike)
        self.humidity = try container.decode(Int.self, forKey: .humidity)
        self.visibility = try container.decode(Int.self, forKey: .visibility)
        self.windSpeed = try container.decode(Double.self, forKey: .windSpeed)
        self.weather = try container.decode([Weather].self, forKey: .weather)
        
        self.hourlyWeather = convertToDate(timeInterval: dt, format: "dd-MM-yyyy'T'HH:mm:ss")

    }
    
    private func convertToDate(timeInterval: Int, format: String) -> String {
        let date = Date(timeIntervalSince1970: Double(timeInterval))
        let dateString = date.convertToDate(format: format)
        return dateString ?? ""
    }
}

struct Daily: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Temp
    let feelsLike: FeelsLike
    let humidity: Int
    let windSpeed: Double
    let weather: [Weather]
    
    var weatherByDate: String = ""
    var sunriseTime: String = ""
    var sunsetTime: String = ""
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.dt = try container.decode(Int.self, forKey: .dt)
        self.sunrise = try container.decode(Int.self, forKey: .sunrise)
        self.sunset = try container.decode(Int.self, forKey: .sunset)
        self.temp = try container.decode(Temp.self, forKey: .temp)
        self.feelsLike = try container.decode(FeelsLike.self, forKey: .feelsLike)
        self.humidity = try container.decode(Int.self, forKey: .humidity)
        self.windSpeed = try container.decode(Double.self, forKey: .windSpeed)
        self.weather = try container.decode([Weather].self, forKey: .weather)
        
        self.weatherByDate = convertToDate(timeInterval: dt, format: "dd-MM-yyyy'T'HH:mm:ss")
        self.sunriseTime = convertToDate(timeInterval: sunrise, format: "dd-MM-yyyy'T'HH:mm:ss")
        self.sunsetTime = convertToDate(timeInterval: sunset, format: "dd-MM-yyyy'T'HH:mm:ss")
    }
    
    private func convertToDate(timeInterval: Int, format: String) -> String {
        let date = Date(timeIntervalSince1970: Double(timeInterval))
        let dateString = date.convertToDate(format: format)
        return dateString ?? ""
    }
}

struct Temp: Codable {
    let day, min, max: Double

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.day = try container.decode(Double.self, forKey: .day)
        self.min = try container.decode(Double.self, forKey: .min)
        self.max = try container.decode(Double.self, forKey: .max)
    }
}

struct FeelsLike: Codable {
    let day: Double
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.day = try container.decode(Double.self, forKey: .day)
    }
}
