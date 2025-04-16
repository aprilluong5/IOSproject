import Foundation

class ReviewStorage {
    private let userDefaults = UserDefaults.standard
    private let reviewsKey = "savedReviews"
    
    func saveReview(_ review: Review) {
        var reviews = getAllReviews()
        reviews.append(review)
        
        if let encoded = try? JSONEncoder().encode(reviews) {
            userDefaults.set(encoded, forKey: reviewsKey)
        }
    }
    
    func getAllReviews() -> [Review] {
        guard let data = userDefaults.data(forKey: reviewsKey),
              let reviews = try? JSONDecoder().decode([Review].self, from: data) else {
            return []
        }
        return reviews
    }
    
    func getReviews(for movieId: Int) -> [Review] {
        return getAllReviews().filter { $0.movieId == movieId }
    }
} 