import Foundation

struct Review: Codable {
    let id: UUID
    let movieId: Int
    let rating: Int
    let text: String
    let date: Date
    
    enum Rating: Int {
        case one = 1
        case two = 2
        case three = 3
        case four = 4
        case five = 5
    }
} 
