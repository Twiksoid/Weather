//
//  SceneDelegate.swift
//  Weather
//
//  Created by Nikita Byzov on 27.11.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var viewControllerForShowing: UIViewController
        
        if (UserDefaults.standard.value(forKey: "onboarding") as? String) == nil {
            viewControllerForShowing = storyboard.instantiateViewController(withIdentifier: "onboardingStoryboard")
        } else {
            viewControllerForShowing =
            // storyboard.instantiateViewController(withIdentifier: "navigationVCSID")
            
            PageViewController()
            // storyboard.instantiateInitialViewController()!
        }
        
        self.window?.rootViewController = viewControllerForShowing
        //  self.window?.rootViewController = PageViewController()
        self.window?.makeKeyAndVisible()
        
        if CoreDataManager.shared.settings.count == 0 {
            // значит, первый запуск, нужно положить данные с базовыми настройками
            // базовые настройки сам придумал под РФ
            CoreDataManager.shared.createSettings(temp: Int16(0), speed: Int16(1), hours: Int16(1), notifications: Int16(1))} else {
                print("Настройки уже есть, ничего не пишем")
            }
        
        // хитрость в том, что нужны актуальные данные на момент запуска приложения
        // это значит, что хранить постоянно данные нет смысла
        // значит, при запуске приложения проще удалить весь мусор с прошлого запуска
        // проверим, лежит ли что-то в базе
        // можно проверить по одной таблице тк остальные связанные к ней
        // таблицу городов не проверяем тк там храним как раз все нужные города
        // что уже добавил пользователь
        CoreDataManager.shared.checkData()
        let listData = CoreDataManager.shared.list
        if listData.count > 0 {
            let weather = CoreDataManager.shared.weather
            let main = CoreDataManager.shared.main
            let wind = CoreDataManager.shared.wind
            let cloud = CoreDataManager.shared.cloud
            CoreDataManager.shared.deleteAllData(list: listData,
                                                 weather: weather,
                                                 main: main,
                                                 wind: wind,
                                                 cloud: cloud)
        }
        
        // путь папки на устройстве -
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
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
        
        //        // Save changes in the application's managed object context when the application transitions to the background.
        //        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
}

