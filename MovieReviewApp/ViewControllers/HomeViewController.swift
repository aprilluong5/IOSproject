import UIKit

class HomeViewController: UITableViewController {
    private var movies: [Movie] = []
    private let movieAPI = MovieAPI()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
        
    override func viewDidLoad() {
          super.viewDidLoad()
          setupUI()
          fetchTrendingMovies()
          // Set the delegate here
          searchBar.delegate = self
      }
      
      private func setupUI() {
          title = "Trending Movies"
      }
      
      private func fetchTrendingMovies() {
          Task {
              do {
                  self.movies = try await movieAPI.fetchTrendingMovies()
                  DispatchQueue.main.async {
                      self.tableView.reloadData()
                  }
              } catch {
                  print("Error fetching movies: \(error)")
              }
          }
      }
      
      // MARK: - TableView methods
      override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return movies.count
      }
      
      override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
          let movie = movies[indexPath.row]
          cell.configure(with: movie)
          return cell
      }
      
      override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let storyboard = UIStoryboard(name: "Main", bundle: nil)
          if let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as? MovieDetailViewController {
              let movie = movies[indexPath.row]
              detailVC.movie = movie
              navigationController?.pushViewController(detailVC, animated: true)
          }
      }
  }

  // Add UISearchBarDelegate methods in an extension
  extension HomeViewController: UISearchBarDelegate {
      func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
          if searchText.isEmpty {
              fetchTrendingMovies()
          } else {
              Task {
                  do {
                      self.movies = try await movieAPI.searchMovies(query: searchText)
                      DispatchQueue.main.async {
                          self.tableView.reloadData()
                      }
                  } catch {
                      print("Error searching movies: \(error)")
                  }
              }
          }
      }
      
      func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
          searchBar.resignFirstResponder()
      }
  }


