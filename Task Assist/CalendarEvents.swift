//
//  CalendarEvents.swift
//  Task Assist
//
//  Created by Thakkellapati,Meghana on 11/13/16.
//  Copyright © 2016 Makkena,Srinivasa Rao. All rights reserved.
//

import Foundation

class CalendarEvents{
    
    static var eventsArray:[String] = []
    static var dueDateArray:[String] = []
    static var originalDates:[String] = []
    
    static var token:String = ""
    //using token and url to pull certain data down from the canvas data about the events
    class func courses(token:String) {
        CalendarEvents.token = token
        if CalendarEvents.token == "" || CalendarEvents.token.characters.count != 69{
            return
        }
        
        
        let url1 = "https://nwmissouri.instructure.com/api/v1/users/self/upcoming_events?access_token=\(token)"
        
        let session1:NSURLSession = NSURLSession.sharedSession()
        session1.dataTaskWithURL( NSURL(string: url1)!, completionHandler: processResults).resume()
        
    }
    
    class func processResults(data:NSData?,response:NSURLResponse?,error:NSError?)->Void {
        
        do {
            
            var jsonResult: [AnyObject]
            if error == nil{
                try jsonResult =  NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! [AnyObject]
                
                print(jsonResult)
                
                
                for event in jsonResult{
                    let assignment = event["assignment"]
                    if event["type"] as! String == "assignment" && assignment != nil{
                        
                        
                    let dueDateObject = assignment!!["due_at"] as? String
                    //print(assignment)
                    //print(event)
                    //print(assignment!!["due_at"])
                    let type = event["type"] as! String
                    if type == "assignment" && dueDateObject != nil  {
                        let eventTitle =  event["title"]
                        eventsArray.append(eventTitle as! String)
                        
                        let dueDate = assignment!!["due_at"] as? String
                        if dueDate != nil{
                           // print(dueDate)
                            
                            originalDates.append(dueDate!)
                            let dateFormatter:NSDateFormatter = NSDateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                            let date:NSDate? = dateFormatter.dateFromString(dueDate!)
                            
                            dateFormatter.dateFormat = "MMM dd YYYY, hh:mm a"
                            let dates = dateFormatter.stringFromDate(date!)
                            
                            dueDateArray.append(dates)
                            
                            
                        }
                    }
                }
                }
            }
            
        }
        catch {
            print("Something went wrong")
        }
        
    }
    
    // Pass in a String and it will be displayed in an alert view
    
}
