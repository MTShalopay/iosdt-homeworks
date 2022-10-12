//
//  NetworkManager.swift
//  Navigation
//
//  Created by Shalopay on 11.10.2022.
//

import Foundation

enum AppConfiguration: String, CaseIterable {
    case people = "https://swapi.dev/api/people/8"
    case starships = "https://swapi.dev/api/starships/3"
    case planets = "https://swapi.dev/api/planets/5"
}

struct BookingConfigure: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
    
}

struct NetworkManager {
     static func request(for configuration: AppConfiguration) {
        let session = URLSession(configuration: .default)
        switch configuration {
        case .people:
            guard let urlString = URL(string: "\(configuration.rawValue)") else { return }
            let task = session.dataTask(with: urlString) { (data, response, error) in
                if let error = error {
                    print("ERROR localizedDescription: \(error.localizedDescription)")
                    /*
                     ERROR localizedDescription: The Internet connection appears to be offline.
                     Данные не получены
                     */
                }
                if let response = response as? HTTPURLResponse {
                    print("StatusCode: \(response.statusCode) \n")
                    print("Etag: \(response.allHeaderFields["Etag"] ?? ["Нет данных"])")
                    print("Allow: \(response.allHeaderFields["allow"] ?? ["Нет данных"])")
                    print("Content-Length: \(response.allHeaderFields["Content-Length"] ?? ["Нет данных"])")
                    print("Date: \(response.allHeaderFields["Date"] ?? ["Нет данных"])")
                    print("Server: \(response.allHeaderFields["Server"] ?? ["Нет данных"])")
                    print("Vary: \(response.allHeaderFields["Vary"] ?? ["Нет данных"])")
                    print("Strict-Transport-Security: \(response.allHeaderFields["Strict-Transport-Security"] ?? ["Нет данных"])")
                    print("x-frame-options: \(response.allHeaderFields["x-frame-options"] ?? ["Нет данных"])")
                    print("Content-Type: \(response.allHeaderFields["Content-Type"] ?? ["Нет данных"]) \n")
                }
                guard let data = data else { return print("Данные по ссылке \(urlString) не получены") }
                do {
                    let result = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                    print("name: \(result?["name"] ?? ["Нет данных"])")
                    print("Height: \(result?["height"] ?? ["Нет данных"])")
                    print("Mass: \(result?["mass"] ?? ["Нет данных"])")
                    print("Hair color: \(result?["hair_color"] ?? ["Нет данных"])")
                    print("Skin_color: \(result?["skin_color"] ?? ["Нет данных"])")
                    print("Eye_color: \(result?["eye_color"] ?? ["Нет данных"])")
                    print("Birth year: \(result?["birth_year"] ?? ["Нет данных"])")
                    print("Gender: \(result?["gender"] ?? ["Нет данных"])")
                    print("Homeworld: \(result?["homeworld"] ?? ["Нет данных"])")
                    guard let filmsArray = result?["films"] as? [Any] else { return print("Невозможно получить данные по \(String(describing: result?["films"]))")}
                    print("Films: \(filmsArray)")
                    guard let speciesArray = result?["species"] as? [Any] else { return print("Невозможно получить данные по \(String(describing: result?["species"]))")}
                    print("Species: \(speciesArray)")
                    guard let vehiclesArray = result?["vehicles"] as? [Any] else { return print("Невозможно получить данные по \(String(describing: result?["vehicles"]))")}
                    print("Vehicles: \(vehiclesArray)")
                    guard let starshipsArray = result?["starships"] as? [Any] else { return print("Невозможно получить данные по \(String(describing: result?["starships"]))")}
                    print("Starships: \(starshipsArray)")
                    print("Created: \(result?["created"] ?? ["Нет данных"])")
                    print("Edited: \(result?["edited"] ?? ["Нет данных"])")
                    print("Url: \(result?["url"] ?? ["Нет данных"])")
                } catch {
                    print("Error for catch: \(error.localizedDescription)")
                }
                
            }
            task.resume()
            
        case .starships:
            guard let urlString = URL(string: "\(configuration.rawValue)") else { return }
            let task = session.dataTask(with: urlString) { (data, response, error) in
                if let error = error {
                    print("ERROR localizedDescription: \(error.localizedDescription)")
                    /*
                     ERROR localizedDescription: The Internet connection appears to be offline.
                     Данные не получены
                     */
                }
                if let response = response as? HTTPURLResponse {
                    print("StatusCode: \(response.statusCode) \n")
                    print("Server: \(response.allHeaderFields["Server"] ?? ["Нет данных"])")
                    print("Etag: \(response.allHeaderFields["Etag"] ?? ["Нет данных"])")
                    print("Date: \(response.allHeaderFields["Date"] ?? ["Нет данных"])")
                    print("Strict Transport Security: \(response.allHeaderFields["Strict-Transport-Security"] ?? ["Нет данных"])")
                    print("X frame options: \(response.allHeaderFields["x-frame-options"] ?? ["Нет данных"])")
                    print("Allow: \(response.allHeaderFields["allow"] ?? ["Нет данных"])")
                    print("Content Type: \(response.allHeaderFields["Content-Type"] ?? ["Нет данных"])")
                    print("Content Length: \(response.allHeaderFields["Content-Length"] ?? ["Нет данных"])")
                    print("Vary: \(response.allHeaderFields["Vary"] ?? ["Нет данных"]) \n")
                }
                guard let data = data else { return print("Данные по ссылке \(urlString) не получены")}
                do {
                    let result = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                    print("Name: \(result?["name"] ?? ["Нет данных"])")
                    print("Model: \(result?["model"] ?? ["Нет данных"])")
                    print("Manufacturer: \(result?["manufacturer"] ?? ["Нет данных"])")
                    print("Cost in credits: \(result?["cost_in_credits"] ?? ["Нет данных"])")
                    print("Length: \(result?["length"] ?? ["Нет данных"])")
                    print("Max atmosphering speed: \(result?["max_atmosphering_speed"] ?? ["Нет данных"])")
                    print("Crew: \(result?["crew"] ?? ["Нет данных"])")
                    print("Passengers: \(result?["passengers"] ?? ["Нет данных"])")
                    print("Cargo capacity: \(result?["cargo_capacity"] ?? ["Нет данных"])")
                    print("Consumables: \(result?["consumables"] ?? ["Нет данных"])")
                    print("Hyperdrive rating: \(result?["hyperdrive_rating"] ?? ["Нет данных"])")
                    print("MGLT: \(result?["MGLT"] ?? ["Нет данных"])")
                    print("Starship class: \(result?["starship_class"] ?? ["Нет данных"])")
                    guard let pilotsArray = result?["pilots"] as? [Any] else {return print("Невозможно получить данные по \(String(describing: result?["pilots"]))") }
                    print("Pilots: \(pilotsArray)")
                    guard let filmsArray = result?["films"] as? [Any] else { return print("Невозможно получить данные по \(String(describing: result?["films"]))")}
                    print("Films: \(filmsArray) Количество фильмов: \(filmsArray.count) штук")
                    print("Created: \(result?["created"] ?? ["Нет данных"])")
                    print("Edited: \(result?["edited"] ?? ["Нет данных"])")
                    print("Url: \(result?["url"] ?? ["Нет данных"])")
                } catch {
                    print("Error for catch: \(error.localizedDescription)")
                }
            }
            task.resume()
        case .planets:
            guard let urlString = URL(string: "\(configuration.rawValue)") else { return }
            let task = session.dataTask(with: urlString) { (data, response, error) in
                if let error = error {
                    print("ERROR localizedDescription: \(error.localizedDescription)")
                    /*
                     ERROR localizedDescription: The Internet connection appears to be offline.
                     Данные не получены
                     */
                }
                if let response = response as? HTTPURLResponse {
                    print("StatusCode: \(response.statusCode) \n")
                    print("Content Length: \(response.allHeaderFields["Content-Length"] ?? ["Нет данных"])")
                    print("Server: \(response.allHeaderFields["Server"] ?? ["Нет данных"])")
                    print("X frame options: \(response.allHeaderFields["x-frame-options"] ?? ["Нет данных"])")
                    print("Etag: \(response.allHeaderFields["Etag"] ?? ["Нет данных"])")
                    print("Vary: \(response.allHeaderFields["Vary"] ?? ["Нет данных"])")
                    print("Strict Transport Security: \(response.allHeaderFields["Strict-Transport-Security"] ?? ["Нет данных"])")
                    print("Content Type: \(response.allHeaderFields["Content-Type"] ?? ["Нет данных"])")
                    print("Date: \(response.allHeaderFields["Date"] ?? ["Нет данных"])")
                    print("Allow: \(response.allHeaderFields["allow"] ?? ["Нет данных"]) \n")
                }
                guard let data = data else {return print("Данные по ссылке \(urlString) не получены")}
                do {
                    let result = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                    print("Name: \(result?["name"] ?? ["Нет данных"])")
                    print("Rotation period: \(result?["rotation_period"] ?? ["Нет данных"])")
                    print("Orbital period: \(result?["orbital_period"] ?? ["Нет данных"])")
                    print("Diameter: \(result?["diameter"] ?? ["Нет данных"])")
                    print("Climate: \(result?["climate"] ?? ["Нет данных"])")
                    print("Gravity: \(result?["gravity"] ?? ["Нет данных"])")
                    print("Terrain: \(result?["terrain"] ?? ["Нет данных"])")
                    print("Surface water: \(result?["surface_water"] ?? ["Нет данных"])")
                    print("Population: \(result?["population"] ?? ["Нет данных"])")
                    guard let residentsArray = result?["residents"] as? [Any] else { return print("Невозможно получить данные по \(String(describing: result?["residents"]))") }
                    print("Residents \(residentsArray)")
                    guard let filmsArray = result?["films"] as? [Any] else { return print("Невозможно получить данные по \(String(describing: result?["films"]))")}
                    print("Films: \(filmsArray) Количество фильмов: \(filmsArray.count) штук")
                    print("Created: \(result?["created"] ?? ["Нет данных"])")
                    print("Edited: \(result?["edited"] ?? ["Нет данных"])")
                    print("Url: \(result?["url"] ?? ["Нет данных"])")
                } catch {
                    print("Error for catch: \(error.localizedDescription)")
                }
            }
            task.resume()
        }
    }

    static func requestBookingConfigure(for index: Int, completion: ((_ title: String?)-> Void)?) {
        let url = "https://jsonplaceholder.typicode.com/todos/\(index)"
        guard let urlString = URL(string: url) else {
            print("Невозможно получить URL =(")
            
        return }
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlString) { (data, response, error) in
            if let error = error { print("ERROR: \(error.localizedDescription)") }
            if (response as! HTTPURLResponse).statusCode != 200 {
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("УПС ошибочка вышла. Данный запрос имеет StatusCode \(statusCode)")
                completion?(nil)
            }
            guard let data = data else {return print("К сожелению невозможно получить данные...") }
            do {
                let result = try JSONDecoder().decode(BookingConfigure.self, from: data)
                let title = result.title
                completion?(title)
                
            } catch {
                print("ERROR: \(error)")
            }
        }
        dataTask.resume()
    }
}
