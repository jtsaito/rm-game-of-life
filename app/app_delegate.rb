class AppDelegate

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    # UIScreen describes the display our app is running on
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible

    @window.rootViewController = TapController.alloc.initWithNibName(nil, bundle: nil)
    
    true
  end

  def alert_stuff
    alert = UIAlertView.new
    alert.message = "width: #{@window.frame.size.width}"
    alert.show
  end

end
