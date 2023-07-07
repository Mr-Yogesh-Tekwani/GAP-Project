//
//  URLManager.swift
//  GAP International
//
//  Created by Yogesh on 6/19/23.
//

import Foundation

var link = "https://gapinternationalwebapi20200521010239.azurewebsites.net"
var url = URL(string: link)

var createUserLink = link + "/api/User/CreateUserAccount"
var createUserUrl = URL(string: createUserLink)

var userLoginLink = link + "/api/User/UserLogin"
var userLoginUrl = URL(string: userLoginLink)

var saveJournalLink = link + "/api/User/SaveJournal"
var saveJounalUrl = URL(string: saveJournalLink)


func getJournalUrl(UserName: String) -> URL {
    let getJournalLink = link + "/api/User/GetJournal?UserName=" + UserName
    let url = URL(string: getJournalLink)
    return url ?? URL(string: "google.com")!
}


var getChapterLink = link + "/api/User/GetChapter"
var getChapterUrl = URL(string: getChapterLink)


