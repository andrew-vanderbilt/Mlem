//
//  Post.swift
//  Mlem
//
//  Created by David Bureš on 25.03.2022.
//

import Foundation

// MARK: - RawResponsePost
struct RawResponsePost: Codable {
    let op: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let posts: [Post]
}

// MARK: - Post
struct Post: Codable, Identifiable {
    let id: Int
    let name: String
    let url: String?
    let body: String?
    let creatorID, communityID: Int
    let removed, locked: Bool
    let published: String
    let updated: String?
    let deleted, nsfw, stickied, featured: Bool
    let embedTitle, embedDescription, embedHTML: String?
    let thumbnailURL: String?
    let apID: String
    let local: Bool
    let creatorActorID: String
    let creatorLocal: Bool
    let creatorName: String
    let creatorPreferredUsername: JSONNull?
    let creatorPublished: String
    let creatorAvatar: JSONNull?
    let creatorTags: CreatorTags
    let creatorCommunityTags: JSONNull?
    let banned, bannedFromCommunity: Bool
    let communityActorID: String
    let communityLocal: Bool
    let communityName: String
    let communityIcon: JSONNull?
    let communityRemoved, communityDeleted, communityNsfw, communityHideFromAll: Bool
    let numberOfComments, score, upvotes, downvotes: Int
    let hotRank, hotRankActive: Int
    let newestActivityTime: String
    let userID, myVote, subscribed, read: JSONNull?
    let saved: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id, name, url, body
        case creatorID = "creator_id"
        case communityID = "community_id"
        case removed, locked, published, updated, deleted, nsfw, stickied, featured
        case embedTitle = "embed_title"
        case embedDescription = "embed_description"
        case embedHTML = "embed_html"
        case thumbnailURL = "thumbnail_url"
        case apID = "ap_id"
        case local
        case creatorActorID = "creator_actor_id"
        case creatorLocal = "creator_local"
        case creatorName = "creator_name"
        case creatorPreferredUsername = "creator_preferred_username"
        case creatorPublished = "creator_published"
        case creatorAvatar = "creator_avatar"
        case creatorTags = "creator_tags"
        case creatorCommunityTags = "creator_community_tags"
        case banned
        case bannedFromCommunity = "banned_from_community"
        case communityActorID = "community_actor_id"
        case communityLocal = "community_local"
        case communityName = "community_name"
        case communityIcon = "community_icon"
        case communityRemoved = "community_removed"
        case communityDeleted = "community_deleted"
        case communityNsfw = "community_nsfw"
        case communityHideFromAll = "community_hide_from_all"
        case numberOfComments = "number_of_comments"
        case score, upvotes, downvotes
        case hotRank = "hot_rank"
        case hotRankActive = "hot_rank_active"
        case newestActivityTime = "newest_activity_time"
        case userID = "user_id"
        case myVote = "my_vote"
        case subscribed, read, saved
    }
}

