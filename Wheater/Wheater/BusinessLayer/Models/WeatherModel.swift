//
//  WeatherModel.swift
//  Wheater
//
//  Created by Oleg Kalistratov on 18.06.23.
//

import Foundation

struct WeatherModel: Codable {
    let timezone: String
    let timezone_offset: Int
    let current: CurrentWeather
    let hourly: [Hourly]
    let daily: [Daily]
}

struct CurrentWeather: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Double
    let feels_like: Double
    let humidity: Int
    let visibility: Int
    let wind_speed: Double
    let weather: [Weather]
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Hourly: Codable {
    let dt: Int
    let temp: Int
    let feels_like: Double
    let humidity: Int
    let visibility: Int
    let wind_speed: Double
    let weather: [Weather]
}

struct Daily: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Temp
    let feels_like: FeelsLike
    let humidity: Int
    let wind_speed: Double
    let weather: [Weather]
}

struct Temp: Codable {
    let day: Double
    let min: Double
    let max: Double
}

struct FeelsLike: Codable {
    let day: Double
}
