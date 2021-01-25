import UIKit

struct Person: Decodable {
    let name: String
    let films: [URL]
}

struct Film: Decodable {
    let title: String
    let opening_crawl: String
    let release_date: String
}

class SwapiService {
    static let baseURL = URL(string: "https://swapi.dev/api")
    static let peopleEndPoint = "people"
    static let filmsEndPoint = "films"
    
    static func fetchPerson(id: Int, completion: @escaping (Person?) -> Void) {
        guard let baseURL = baseURL else {return completion(nil)}
        let personURL = baseURL.appendingPathComponent(peopleEndPoint)
        let finalURL = personURL.appendingPathComponent("\(id)")
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("There was an error fetching a person -- \(error) -- \(error.localizedDescription)")
                return completion(nil)
            }
            
            guard let data = data else {return completion(nil)}
            do {
                let person = try JSONDecoder().decode(Person.self, from: data)
                return completion(person)
            } catch {
                print("There was an error decoding the data -- \(error) -- \(error.localizedDescription)")
                return completion(nil)
            }
        }.resume()
    }
    
    static func fetchFilm(url: URL, completion: @escaping (Film?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("There was an error fetching a person -- \(error) -- \(error.localizedDescription)")
                return completion(nil)
            }
            
            guard let data = data else {return completion(nil)}
            do {
                let film = try JSONDecoder().decode(Film.self, from: data)
                return completion(film)
            } catch {
                print("There was an error decoding the data -- \(error) -- \(error.localizedDescription)")
                return completion(nil)
            }
        }.resume()
    }
} //End of class

func fetchFilm(url: URL) {
    SwapiService.fetchFilm(url: url) { (film) in
        if let film = film {
            print(film.title)
        }
    }
}

SwapiService.fetchPerson(id: 10) { (person) in
    if let person = person {
        print(person.name)
        for film in person.films {
            fetchFilm(url: film)
        }
    }
}
