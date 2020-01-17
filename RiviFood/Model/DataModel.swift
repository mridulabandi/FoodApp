import Foundation
import ObjectMapper

class DataModel: NSObject, Mappable
{
    var data : data?

    required init?(map: Map)
    {}

    func mapping(map: Map)
    {
        data <- map["data"]
    }
}

class data: NSObject, Mappable
{
    var card_details : card_details?
    var card : [card]?

    required init?(map: Map)
    {}

    func mapping(map: Map)
    {
        card_details <- map["card_details"]
        card <- map["card"]
    }
}

class card_details: NSObject, Mappable
{
    var title : String?
    var type : String?
    var city : String?

    required init?(map: Map)
    {}

    func mapping(map: Map)
    {
        title <- map["title"]
        type <- map["type"]
        city <- map["city"]
    }
}

class card: NSObject, Mappable
{
    var title : String?
    var desc : String?
    var img : String?
    var card_no :Int?
    var details : details?

    required init?(map: Map)
    {}

    func mapping(map: Map)
    {
        title <- map["title"]
        desc <- map["desc"]
        img <- map["img"]
        card_no <- map["card_no"]
        details <- map["details"]
    }
}

class details: NSObject, Mappable
{
    var about : [String]?
    var location : [location]?
    var dishes : [String]?
    var images :[String]?


    required init?(map: Map)
    {}

    func mapping(map: Map)
    {
        about <- map["about"]
        location <- map["where"]
        dishes <- map["dishes"]
        images <- map["images"]
    }
}

class location: NSObject, Mappable
{
    var name : String?
    var distance : Int?
   
    required init?(map: Map)
     {}
    
    func mapping(map: Map)
    {
        name <- map["name"]
        distance <- map["distance"]
       
    }
}



//
//struct dataModel : Codable {
//
//   var data : [data]?
//}
//
//struct data: Codable {
//   var card_details : card_details?
//    var card : [card]?
//}
//
//struct card_details : Codable {
//    var title : String?
//      var type : String?
//      var city : String?
//}
//
//struct card : Codable {
//    var title : String?
//    var desc : String?
//    var img : String?
//    var card_no :Int?
//    var details : [details]?
//}
//
//struct details : Codable {
//    var about : String?
//       var location : [location]?
//       var dishes : [String]?
//       var images :[String]?
//}
//
//struct location: Codable  {
//    var name : String?
//    var distance : String?
//}
//
//
