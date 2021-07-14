import Foundation
import CoreData

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var drinksViewPriority: String?
    @NSManaged public var userDrinks: Set<String>?
    @NSManaged public var userFavoriteCocktails: Set<String>?
    @NSManaged public var darkMode: Bool

}
