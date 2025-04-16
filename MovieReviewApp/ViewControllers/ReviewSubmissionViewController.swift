import UIKit


class ReviewSubmissionViewController: UIViewController {
  
    var movie: Movie!
        private let reviewStorage = ReviewStorage()
    
    // IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rateBarLabel: UISlider!
    @IBOutlet weak var ratesLabel: UILabel!
    @IBOutlet weak var writedesTextView: UITextView!
    @IBOutlet weak var submitButton: UIButton!
        

        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
        }
        // Rate Bar Label from 1-10
        private func setupUI() {
            titleLabel.text = movie.title
            // Use your outlet names
            rateBarLabel.minimumValue = 1
            rateBarLabel.maximumValue = 10
            rateBarLabel.value = 3
            updateRatingLabel()
            
            // Use your outlet name
            rateBarLabel.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        }
        
        @objc private func sliderValueChanged() {
            updateRatingLabel()
        }
        
        private func updateRatingLabel() {
            // Use your outlet names
            let rating = Int(rateBarLabel.value)
            ratesLabel.text = "Rating: \(rating)/10"
        }
        
        @IBAction func submitButtonTapped(_ sender: Any) {
            
            
            guard !writedesTextView.text.isEmpty else {
                // Show error if needed
                return
            }
            
            let review = Review(
                id: UUID(),
                movieId: movie.id,
                rating: Int(rateBarLabel.value),
                text: writedesTextView.text,
                date: Date()
            )
            // POP UP ALERT
            reviewStorage.saveReview(review)
            let alert = UIAlertController(title: "Your review is live!",
                                          message: "",
                                          preferredStyle: .alert)

            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                self.navigationController?.popViewController(animated: true)
            }

            alert.addAction(okAction)
            present(alert, animated: true)
                }
        }
        
    
