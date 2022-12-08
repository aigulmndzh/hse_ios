import UIKit

public struct materials: Codable {
    let articles: [Article]
}

public class ApiService {
    public init() {}
    static var shared = ApiService()
    
    public static var url =  URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=8cbd05f13b3346cfb4a3219918d054cc")
    
    public func getTopStories(status: @escaping (Result<[Article], Error>) -> Void) {
        URLSession.shared.dataTask(with: ApiService.url!) {data, _,error in
            guard let data = data else {
                return
            }
            do {
                let decoder = try JSONDecoder().decode(materials.self, from: data)
                status(.success(decoder.articles))
            }
            catch {
                status(.failure(error))
            }
        }.resume()
    }
}

public struct Article: Codable {
    var source: Source
    var title: String
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var imageData: Data? = nil
    
    struct Source: Codable {
        var id: String?
        var name: String?
    }
}
