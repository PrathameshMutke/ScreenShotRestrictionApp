iOS Screen Recording & Screenshot Restriction App

<p align="center">
  <b>Normal Screen</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <b>Protected Screen</b>
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/f21f1165-1082-494b-9957-3ade5f080153" width="30%" />
  <img src="https://github.com/user-attachments/assets/3476593b-c665-42cc-b692-397889784bd5" width="30%" />
</p>

Overview:
This is a simple iOS project that helps keep your app's content private. It's designed to stop people from easily saving or sharing sensitive information by hiding specific parts of the screen during a screenshot or recording.

Important Notes:
It is important to understand that iOS does not allow apps to globally disable the screenshot button combination. Instead, this app detects when a capture is happening and hides the sensitive parts of the screen so they just show up as black or empty.

Tech Stack:
  * Language: Swift
  * Framework: UIKit
  * Interface: Storyboards & Auto Layout

What it can do:
  * Hide Secret Views: It makes specific parts of your screen invisible if someone takes a screenshot.
  * Stop Screen Recording: If someone starts recording their screen, the app detects it immediately.
  * Privacy Overlay: As soon as recording starts, a black "Privacy Screen" covers the app so nothing can be seen.
  * User Alerts: It shows a pop-up message telling the user that recording isn't allowed.  

How It Works
  1. The SecureView (Screenshot Protection)
  The SecureView class uses a creative "hack" involving a UITextField with isSecureTextEntry enabled.
    * The Mechanism: iOS protects the content of "secure" text fields (like passwords) by hiding them from screenshots.
    * Content Injection: This class identifies the internal "Canvas" subview of the UITextField and moves your custom UI elements into it.
    * Result: The user sees the content normally, but the system's screen-capture engine ignores it. 

  2. SceneDelegate (Recording Protection)
  For screen recordings, the app monitors the UIScreen.capturedDidChangeNotification.
    * Detection: The checkRecordingStatus() function checks UIScreen.main.isCaptured.
    * Blackout: If true, a blackoutView is added to the window, and a security alert is presented to the user.
    * Restoration: Once recording is stopped, the blackout view is removed, and the app becomes usable again.

Project Structure
  * SecureView.swift: The reusable component that hides content from screenshots.
  * SceneDelegate.swift: Manages app-wide recording detection and the blackout UI.
  * Main.storyboard: Defines the layout, including the SecureView assigned to protected UI elements.
  * ViewController.swift: Controls the logic and connects the secure content view.

How to use it:
  1. Open the project in Xcode.
  2. Pick any View in your Storyboard.
  3. Change its class to SecureView in the Identity Inspector.
  4. That's it! Anything inside that view is now protected.

Requirements
  * iOS: 13.0+
  * Xcode: 15.0+
