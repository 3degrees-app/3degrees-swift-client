// Models.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation

protocol JSONEncodable {
    func encodeToJSON() -> AnyObject
}

public enum ErrorResponse : ErrorType {
    case RawError(Int, NSData?, ErrorType)
    case MeGet400(Error)
    case MeGet403(Error)
}

public class Response<T> {
    public let statusCode: Int
    public let header: [String: String]
    public let body: T

    public init(statusCode: Int, header: [String: String], body: T) {
        self.statusCode = statusCode
        self.header = header
        self.body = body
    }

    public convenience init(response: NSHTTPURLResponse, body: T) {
        let rawHeader = response.allHeaderFields
        var header = [String:String]()
        for (key, value) in rawHeader {
            header[key as! String] = value as? String
        }
        self.init(statusCode: response.statusCode, header: header, body: body)
    }
}

private var once = dispatch_once_t()
class Decoders {
    static private var decoders = Dictionary<String, ((AnyObject) -> AnyObject)>()

    static func addDecoder<T>(clazz clazz: T.Type, decoder: ((AnyObject) -> T)) {
        let key = "\(T.self)"
        decoders[key] = { decoder($0) as! AnyObject }
    }

    static func decode<T>(clazz clazz: [T].Type, source: AnyObject) -> [T] {
        let array = source as! [AnyObject]
        return array.map { Decoders.decode(clazz: T.self, source: $0) }
    }

    static func decode<T, Key: Hashable>(clazz clazz: [Key:T].Type, source: AnyObject) -> [Key:T] {
        let sourceDictionary = source as! [Key: AnyObject]
        var dictionary = [Key:T]()
        for (key, value) in sourceDictionary {
            dictionary[key] = Decoders.decode(clazz: T.self, source: value)
        }
        return dictionary
    }

    static func decode<T>(clazz clazz: T.Type, source: AnyObject) -> T {
        initialize()
        if T.self is Int32.Type && source is NSNumber {
            return source.intValue as! T;
        }
        if T.self is Int64.Type && source is NSNumber {
            return source.longLongValue as! T;
        }
        if source is T {
            return source as! T
        }

        let key = "\(T.self)"
        if let decoder = decoders[key] {
           return decoder(source) as! T
        } else {
            fatalError("Source \(source) is not convertible to type \(clazz): Maybe swagger file is insufficient")
        }
    }

    static func decodeOptional<T>(clazz clazz: T.Type, source: AnyObject?) -> T? {
        if source is NSNull {
            return nil
        }
        return source.map { (source: AnyObject) -> T in
            Decoders.decode(clazz: clazz, source: source)
        }
    }

    static func decodeOptional<T>(clazz clazz: [T].Type, source: AnyObject?) -> [T]? {
        if source is NSNull {
            return nil
        }
        return source.map { (someSource: AnyObject) -> [T] in
            Decoders.decode(clazz: clazz, source: someSource)
        }
    }

    static func decodeOptional<T, Key: Hashable>(clazz clazz: [Key:T].Type, source: AnyObject?) -> [Key:T]? {
        if source is NSNull {
            return nil
        }
        return source.map { (someSource: AnyObject) -> [Key:T] in
            Decoders.decode(clazz: clazz, source: someSource)
        }
    }

