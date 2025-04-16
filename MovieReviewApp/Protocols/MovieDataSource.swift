protocol MovieDataSource {
    func fetchTrendingMovies() async throws -> [Movie]
    func searchMovies(query: String) async throws -> [Movie]
    func getMovieDetails(id: Int) async throws -> Movie
} 