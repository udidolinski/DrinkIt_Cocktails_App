import UIKit
import SwiftUI
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    let model = Model()
    @Environment(\.colorScheme) var colorScheme

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        var user:User
        var startGuide:Bool
        
        do {
            let temp:[User] = try managedObjectContext.fetch(User.fetchRequest())
            if (temp.isEmpty){
                user = User(context: managedObjectContext)
                user.drinksViewPriority = "Categories"
                user.darkMode = false
                startGuide = true
            }
            else{
                user = temp[0]
                startGuide = false
            }
        }
        catch{
            exit(EXIT_FAILURE)
        }
        
        let dbDrinks = DBDrinks()
        let dbCocktails = DBCocktails()
    
        
        var toDelete : Set<String> = []
        for drink in user.userDrinks {
            if !dbDrinks.drinksDict.keys.contains(drink) {
                toDelete.insert(drink)
            }
        }
        user.userDrinks = user.userDrinks.subtracting(toDelete)
        
        
        
        // Create the SwiftUI view that provides the window contents.
        
        let contentView = ContentView(appDarkMode: user.darkMode, startGuide: startGuide).environment(\.managedObjectContext, managedObjectContext).environmentObject(user).environmentObject(dbDrinks).environmentObject(dbCocktails).environmentObject(model)
     
        
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            
            // Start the application mode with the saved user mode
            window.overrideUserInterfaceStyle = user.darkMode ? .dark : .light
            
            
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    func windowScene(_ windowScene: UIWindowScene, didUpdate previousCoordinateSpace: UICoordinateSpace, interfaceOrientation previousInterfaceOrientation: UIInterfaceOrientation, traitCollection previousTraitCollection: UITraitCollection) {
           model.environment.toggle()
       }
    

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

/**
    model is an object that updates the view when the screen rotates
 */
final class Model: ObservableObject {
    let objectWillChange = ObservableObjectPublisher()

    var environment: Bool = false { willSet { objectWillChange.send() } }
}