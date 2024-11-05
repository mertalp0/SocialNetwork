import Foundation

struct Post: Codable {
    
    // MARK: - Properties
    let id: String                    
    let userId: String                
    let userImageUrl: String          
    let username: String              
    let userNickname: String          
    let text: String                  
    var imageUrl: String?             
    let likers: [String]              
    let commenters: [String]          
    let createdAt: Date               
    
    // MARK: - Initializer
    init(id: String,
         userId: String,
         userImageUrl: String,
         username: String,
         userNickname: String,
         text: String,
         imageUrl: String? = nil,
         likers: [String] = [],
         commenters: [String] = [],
         createdAt: Date = Date()) {
        
        self.id = id
        self.userId = userId
        self.userImageUrl = userImageUrl
        self.username = username
        self.userNickname = userNickname
        self.text = text
        self.imageUrl = imageUrl
        self.likers = likers
        self.commenters = commenters
        self.createdAt = createdAt
    }
}