// MARK: - CreatorTags
struct CreatorTags: Codable {
    let pronouns: String
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

// MARK: Můj kód
class PostData_Decoded: ObservableObject {
    // TODO: Feed WebSocket response here V
    let postRawData = #"""
    {"op":"GetPosts","data":{"posts":[{"id":183620,"name":"I crumble into dust.","url":"https://www.hexbear.net/pictrs/image/ilsLAsHjXx.jpg","body":null,"creator_id":880,"community_id":12,"removed":false,"locked":false,"published":"2022-03-27T20:45:17.278656","updated":"2022-03-27T20:45:43.945403","deleted":false,"nsfw":false,"stickied":false,"featured":false,"embed_title":null,"embed_description":null,"embed_html":"<img src=\"https://www.hexbear.net/pictrs/image/ilsLAsHjXx.jpg\">","thumbnail_url":"https://www.hexbear.net/pictrs/image/CEkKwuMEqf.jpg","ap_id":"https://www.hexbear.net/post/183620","local":true,"creator_actor_id":"https://www.hexbear.net/u/WoofWoof91","creator_local":true,"creator_name":"WoofWoof91","creator_preferred_username":null,"creator_published":"2020-07-26T09:07:46.535169","creator_avatar":null,"creator_tags":{"pronouns":"comrade/them,any"},"creator_community_tags":null,"banned":false,"banned_from_community":false,"community_actor_id":"https://www.hexbear.net/c/games","community_local":true,"community_name":"games","community_icon":null,"community_removed":false,"community_deleted":false,"community_nsfw":false,"community_hide_from_all":false,"number_of_comments":5,"score":14,"upvotes":14,"downvotes":0,"hot_rank":2144,"hot_rank_active":3356,"newest_activity_time":"2022-03-27T21:18:57.164293","user_id":null,"my_vote":null,"subscribed":null,"read":null,"saved":null},{"id":183619,"name":"I seriously wish I could find the words to fully explain my love for my trans comrades","url":null,"body":"Unfortunately that would require some writing chops that I don't think I'll ever come close to in my lifetime. Still, that won't stop me from trying.\n\nI love my trans comrades!!!  :trans-heart:  :cat-trans:  :trans-heart:  :cat-trans:  :trans-heart:  :cat-trans:  :trans-heart:  :cat-trans:  :trans-heart:  :cat-trans:  :trans-heart:  :cat-trans:  :trans-heart:  :cat-trans:  :trans-heart:  :cat-trans:  :trans-heart:  :cat-trans:","creator_id":2101,"community_id":13,"removed":false,"locked":false,"published":"2022-03-27T20:43:04.769119","updated":null,"deleted":false,"nsfw":false,"stickied":false,"featured":false,"embed_title":null,"embed_description":null,"embed_html":null,"thumbnail_url":null,"ap_id":"https://www.hexbear.net/post/183619","local":true,"creator_actor_id":"https://www.hexbear.net/u/BrookeBaybee","creator_local":true,"creator_name":"BrookeBaybee","creator_preferred_username":null,"creator_published":"2020-07-29T00:31:41.625629","creator_avatar":null,"creator_tags":{"pronouns":"she/her,love/loves"},"creator_community_tags":null,"banned":false,"banned_from_community":false,"community_actor_id":"https://www.hexbear.net/c/transenby_liberation","community_local":true,"community_name":"transenby_liberation","community_icon":null,"community_removed":false,"community_deleted":false,"community_nsfw":false,"community_hide_from_all":false,"number_of_comments":0,"score":12,"upvotes":12,"downvotes":0,"hot_rank":1998,"hot_rank_active":1998,"newest_activity_time":"2022-03-27T20:43:04.769119","user_id":null,"my_vote":null,"subscribed":null,"read":null,"saved":null},{"id":183622,"name":"As far as transportation goes, the US has really taken a huge leap backwards in the past 121 years.","url":"https://www.hexbear.net/pictrs/image/m6AHwetiuI.jpg","body":null,"creator_id":10278,"community_id":8,"removed":false,"locked":false,"published":"2022-03-27T20:49:26.512993","updated":"2022-03-27T20:49:49.466646","deleted":false,"nsfw":false,"stickied":false,"featured":false,"embed_title":null,"embed_description":null,"embed_html":"<img src=\"https://www.hexbear.net/pictrs/image/m6AHwetiuI.jpg\">","thumbnail_url":"https://www.hexbear.net/pictrs/image/Vh0z4AepC7.jpg","ap_id":"https://www.hexbear.net/post/183622","local":true,"creator_actor_id":"https://www.hexbear.net/u/RoabeArt","creator_local":true,"creator_name":"RoabeArt","creator_preferred_username":null,"creator_published":"2020-10-13T00:08:04.363824","creator_avatar":null,"creator_tags":{"pronouns":"he/him"},"creator_community_tags":null,"banned":false,"banned_from_community":false,"community_actor_id":"https://www.hexbear.net/c/history","community_local":true,"community_name":"history","community_icon":null,"community_removed":false,"community_deleted":false,"community_nsfw":false,"community_hide_from_all":false,"number_of_comments":0,"score":8,"upvotes":8,"downvotes":0,"hot_rank":1903,"hot_rank_active":1903,"newest_activity_time":"2022-03-27T20:49:26.512993","user_id":null,"my_vote":null,"subscribed":null,"read":null,"saved":null},{"id":183621,"name":"‘This will be one of the biggest strikes in India since the country’s independence’","url":"https://www.youtube.com/watch?v=Lnx0Mg8TNQA","body":null,"creator_id":175,"community_id":6,"removed":false,"locked":false,"published":"2022-03-27T20:48:09.852665","updated":null,"deleted":false,"nsfw":false,"stickied":false,"featured":false,"embed_title":"‘This will be one of the biggest strikes in India since the country’s independence’","embed_description":"AR Sindhu, National Secretary of CITU (Centre of Indian Trade Unions), joins us to talk about the upcoming National Strike in India on March 28 and 29. She t...","embed_html":"<div style=\"left: 0; width: 100%; height: 0; position: relative; padding-bottom: 56.5%;\"><iframe src=\"https://www.youtube.com/embed/Lnx0Mg8TNQA?feature=oembed\" style=\"border: 0; top: 0; left: 0; width: 100%; height: 100%; position: absolute;\" allowfullscreen scrolling=\"no\" allow=\"encrypted-media; accelerometer; clipboard-write; gyroscope; picture-in-picture\"></iframe></div>","thumbnail_url":"https://www.hexbear.net/pictrs/image/pGxHfO2bKA.jpg","ap_id":"https://www.hexbear.net/post/183621","local":true,"creator_actor_id":"https://www.hexbear.net/u/mrbigcheese","creator_local":true,"creator_name":"mrbigcheese","creator_preferred_username":null,"creator_published":"2020-07-25T23:49:15.739938","creator_avatar":null,"creator_tags":{"pronouns":"he/him"},"creator_community_tags":null,"banned":false,"banned_from_community":false,"community_actor_id":"https://www.hexbear.net/c/news","community_local":true,"community_name":"news","community_icon":null,"community_removed":false,"community_deleted":false,"community_nsfw":false,"community_hide_from_all":false,"number_of_comments":1,"score":8,"upvotes":8,"downvotes":0,"hot_rank":1875,"hot_rank_active":2109,"newest_activity_time":"2022-03-27T20:57:34.016762","user_id":null,"my_vote":null,"subscribed":null,"read":null,"saved":null},{"id":183617,"name":"Redditors are a parody of themselves","url":"https://www.hexbear.net/pictrs/image/gFYlz61kDr.jpg","body":"This guy is asking people in the nicest possible way to consider it's also bad when their own governments destroy cities, and that's still extremely offensive to :reddit-logo:\n\nhttps://old.reddit.com/r/interestingasfuck/comments/tpkzrt/mariupol_ukraine_before_and_after/ link to the post since it's required. Nothing really worth checking out, just various forms of delusional comments","creator_id":18595,"community_id":31,"removed":false,"locked":false,"published":"2022-03-27T20:23:51.628734","updated":null,"deleted":false,"nsfw":false,"stickied":false,"featured":false,"embed_title":null,"embed_description":null,"embed_html":"<img src=\"https://www.hexbear.net/pictrs/image/gFYlz61kDr.jpg\">","thumbnail_url":"https://www.hexbear.net/pictrs/image/C44piIfLoo.jpg","ap_id":"https://www.hexbear.net/post/183617","local":true,"creator_actor_id":"https://www.hexbear.net/u/Tommasi","creator_local":true,"creator_name":"Tommasi","creator_preferred_username":null,"creator_published":"2021-09-11T19:58:23.361480","creator_avatar":null,"creator_tags":{"pronouns":"he/him"},"creator_community_tags":null,"banned":false,"banned_from_community":false,"community_actor_id":"https://www.hexbear.net/c/the_dunk_tank","community_local":true,"community_name":"the_dunk_tank","community_icon":null,"community_removed":false,"community_deleted":false,"community_nsfw":false,"community_hide_from_all":false,"number_of_comments":4,"score":19,"upvotes":19,"downvotes":0,"hot_rank":1833,"hot_rank_active":3815,"newest_activity_time":"2022-03-27T21:22:23.436322","user_id":null,"my_vote":null,"subscribed":null,"read":null,"saved":null},{"id":183624,"name":"\"Rainbow6Siege is a copoganda, fascist game. I like the gameplay, but everything else is bad and I should not like it nor the characters it created.\"","url":null,"body":"Me two minutes later: omg montagne!!!!! :hyperflush:","creator_id":14579,"community_id":12,"removed":false,"locked":false,"published":"2022-03-27T21:17:15.988309","updated":"2022-03-27T21:17:49.037838","deleted":false,"nsfw":false,"stickied":false,"featured":false,"embed_title":null,"embed_description":null,"embed_html":null,"thumbnail_url":null,"ap_id":"https://www.hexbear.net/post/183624","local":true,"creator_actor_id":"https://www.hexbear.net/u/BigAssBlueBug","creator_local":true,"creator_name":"BigAssBlueBug","creator_preferred_username":null,"creator_published":"2021-02-08T17:15:52.009569","creator_avatar":null,"creator_tags":{"pronouns":"they/them"},"creator_community_tags":null,"banned":false,"banned_from_community":false,"community_actor_id":"https://www.hexbear.net/c/games","community_local":true,"community_name":"games","community_icon":null,"community_removed":false,"community_deleted":false,"community_nsfw":false,"community_hide_from_all":false,"number_of_comments":0,"score":2,"upvotes":2,"downvotes":0,"hot_rank":1574,"hot_rank_active":1574,"newest_activity_time":"2022-03-27T21:17:15.988309","user_id":null,"my_vote":null,"subscribed":null,"read":null,"saved":null},{"id":183616,"name":"Outfighting, more like","url":"https://www.hexbear.net/pictrs/image/aaHlQyJVqu.jpg","body":"","creator_id":1490,"community_id":59,"removed":false,"locked":false,"published":"2022-03-27T20:19:04.589811","updated":null,"deleted":false,"nsfw":false,"stickied":false,"featured":false,"embed_title":null,"embed_description":null,"embed_html":"<img src=\"https://www.hexbear.net/pictrs/image/aaHlQyJVqu.jpg\">","thumbnail_url":"https://www.hexbear.net/pictrs/image/il5honpHEG.jpg","ap_id":"https://www.hexbear.net/post/183616","local":true,"creator_actor_id":"https://www.hexbear.net/u/Multihedra","creator_local":true,"creator_name":"Multihedra","creator_preferred_username":null,"creator_published":"2020-07-27T01:38:32.335394","creator_avatar":null,"creator_tags":{"pronouns":"he/him"},"creator_community_tags":null,"banned":false,"banned_from_community":false,"community_actor_id":"https://www.hexbear.net/c/memes","community_local":true,"community_name":"memes","community_icon":null,"community_removed":false,"community_deleted":false,"community_nsfw":false,"community_hide_from_all":false,"number_of_comments":0,"score":12,"upvotes":12,"downvotes":0,"hot_rank":1555,"hot_rank_active":1555,"newest_activity_time":"2022-03-27T20:19:04.589811","user_id":null,"my_vote":null,"subscribed":null,"read":null,"saved":null},{"id":183614,"name":"Yeah, I Read Theory","url":"https://www.hexbear.net/pictrs/image/f7CbdXye9o.png","body":null,"creator_id":20613,"community_id":14,"removed":false,"locked":false,"published":"2022-03-27T20:09:52.959799","updated":null,"deleted":false,"nsfw":false,"stickied":false,"featured":false,"embed_title":null,"embed_description":null,"embed_html":"<img src=\"https://www.hexbear.net/pictrs/image/f7CbdXye9o.png\">","thumbnail_url":"https://www.hexbear.net/pictrs/image/TmX6Q9m2Ix.png","ap_id":"https://www.hexbear.net/post/183614","local":true,"creator_actor_id":"https://www.hexbear.net/u/VitaminB12","creator_local":true,"creator_name":"VitaminB12","creator_preferred_username":null,"creator_published":"2022-02-21T02:23:26.190655","creator_avatar":null,"creator_tags":{"pronouns":"he/him"},"creator_community_tags":null,"banned":false,"banned_from_community":false,"community_actor_id":"https://www.hexbear.net/c/books","community_local":true,"community_name":"literature","community_icon":null,"community_removed":false,"community_deleted":false,"community_nsfw":false,"community_hide_from_all":false,"number_of_comments":3,"score":16,"upvotes":16,"downvotes":0,"hot_rank":1549,"hot_rank_active":2657,"newest_activity_time":"2022-03-27T20:58:33.087681","user_id":null,"my_vote":null,"subscribed":null,"read":null,"saved":null},{"id":183618,"name":"a moment of solemn silence","url":"https://www.hexbear.net/pictrs/image/1aCHQEGJRC.jpg","body":"from DM of the Rings - https://www.shamusyoung.com/twentysidedtale/?p=1136","creator_id":1619,"community_id":12,"removed":false,"locked":false,"published":"2022-03-27T20:39:29.957922","updated":null,"deleted":false,"nsfw":false,"stickied":false,"featured":false,"embed_title":null,"embed_description":null,"embed_html":"<img src=\"https://www.hexbear.net/pictrs/image/1aCHQEGJRC.jpg\">","thumbnail_url":"https://www.hexbear.net/pictrs/image/mLgzAKulN6.jpg","ap_id":"https://www.hexbear.net/post/183618","local":true,"creator_actor_id":"https://www.hexbear.net/u/Tervell","creator_local":true,"creator_name":"Tervell","creator_preferred_username":null,"creator_published":"2020-07-27T07:31:54.662674","creator_avatar":null,"creator_tags":{"pronouns":"he/him"},"creator_community_tags":null,"banned":false,"banned_from_community":false,"community_actor_id":"https://www.hexbear.net/c/games","community_local":true,"community_name":"games","community_icon":null,"community_removed":false,"community_deleted":false,"community_nsfw":false,"community_hide_from_all":false,"number_of_comments":0,"score":4,"upvotes":4,"downvotes":0,"hot_rank":1380,"hot_rank_active":1380,"newest_activity_time":"2022-03-27T20:39:29.957922","user_id":null,"my_vote":null,"subscribed":null,"read":null,"saved":null},{"id":183625,"name":"Kitten and Big-D's Primer on the Supernatural and Local Folklore - Hunter: The Parenting Audiologs","url":"https://youtu.be/wWfo0hg7biU","body":"This is humorously insane yet spooky. Hey [@Tervell](/u/Tervell) i think this may be right up your alley since our tastes in content way similar.","creator_id":1849,"community_id":38,"removed":false,"locked":false,"published":"2022-03-27T21:23:40.272890","updated":null,"deleted":false,"nsfw":false,"stickied":false,"featured":false,"embed_title":"Kitten and Big-D's Primer on the Supernatural and Local Folklore - Hunter: The Parenting Audiologs","embed_description":"Audio version is available here:https://soundcloud.com/user-117843151/hunter-the-parenting-audio-drama-1Important note! Chronologically, this takes place bef...","embed_html":"<div style=\"left: 0; width: 100%; height: 0; position: relative; padding-bottom: 56.5%;\"><iframe src=\"https://www.youtube.com/embed/wWfo0hg7biU?feature=oembed\" style=\"border: 0; top: 0; left: 0; width: 100%; height: 100%; position: absolute;\" allowfullscreen scrolling=\"no\" allow=\"encrypted-media; accelerometer; clipboard-write; gyroscope; picture-in-picture\"></iframe></div>","thumbnail_url":"https://www.hexbear.net/pictrs/image/D6KsB0MHal.jpg","ap_id":"https://www.hexbear.net/post/183625","local":true,"creator_actor_id":"https://www.hexbear.net/u/Alaskaball","creator_local":true,"creator_name":"Alaskaball","creator_preferred_username":null,"creator_published":"2020-07-28T02:26:58.136393","creator_avatar":null,"creator_tags":{"pronouns":"comrade/them,use name"},"creator_community_tags":null,"banned":false,"banned_from_community":false,"community_actor_id":"https://www.hexbear.net/c/videos","community_local":true,"community_name":"videos","community_icon":null,"community_removed":false,"community_deleted":false,"community_nsfw":false,"community_hide_from_all":false,"number_of_comments":0,"score":2,"upvotes":2,"downvotes":0,"hot_rank":1370,"hot_rank_active":1370,"newest_activity_time":"2022-03-27T21:23:40.272890","user_id":null,"my_vote":null,"subscribed":null,"read":null,"saved":null}]}}
"""#
 
    @Published var isLoading = false
    @Published var decodedPosts = [Post]()
    
    func decodeRawJSON() {
        do {
            let decoder = JSONDecoder()
            let decodedPosts = try? decoder.decode(RawResponsePost.self, from: postRawData.data(using: .utf8)!)
            
            print("Decoding:")
            print(postRawData)
            
            print("Into:")
            print(decodedPosts)
            self.decodedPosts = (decodedPosts?.data.posts)!
        } catch {
            print("Failed to decode: \(error)")
        }
    }
}
