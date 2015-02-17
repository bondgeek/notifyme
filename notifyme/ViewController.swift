//
//  ViewController.swift
//  notifyme
//
//  Created by bondgeek on 2/16/15.
//  Copyright (c) 2015 bgresearch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBAction func bugme10Seconds(sender: AnyObject) {
        var localNotification:UILocalNotification = UILocalNotification()
        localNotification.alertBody = "Poke"
        localNotification.soundName = UILocalNotificationDefaultSoundName // or nil
        localNotification.applicationIconBadgeNumber = 1
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 10)
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    @IBAction func bugmeAlot(sender: AnyObject) {
        var notifications:[UILocalNotification] = [UILocalNotification]()
        let now = NSDate()
        for count in 1...8 {
            let pokeInterval = NSTimeInterval(Float(count) * 10.0)
            var thispoke:UILocalNotification = UILocalNotification()
            thispoke.alertBody = "Poke number \(count)!!!!"
            thispoke.alertAction = "say OK!"
            thispoke.applicationIconBadgeNumber = count
            thispoke.fireDate = NSDate(timeInterval: pokeInterval, sinceDate: now)
            
            notifications.append(thispoke)
        }
        UIApplication.sharedApplication().scheduledLocalNotifications = notifications
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Specify the notification actions.
        var sayEnoughAction = UIMutableUserNotificationAction()
        sayEnoughAction.identifier = "sayEnough"
        sayEnoughAction.title = "Enough! "
        sayEnoughAction.activationMode = UIUserNotificationActivationMode.Background
        sayEnoughAction.destructive = true
        sayEnoughAction.authenticationRequired = false
        
        let actionsArray = NSArray(objects: sayEnoughAction)
        
        // Specify the category related to the above actions.
        var bugmeReminderCategory = UIMutableUserNotificationCategory()
        bugmeReminderCategory.identifier = "bugmeAlotCategory"
        bugmeReminderCategory.setActions(actionsArray, forContext: UIUserNotificationActionContext.Default)
        bugmeReminderCategory.setActions(actionsArray, forContext: UIUserNotificationActionContext.Minimal)
        
        let categoriesForSettings = NSSet(objects: bugmeReminderCategory)
        
        // Register the notification settings.
        var notificationTypes: UIUserNotificationType = UIUserNotificationType.Alert | UIUserNotificationType.Sound | UIUserNotificationType.Badge
        let newNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: categoriesForSettings)
        UIApplication.sharedApplication().registerUserNotificationSettings(newNotificationSettings)
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
    
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleSayEnoughNotification", name: "sayEnoughNotification", object: nil)
        
    }
    
    func handleSayEnoughNotification() {
        UIApplication.sharedApplication().cancelAllLocalNotifications()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