    static private func initialize() {
        dispatch_once(&once) {
            let formatters = [
                "yyyy-MM-dd",
                "yyyy-MM-dd'T'HH:mm:ssZZZZZ",
                "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ",
                "yyyy-MM-dd'T'HH:mm:ss'Z'",
                "yyyy-MM-dd'T'HH:mm:ss.SSS"
            ].map { (format: String) -> NSDateFormatter in
                let formatter = NSDateFormatter()
                formatter.dateFormat = format
                return formatter
            }
            // Decoder for NSDate
            Decoders.addDecoder(clazz: NSDate.self) { (source: AnyObject) -> NSDate in
               if let sourceString = source as? String {
                    for formatter in formatters {
                        if let date = formatter.dateFromString(sourceString) {
                            return date
                        }
                    }

                }
                if let sourceInt = source as? Int {
                    // treat as a java date
                    return NSDate(timeIntervalSince1970: Double(sourceInt / 1000) )
                }
                fatalError("formatter failed to parse \(source)")
            } 

            // Decoder for [Activity]
            Decoders.addDecoder(clazz: [Activity].self) { (source: AnyObject) -> [Activity] in
                return Decoders.decode(clazz: [Activity].self, source: source)
            }
            // Decoder for Activity
            Decoders.addDecoder(clazz: Activity.self) { (source: AnyObject) -> Activity in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = Activity()
                instance.endpoints = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["endpoints"])
                instance.icon = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["icon"])
                instance.id = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["id"])
                instance.text = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["text"])
                instance.timestamp = Decoders.decodeOptional(clazz: NSDate.self, source: sourceDictionary["timestamp"])
                instance.viewed = Decoders.decodeOptional(clazz: Bool.self, source: sourceDictionary["viewed"])
                return instance
            }


            // Decoder for [ActivityEndpoint]
            Decoders.addDecoder(clazz: [ActivityEndpoint].self) { (source: AnyObject) -> [ActivityEndpoint] in
                return Decoders.decode(clazz: [ActivityEndpoint].self, source: source)
            }
            // Decoder for ActivityEndpoint
            Decoders.addDecoder(clazz: ActivityEndpoint.self) { (source: AnyObject) -> ActivityEndpoint in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = ActivityEndpoint()
                instance.uri = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["uri"])
                instance.message = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["message"])
                return instance
            }


            // Decoder for [BaseUser]
            Decoders.addDecoder(clazz: [BaseUser].self) { (source: AnyObject) -> [BaseUser] in
                return Decoders.decode(clazz: [BaseUser].self, source: source)
            }
            // Decoder for BaseUser
            Decoders.addDecoder(clazz: BaseUser.self) { (source: AnyObject) -> BaseUser in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = BaseUser()
                instance.firstName = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["first_name"])
                instance.image = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["image"])
                instance.lastName = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["last_name"])
                instance.username = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["username"])
                return instance
            }


            // Decoder for [Content]
            Decoders.addDecoder(clazz: [Content].self) { (source: AnyObject) -> [Content] in
                return Decoders.decode(clazz: [Content].self, source: source)
            }
            // Decoder for Content
            Decoders.addDecoder(clazz: Content.self) { (source: AnyObject) -> Content in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = Content()
                instance.content = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["content"])
                return instance
            }


            // Decoder for [Date]
            Decoders.addDecoder(clazz: [Date].self) { (source: AnyObject) -> [Date] in
                return Decoders.decode(clazz: [Date].self, source: source)
            }
            // Decoder for Date
            Decoders.addDecoder(clazz: Date.self) { (source: AnyObject) -> Date in
                let instance = Date()
                return instance
            }


            // Decoder for [DateTime]
            Decoders.addDecoder(clazz: [DateTime].self) { (source: AnyObject) -> [DateTime] in
                return Decoders.decode(clazz: [DateTime].self, source: source)
            }
            // Decoder for DateTime
            Decoders.addDecoder(clazz: DateTime.self) { (source: AnyObject) -> DateTime in
                let instance = DateTime()
                return instance
            }


            // Decoder for [Education]
            Decoders.addDecoder(clazz: [Education].self) { (source: AnyObject) -> [Education] in
                return Decoders.decode(clazz: [Education].self, source: source)
            }
            // Decoder for Education
            Decoders.addDecoder(clazz: Education.self) { (source: AnyObject) -> Education in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = Education()
                instance.degree = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["degree"])
                instance.school = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["school"])
                return instance
            }


            // Decoder for [Employment]
            Decoders.addDecoder(clazz: [Employment].self) { (source: AnyObject) -> [Employment] in
                return Decoders.decode(clazz: [Employment].self, source: source)
            }
            // Decoder for Employment
            Decoders.addDecoder(clazz: Employment.self) { (source: AnyObject) -> Employment in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = Employment()
                instance.company = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["company"])
                instance.title = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["title"])
                return instance
            }


            // Decoder for [Empty]
            Decoders.addDecoder(clazz: [Empty].self) { (source: AnyObject) -> [Empty] in
                return Decoders.decode(clazz: [Empty].self, source: source)
            }
            // Decoder for Empty
            Decoders.addDecoder(clazz: Empty.self) { (source: AnyObject) -> Empty in
                let instance = Empty()
                return instance
            }


            // Decoder for [Error]
            Decoders.addDecoder(clazz: [Error].self) { (source: AnyObject) -> [Error] in
                return Decoders.decode(clazz: [Error].self, source: source)
            }
            // Decoder for Error
            Decoders.addDecoder(clazz: Error.self) { (source: AnyObject) -> Error in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = Error()
                instance.type = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["type"])
                instance.message = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["message"])
                return instance
            }


            // Decoder for [Image]
            Decoders.addDecoder(clazz: [Image].self) { (source: AnyObject) -> [Image] in
                return Decoders.decode(clazz: [Image].self, source: source)
            }
            // Decoder for Image
            Decoders.addDecoder(clazz: Image.self) { (source: AnyObject) -> Image in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = Image()
                instance.url = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["url"])
                return instance
            }


            // Decoder for [Location]
            Decoders.addDecoder(clazz: [Location].self) { (source: AnyObject) -> [Location] in
                return Decoders.decode(clazz: [Location].self, source: source)
            }
            // Decoder for Location
            Decoders.addDecoder(clazz: Location.self) { (source: AnyObject) -> Location in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = Location()
                instance.city = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["city"])
                instance.state = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["state"])
                instance.country = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["country"])
                return instance
            }


            // Decoder for [LoginForm]
            Decoders.addDecoder(clazz: [LoginForm].self) { (source: AnyObject) -> [LoginForm] in
                return Decoders.decode(clazz: [LoginForm].self, source: source)
            }
            // Decoder for LoginForm
            Decoders.addDecoder(clazz: LoginForm.self) { (source: AnyObject) -> LoginForm in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = LoginForm()
                instance.facebook = Decoders.decodeOptional(clazz: LoginFormFacebook.self, source: sourceDictionary["facebook"])
                instance.email = Decoders.decodeOptional(clazz: LoginFormEmail.self, source: sourceDictionary["email"])
                return instance
            }


            // Decoder for [LoginFormEmail]
            Decoders.addDecoder(clazz: [LoginFormEmail].self) { (source: AnyObject) -> [LoginFormEmail] in
                return Decoders.decode(clazz: [LoginFormEmail].self, source: source)
            }
            // Decoder for LoginFormEmail
            Decoders.addDecoder(clazz: LoginFormEmail.self) { (source: AnyObject) -> LoginFormEmail in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = LoginFormEmail()
                instance.emailAddress = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["email_address"])
                instance.password = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["password"])
                return instance
            }


            // Decoder for [LoginFormFacebook]
            Decoders.addDecoder(clazz: [LoginFormFacebook].self) { (source: AnyObject) -> [LoginFormFacebook] in
                return Decoders.decode(clazz: [LoginFormFacebook].self, source: source)
            }
            // Decoder for LoginFormFacebook
            Decoders.addDecoder(clazz: LoginFormFacebook.self) { (source: AnyObject) -> LoginFormFacebook in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = LoginFormFacebook()
                instance.accessToken = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["access_token"])
                instance.authCode = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["auth_code"])
                return instance
            }


            // Decoder for [Message]
            Decoders.addDecoder(clazz: [Message].self) { (source: AnyObject) -> [Message] in
                return Decoders.decode(clazz: [Message].self, source: source)
            }
            // Decoder for Message
            Decoders.addDecoder(clazz: Message.self) { (source: AnyObject) -> Message in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = Message()
                instance.message = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["message"])
                instance.messageType = Message.MessageType(rawValue: (sourceDictionary["message_type"] as? String) ?? "") 
                instance.recipient = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["recipient"])
                instance.sender = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["sender"])
                instance.timestamp = Decoders.decodeOptional(clazz: NSDate.self, source: sourceDictionary["timestamp"])
                return instance
            }


            // Decoder for [MessageForm]
            Decoders.addDecoder(clazz: [MessageForm].self) { (source: AnyObject) -> [MessageForm] in
                return Decoders.decode(clazz: [MessageForm].self, source: source)
            }
            // Decoder for MessageForm
            Decoders.addDecoder(clazz: MessageForm.self) { (source: AnyObject) -> MessageForm in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = MessageForm()
                instance.message = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["message"])
                return instance
            }


            // Decoder for [PrivateUser]
            Decoders.addDecoder(clazz: [PrivateUser].self) { (source: AnyObject) -> [PrivateUser] in
                return Decoders.decode(clazz: [PrivateUser].self, source: source)
            }
            // Decoder for PrivateUser
            Decoders.addDecoder(clazz: PrivateUser.self) { (source: AnyObject) -> PrivateUser in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = PrivateUser()
                instance.firstName = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["first_name"])
                instance.image = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["image"])
                instance.lastName = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["last_name"])
                instance.username = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["username"])
                instance.bio = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["bio"])
                instance.dob = Decoders.decodeOptional(clazz: NSDate.self, source: sourceDictionary["dob"])
                instance.education = Decoders.decodeOptional(clazz: Education.self, source: sourceDictionary["education"])
                instance.employment = Decoders.decodeOptional(clazz: Employment.self, source: sourceDictionary["employment"])
                instance.gender = PrivateUser.Gender(rawValue: (sourceDictionary["gender"] as? String) ?? "") 
                instance.isSingle = Decoders.decodeOptional(clazz: Bool.self, source: sourceDictionary["is_single"])
                instance.location = Decoders.decodeOptional(clazz: Location.self, source: sourceDictionary["location"])
                instance.matchWithGender = PrivateUser.MatchWithGender(rawValue: (sourceDictionary["match_with_gender"] as? String) ?? "") 
                instance.matchmakers = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["matchmakers"])
                instance.emailAddress = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["email_address"])
                instance.password = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["password"])
                return instance
            }


            // Decoder for [SessionKey]
            Decoders.addDecoder(clazz: [SessionKey].self) { (source: AnyObject) -> [SessionKey] in
                return Decoders.decode(clazz: [SessionKey].self, source: source)
            }
            // Decoder for SessionKey
            Decoders.addDecoder(clazz: SessionKey.self) { (source: AnyObject) -> SessionKey in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = SessionKey()
                instance.key = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["key"])
                return instance
            }


            // Decoder for [SubscriptionMetadata]
            Decoders.addDecoder(clazz: [SubscriptionMetadata].self) { (source: AnyObject) -> [SubscriptionMetadata] in
                return Decoders.decode(clazz: [SubscriptionMetadata].self, source: source)
            }
            // Decoder for SubscriptionMetadata
            Decoders.addDecoder(clazz: SubscriptionMetadata.self) { (source: AnyObject) -> SubscriptionMetadata in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = SubscriptionMetadata()
                instance.deviceToken = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["device_token"])
                return instance
            }


            // Decoder for [User]
            Decoders.addDecoder(clazz: [User].self) { (source: AnyObject) -> [User] in
                return Decoders.decode(clazz: [User].self, source: source)
            }
            // Decoder for User
            Decoders.addDecoder(clazz: User.self) { (source: AnyObject) -> User in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = User()
                instance.firstName = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["first_name"])
                instance.image = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["image"])
                instance.lastName = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["last_name"])
                instance.username = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["username"])
                instance.bio = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["bio"])
                instance.dob = Decoders.decodeOptional(clazz: NSDate.self, source: sourceDictionary["dob"])
                instance.education = Decoders.decodeOptional(clazz: Education.self, source: sourceDictionary["education"])
                instance.employment = Decoders.decodeOptional(clazz: Employment.self, source: sourceDictionary["employment"])
                instance.gender = User.Gender(rawValue: (sourceDictionary["gender"] as? String) ?? "") 
                instance.isSingle = Decoders.decodeOptional(clazz: Bool.self, source: sourceDictionary["is_single"])
                instance.location = Decoders.decodeOptional(clazz: Location.self, source: sourceDictionary["location"])
                instance.matchWithGender = User.MatchWithGender(rawValue: (sourceDictionary["match_with_gender"] as? String) ?? "") 
                instance.matchmakers = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["matchmakers"])
                return instance
            }


            // Decoder for [UserForm]
            Decoders.addDecoder(clazz: [UserForm].self) { (source: AnyObject) -> [UserForm] in
                return Decoders.decode(clazz: [UserForm].self, source: source)
            }
            // Decoder for UserForm
            Decoders.addDecoder(clazz: UserForm.self) { (source: AnyObject) -> UserForm in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = UserForm()
                instance.fbAccessToken = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["fb_access_token"])
                instance.fbAuthCode = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["fb_auth_code"])
                instance.user = Decoders.decodeOptional(clazz: PrivateUser.self, source: sourceDictionary["user"])
                return instance
            }
        }
    }
}
