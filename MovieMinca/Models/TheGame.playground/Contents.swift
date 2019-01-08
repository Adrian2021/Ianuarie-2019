import Foundation



var str = "Hello, playground"


class Movie  {
   var localId = UUID().uuidString
    
    var id : Int = 0
    var title: String = ""
    var date : String = ""
    var shortDescription : String = ""
    var posterPath: String = ""
    var backdrop_path: String = ""
    
    
    
    
    convenience init (localId: String, id: Int, title: String, date : String, shortDescription : String, posterPath: String, backdrop_path: String) {
        self.init()
        
        self.localId = localId
        
        self.id = id
        self.title = title
        self.date = date
        self.shortDescription = shortDescription
        self.posterPath = posterPath
        self.backdrop_path = backdrop_path
    }
    
}


let movie = Movie()
//movie.id = 6
print(movie.id)
movie.title = "Andu"

print(movie.title)
