import UIKit

"https://itunes.apple.com/search?term=action&entity=movie&attribute=genreTerm"


public enum BaseURL: String {
    case development = "https://itunes.apple.com:8000/"
    case production = "https://itunes.apple.com/"
}

public enum MediaType: String {
    case movie = "&entity=movie"
    case tv = "&entity=tv"
}

public var targetEnviroment: BaseURL = .development
public var selectedMediaType: MediaType = .movie

public enum EndPoints {
    
    private var baseURL: String { targetEnviroment.rawValue }
    private var mediaType: String { selectedMediaType.rawValue }
    private var searchPrefix: String { "&attribute=genreTerm"}
    
    case action
    case horror
    case family
    case classics
    case western
    
    private var fullPath: String {
        var genre: String
        
        switch self {
        case .action:
            genre = "search?term=action"
        case .horror:
            genre = "search?term=horror"
        case .family:
            genre = "search?term=family"
        case .classics:
            genre = "search?term=classics"
        case .western:
            genre = "search?term=western"
        }
        
        return baseURL + genre + mediaType + searchPrefix
    }
    
    var url: URL {
        guard let url = URL(string: fullPath) else {
            preconditionFailure("the URL used in \(EndPoints.self) is not valid")
        }
        return url
    }
}

func basicAPICall() async throws {
    
    // Create the request object using url object
    var urlRequest = URLRequest(url: EndPoints.action.url)
    
    // Create URL Session
    let (data, response) = try await URLSession.shared.data(for: urlRequest)
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
    
    // Decode response as string
    guard let stringResult = try? JSONDecoder().decode(String.self, from: data) else { return }
}

print(EndPoints.action.url)
