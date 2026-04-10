//
//  SceneDelegate.swift
//  ScreenShotRestrictionApp
//
//  Created by Prathamesh on 07/04/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private var blackoutView: UIView?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        // here i have added NotificationCenter to detect is Screen Resording is on or not
        NotificationCenter.default.addObserver(forName: UIScreen.capturedDidChangeNotification, object: nil, queue: .main) { _ in
            self.checkRecordingStatus()
        }
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
        checkRecordingStatus()
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
    
    func checkRecordingStatus() {
        DispatchQueue.main.async {
            if UIScreen.main.isCaptured {
                self.showBlackout()
            } else {
                self.hideBlackout()
            }
        }
    }
    
    private func showBlackout() {
        guard let window = window else { return }
        
        if blackoutView == nil {
            blackoutView = UIView(frame: window.bounds)
            blackoutView?.backgroundColor = .black
            
            let label = UILabel()
            label.text = "Recording Blocked \nPlease stop recording to continue"
            label.textColor = .white
            label.numberOfLines = 0
            label.textAlignment = .center
            label.font = .boldSystemFont(ofSize: 18)
            
            blackoutView?.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: blackoutView!.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: blackoutView!.centerYAnchor),
                label.leadingAnchor.constraint(equalTo: blackoutView!.leadingAnchor, constant: 20),
                label.trailingAnchor.constraint(equalTo: blackoutView!.trailingAnchor, constant: -20)
            ])
        }
        
        if blackoutView?.superview == nil {
            window.addSubview(blackoutView!)
            
            // Safety check: only present if the root controller is ready
            if let rootVC = window.rootViewController {
                let alert = UIAlertController(title: "Security Alert", message: "Screen recording is not allowed. Stop Screen Recording to use this app", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    self.checkRecordingStatus()
                }))
                
                // If an alert is already presented, don't present again
                if rootVC.presentedViewController == nil {
                    rootVC.present(alert, animated: true)
                }
            }
        }
    }
    
    private func hideBlackout() {
        blackoutView?.removeFromSuperview()
        blackoutView = nil
        // Dismiss alert if exists
        window?.rootViewController?.dismiss(animated: true)
    }
    
}

