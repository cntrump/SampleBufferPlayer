/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The `AppDelegate` application delegate object manages the application lifecycle.
*/

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: NSObject, UIApplicationDelegate {
    
    var window: UIWindow?
    var audioSessionObserver: Any!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Observe AVAudioSession notifications.
        
        // Note that a real app might need to observe other AVAudioSession notifications, too,
        // especially if it needs to properlay handle playback interruptions when the app is
        // in the background.
        let notificationCenter = NotificationCenter.default
        
        audioSessionObserver = notificationCenter.addObserver(forName: AVAudioSession.mediaServicesWereResetNotification,
                                                              object: nil,
                                                              queue: nil) { [unowned self] _ in
            self.setUpAudioSession()
        }
        
        // Configure the audio session initially.
        setUpAudioSession()
        
        return true
    }
    
    // A helper method that configures the app's audio session.
    // Note that the `.longForm` policy indicates that the app's audio output should use AirPlay 2
    // for playback.
    /// - Tag: LongForm
    private func setUpAudioSession() {
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, policy: .longForm)
        } catch {
            print("Failed to set audio session route sharing policy: \(error)")
        }
    }
}
