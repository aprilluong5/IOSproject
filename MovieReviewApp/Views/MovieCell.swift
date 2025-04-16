import UIKit


class MovieCell: UITableViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
   
    
        
        override func awakeFromNib() {
            super.awakeFromNib()
        }
        
        func configure(with movie: Movie) {
            titleLabel.text = movie.title
            
            if !movie.posterPath.isEmpty {
                loadImage(from: movie.posterPath)
            }
        }
        
        private func loadImage(from posterPath: String) {
            let baseURL = "https://image.tmdb.org/t/p/w200"
            guard let url = URL(string: baseURL + posterPath) else { return }
            
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let data = data, error == nil,
                      let image = UIImage(data: data) else { return }
                
                DispatchQueue.main.async {
                    self?.movieImageView.image = image
                }
            }
            task.resume()
        }
    }
