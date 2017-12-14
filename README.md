# TeamErica
Team Project for MIT 6.811 Assistive Technology
iNotify is a discrete and customizable iOS notification app that allows the user to easily and effectively communicate and seek help while experiencing symptoms of aphasia. The app includes three main communication features, as well as an analytics feature: 
  + Notify: Sends pre-customized emails and texts to recipients. Used for instances when one wants to alert others of their current state but does not send the location within the message. 
> Get Help: Sends pre-customized texts with the location to the recipient. Used in instances when the user is seeking help from the recipient of the message. 
> Display: Show a pre-set message to passerby who may be wondering of the best way to help the individual. 
INotify is not available on the Apple’s app store yet however users will be able to download it to their iphone by following the steps below:
Download and install XCode from the app store.
Clone the GitHub repository onto your local computer:
> Go to the following link: https://github.com/williamrodz/TeamErica
> Click on the green “Clone or Download” button on the right side of the screen
> Click on “Open in XCode”. It will clone it to your computer and opens it in XCode
Download CocoaPods onto your computer by following these steps:
> Open terminal and type: sudo gem install cocoapods
> If there is an error "activesupport requires Ruby version >= 2.xx", then install latest activesupport first by typing in terminal. sudo gem install activesupport -v 4.2.6
> After installation, there will be a lot of messages, read them and if no error found, it means cocoapods installation is done.
> Next, you need to setup the cocoapods master repo. Type in terminal: pod setup
> Once done it will output "Setup Complete", and you can create your XCode project and save it.
> Then in terminal cd to "your XCode project root directory" (where your .xcodeproj file resides) and type: pod init
> Then install pods into your project by typing in terminal: pod install
> Once completed, there will be a message that says "Pod installation complete! There are X dependencies from the Podfile and X total pods installed."
Now close your xcode project and open .xcworkspace xcode project file
Now choose the iPhone model type at the top left of the XCode screen. We built it for iPhone 6.
Connect your iPhone to the computer and go to Window → Devices and Simulators → Select your connected device → Check the “Connect via network” box.
Unplug and press the Run button!


6) Connect your iPhone to the computer and go to Window → Devices and Simulators → Select your connected device → Check the “Connect via network” box.

7) Unplug and press the Run button!

