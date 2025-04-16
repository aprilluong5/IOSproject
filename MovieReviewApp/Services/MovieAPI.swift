import Foundation

class MovieAPI: MovieDataSource {
    private let apiKey = "af1ce057cf78a9be343ba6124c877c7f" 
    private let baseURL = "https://api.themoviedb.org/3"
    
    func fetchTrendingMovies() async throws -> [Movie] {
        let url = URL(string: "\(baseURL)/trending/movie/week?api_key=\(apiKey)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(MovieResponse.self, from: data)
        return response.results
    }
    
    func searchMovies(query: String) async throws -> [Movie] {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: "\(baseURL)/search/movie?api_key=\(apiKey)&query=\(encodedQuery)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(MovieResponse.self, from: data)
        return response.results
    }
    
    func getMovieDetails(id: Int) async throws -> Movie {
        let url = URL(string: "\(baseURL)/movie/\(id)?api_key=\(apiKey)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(Movie.self, from: data)
    }
}

private struct MovieResponse: Codable {
    let results: [Movie]
} 