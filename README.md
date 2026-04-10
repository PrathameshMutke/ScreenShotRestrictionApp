📱 **iOS Screen Recording & Screenshot Restriction App**
<p align="center"> <b>Normal Screen</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>Protected Screen</b> </p> <p align="center"> <img src="https://github.com/user-attachments/assets/f21f1165-1082-494b-9957-3ade5f080153" width="30%" /> <img src="https://github.com/user-attachments/assets/3476593b-c665-42cc-b692-397889784bd5" width="30%" /> </p>

📌 **Overview** <br>
This is a simple iOS project that helps keep your app's content private. It's designed to stop people from easily saving or sharing sensitive information by hiding specific parts of the screen during a screenshot or recording.

⚠️ **Important Notes** <br>
It is important to understand that iOS does not allow apps to globally disable the screenshot button combination. Instead, this app detects when a capture is happening and hides the sensitive parts of the screen so they just show up as black or empty.

🛠️ **Tech Stack** <br>
Language: Swift<br>
Framework: UIKit<br>
Interface: Storyboards & Auto Layout<br>

✨ **What it can do** <br>
🔒 Hide Secret Views: It makes specific parts of your screen invisible if someone takes a screenshot.<br>
🎥 Stop Screen Recording: If someone starts recording their screen, the app detects it immediately.<br>
🛑 Privacy Overlay: As soon as recording starts, a black "Privacy Screen" covers the app so nothing can be seen.<br>
⚠️ User Alerts: It shows a pop-up message telling the user that recording isn't allowed.<br>

⚙️ **How It Works** <br>
1. 🔐 The SecureView (Screenshot Protection)<br>
The SecureView class uses a creative "hack" involving a UITextField with isSecureTextEntry enabled.<br>
The Mechanism: iOS protects the content of "secure" text fields (like passwords) by hiding them from screenshots.<br>
Content Injection: This class identifies the internal "Canvas" subview of the UITextField and moves your custom UI elements into it.<br>
Result: The user sees the content normally, but the system's screen-capture engine ignores it.<br>

3. 🎬 SceneDelegate (Recording Protection)<br>
For screen recordings, the app monitors the UIScreen.capturedDidChangeNotification.<br>
Detection: The checkRecordingStatus() function checks UIScreen.main.isCaptured.<br>
Blackout: If true, a blackoutView is added to the window, and a security alert is presented to the user.<br>
Restoration: Once recording is stopped, the blackout view is removed, and the app becomes usable again.<br>

📂 **Project Structure** <br>
SecureView.swift → The reusable component that hides content from screenshots<br>
SceneDelegate.swift → Manages app-wide recording detection and the blackout UI<br>
Main.storyboard → Defines the layout, including the SecureView assigned to protected UI elements<br>
ViewController.swift → Controls the logic and connects the secure content view<br>

🚀 **How to use it** <br>
Open the project in Xcode<br>
Pick any View in your Storyboard<br>
Change its class to SecureView in the Identity Inspector<br>
That’s it! Anything inside that view is now protected<br>

📋 **Requirements** <br>
iOS: 13.0+
Xcode: 15.0+
