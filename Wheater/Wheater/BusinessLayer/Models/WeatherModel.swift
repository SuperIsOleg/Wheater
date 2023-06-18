//
//  WeatherModel.swift
//  Wheater
//
//  Created by Oleg Kalistratov on 18.06.23.
//

import Foundation

struct WeatherModel: Codable {
    let timezone: String
    let timezoneOffset: Int
    let current: CurrentWeather
    let hourly: [Hourly]
    let daily: [Daily]

    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.timezone = try container.decode(String.self, forKey: .timezone)
        self.timezoneOffset = try container.decode(Int.self, forKey: .timezoneOffset)
        self.current = try container.decode(CurrentWeather.self, forKey: .current)
        self.hourly = try container.decode([Hourly].self, forKey: .hourly)
        self.daily = try container.decode([Daily].self, forKey: .daily)
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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.dt = try container.decode(Int.self, forKey: .dt)
        self.temp = try container.decode(Double.self, forKey: .temp)
        self.feelsLike = try container.decode(Double.self, forKey: .feelsLike)
        self.humidity = try container.decode(Int.self, forKey: .humidity)
        self.visibility = try container.decode(Int.self, forKey: .visibility)
        self.windSpeed = try container.decode(Double.self, forKey: .windSpeed)
        self.weather = try container.decode([Weather].self, forKey: .weather)
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
