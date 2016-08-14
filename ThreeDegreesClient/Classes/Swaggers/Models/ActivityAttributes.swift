//
// ActivityAttributes.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Contains metadata necessary for responding to various activities. Essentially a strongly-typed map. */
public class ActivityAttributes: JSONEncodable {
    /** A generic id; what it represents depends on the ActivityResponseType. */
    public var id: Int32?
    /** The username of a users to respond to. */
    public var username: String?

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> AnyObject {
        var nillableDictionary = [String:AnyObject?]()
        nillableDictionary["id"] = self.id?.encodeToJSON()
        nillableDictionary["username"] = self.username
        let dictionary: [String:AnyObject] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}