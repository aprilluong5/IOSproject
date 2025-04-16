import UIKit

class MovieDetailViewController: UIViewController {
    var movie: Movie!
    private let reviewStorage = ReviewStorage()
    private var reviews: [Review] = []
    
    
    
    
    @IBOutlet weak var imageMovieView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var movieTitlesLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var descriptionsLabel: UITextView!
    @IBOutlet weak var reviewButtonLabel: UIButton!
    
    // MARK: - Lifecycle Methods
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadReviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadReviews() // Reload reviews when coming back from submission
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        title = movie.title
        
        // Configure UI elements
        movieTitlesLabel.text = movie.title
        dateLabel.text = "Release Date: \(movie.releaseDate)"
        rateLabel.text = "Rating: \(movie.voteAverage)/10"
        descriptionsLabel.text = movie.overview
        descriptionsLabel.isEditable = false
        
        // Set up review button
        reviewButtonLabel.setTitle("Write a Review", for: .normal)
        
        // Load movie image
        if !movie.posterPath.isEmpty {
            loadImage(from: movie.posterPath)
        }
    }
    
    // MARK: - Image Loading
    private func loadImage(from posterPath: String) {
        let baseURL = "https://image.tmdb.org/t/p/w500"
        guard let url = URL(string: baseURL + posterPath) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil,
                  let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self?.imageMovieView.image = image
            }
        }
        task.resume()
    }
    
    // MARK: - Reviews
    private func loadReviews() {
        reviews = reviewStorage.getReviews(for: movie.id)
    }
    
    
    // MARK: - Actions
    @IBAction func reviewButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let reviewSubVC = storyboard.instantiateViewController(withIdentifier: "ReviewSubVC") as? ReviewSubmissionViewController {
            reviewSubVC.movie = movie
            navigationController?.pushViewController(reviewSubVC, animated: true)
        }
    }
}


