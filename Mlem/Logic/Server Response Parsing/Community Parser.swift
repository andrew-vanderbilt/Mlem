//
//  Community Parser.swift
//  Mlem
//
//  Created by David Bureš on 16.05.2023.
//

import Foundation
import SwiftyJSON

func parseCommunities(communityResponse: String, instanceLink: URL) throws -> [Community]
{
    var communitiesTracker: [Community] = .init()

    do
    {
        let parsedJSON: JSON = try parseJSON(from: communityResponse)

        let communityArray = parsedJSON["communities"].arrayValue

        for community in communityArray
        {
            let newCommunity: Community = .init(
                id: community["community", "id"].intValue,
                name: community["community", "name"].stringValue,
                title: community["community", "title"].string,
                description: community["community", "description"].string,
                icon: community["community", "icon"].url,
                banner: community["community", "banner"].url,
                createdAt: community["community", "published"].string,
                updatedAt: community["community", "updated"].string,
                actorID: community["community", "actor_id"].url!,
                local: community["community", "local"].boolValue,
                deleted: community["community", "deleted"].boolValue,
                nsfw: community["community", "nsfw"].boolValue
            )
            
            communitiesTracker.append(newCommunity)
        }

        return communitiesTracker
    }
    catch let parsingError
    {
        print("Failed while parsing community JSON: \(parsingError)")
        throw JSONParsingError.failedToParse
    }
}
