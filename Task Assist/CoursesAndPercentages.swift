//
//  CourcesAndPercentages.swift
//  Task Assist
//
//  Created by Ehlers,Corey P on 11/7/16.
//  Copyright © 2016 Makkena,Srinivasa Rao. All rights reserved.
//

import Foundation

class CoursesAndPercentages {
    static var arrayOfCourses:[AnyObject] = []
    static var arrayOfPercentages:[String] = []
    static var arrayOfLetterGrades:[String] = []
    static var token:String = ""
    //"7438~SbwxWklDCgSYyE7ahvE9Hil3xnD5qp59Mj5bdDTy2Fsq7RKG7OsAmvr0CAlmA498"
    //using access token and urls to pull data down from canvas
    class func course(token:String) {
        CoursesAndPercentages.token = token
        if CoursesAndPercentages.token == "" || CoursesAndPercentages.token.characters.count != 69{
            return
        }
        
        let url = "https://canvas.instructure.com/api/v1/users/self/courses?access_token=\(token)&include[]=total_scores"
        let session:NSURLSession = NSURLSession.sharedSession()
        session.dataTaskWithURL( NSURL(string: url)!, completionHandler: processResultsCourse).resume()
        }
    
    
    static var coursePercentageDict:[String:Double]! = [:]
    
    //method for processing results based on the requirments 
    class func processResultsCourse(data:NSData?,response:NSURLResponse?,error:NSError?)->Void {
        do {
            print(token)
            var jsonResult: [AnyObject]
            if error == nil{
                print(error)
            try jsonResult =  NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! [AnyObject]
            // print(jsonResult)
            
            
            for course in jsonResult {
                
                
                
                
                
                
                //                let courseName:String = course["name"] as! String
                //                if course["course_code"] as! String != "NWOnline"{
                //                    arrayOfCourses.append(courseName)
                //                }
                //
                let enrollment = course["enrollments"] as! NSArray
                let courseName = course["name"] as! String
                //print(courseName)
                for data in enrollment{
                    let enrollmentType = (data["type"] as! String )
                    //print(object)
                    if enrollmentType == "student" && courseName != "School of CSIS Student Employment" && courseName != "Welcome To The New Northwest Online"{
                        print(enrollmentType)
                        print(courseName)
                        let percentage =  (data["computed_current_score"])
                        
                        if courseName != "" && percentage == nil{
                            arrayOfPercentages.append("")
                        }else{
                            arrayOfPercentages.append("\(percentage as! Double)")
                            arrayOfCourses.append(courseName)
                        }
                        print(arrayOfCourses)
                        print(arrayOfPercentages)
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                    //                    if  String(data["computed_current_score"]) != "Optional(<null>)" || String(data["computed_current_score"]) != "<null>" {
                    //
                    //                        let str =  data["computed_current_score"]
                    //
                    //                        if  String(str) != "Optional(<null>)" {
                    //
                    //                            if String(data["type"]) != "Optional(ta)" || String(data["type"]) != "Optional(teacher)"{
                    //                               // print(data["type"])
                    //                                arrayOfPercentages.append("\(str as! Double)")
                    //                            }
                    //                        }
                    //
                    //                    }
                    //                }
                    //
                }
            }
            }
            for i in 0 ..< arrayOfCourses.count{
                
                CoursesAndPercentages.coursePercentageDict[arrayOfCourses[i] as! String] = Double(arrayOfPercentages[i])
                
                
            }
            
        }
        catch {
            print("Something went wrong")
            
        }
    }
    
    
    
    //method for grades to show up as letters
    class func letterGrades() -> [String]{
        for percentage in CoursesAndPercentages.arrayOfPercentages
        {
            
            if Double(percentage) < 60.0 {
                CoursesAndPercentages.arrayOfLetterGrades.append("F")
            } else if Double(percentage) >= 60.0 && Double(percentage) < 70.0 {
                CoursesAndPercentages.arrayOfLetterGrades.append("D")
            } else if Double(percentage) >= 70.0 && Double(percentage) < 80.0 {
                CoursesAndPercentages.arrayOfLetterGrades.append("C")
            } else if Double(percentage) >= 80.0 && Double(percentage) < 90.0 {
                CoursesAndPercentages.arrayOfLetterGrades.append("B")
            } else {
                CoursesAndPercentages.arrayOfLetterGrades.append("A")
            }
        }
        return CoursesAndPercentages.arrayOfLetterGrades
    }
    
    
}


//    class func calendar() {
//        let url = "https://canvas.instructure.com/api/v1/users/self/calendar_events?access_token=7438~SbwxWklDCgSYyE7ahvE9Hil3xnD5qp59Mj5bdDTy2Fsq7RKG7OsAmvr0CAlmA498"
//        let session:NSURLSession = NSURLSession.sharedSession()
//        session.dataTaskWithURL( NSURL(string: url)!, completionHandler: processResultsCalendar).resume()
//
//    }

/*
 https://nwmissouri.instructure.com/api/v1/calendar_events?context_codes[]=course_3229&type=assignment&all_events=true&access_token=7438~SbwxWklDCgSYyE7ahvE9Hil3xnD5qp59Mj5bdDTy2Fsq7RKG7OsAmvr0CAlmA498
 */

/*
 https://nwmissouri.instructure.com/api/v1/users/self/upcoming_events?access_token=7438~pTGdpE39MtNDPIhYMe2F7np9XkARvdS27WXmyuCacDxpJ4HUaCa9g55guHehCiO5
 */



//Duncan..   7438~pTGdpE39MtNDPIhYMe2F7np9XkARvdS27WXmyuCacDxpJ4HUaCa9g55guHehCiO5

// satwik... 7438~uQ0nqEcllireQ97oRI0MyU0TntQUvSrLzUeOYdqC9FfhXXhEUq72UTKoCyZgEW6Y

//Mine ....  7438~20sB1iPDlzJSW0KneT6HXtJadThMwq6OQhwKy4lge1lbFhv6k6MbCHxwcVRM0y6I

//Corey ...  7438~SbwxWklDCgSYyE7ahvE9Hil3xnD5qp59Mj5bdDTy2Fsq7RKG7OsAmvr0CAlmA498
