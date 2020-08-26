//
//  DTGoogleCalendar.swift
//  Tester
//
//  Created by Didats Triadi on 06/08/19.
//  Copyright © 2019 Rimbunesia. All rights reserved.
//

import Foundation
import GoogleAPIClientForREST
import GoogleSignIn
import GTMSessionFetcher
//import SwiftMoment

public class GoogleCalendar {
    private var googleUser: GIDGoogleUser?
    private let service = GTLRCalendarService()
    var isAllowed = false

    public static func setup(user: GIDGoogleUser) -> GoogleCalendar {
        let googleCalendar = GoogleCalendar()
        googleCalendar.googleUser = user
        return googleCalendar
    }

    private func calendarIds(callback: @escaping(_ ids: [String]) -> Void) {
        guard let google = googleUser else { return }
        service.authorizer = google.authentication.fetcherAuthorizer()
        let query = GTLRCalendarQuery_CalendarListList.query()
        query.showDeleted = false
        query.showHidden = false
        service.executeQuery(query) { _, response, _ in
            var calendarID = [String]()
            if let response = response as? GTLRCalendar_CalendarList {
                if let items = response.items {
                    calendarID = items.compactMap({ $0.identifier })
                }
            }
            callback(calendarID)
        }
    }

//    public func event(startDate: Date, callback: @escaping(_ events: [GoogleEventItem]) -> Void) {
//        let max = moment(startDate)
//        let minMonth = max.startOf(.Months).date
//        let maxMonth = max.add(6, .Months).endOf(.Months).date
//
//        var calendarIDs: [String] = []
//
//        calendarIds { ids in
//            if !ids.isEmpty {
//                var eventsData = [GoogleEventItem]()
//                for id in ids {
//                    let query = GTLRCalendarQuery_EventsList.query(withCalendarId: id)
//                    query.timeMin = GTLRDateTime(date: minMonth)
//                    query.timeMax = GTLRDateTime(date: maxMonth)
//                    query.singleEvents = false
//                    self.queryEvent(query: query, calendar: id) { events, _, calendar in
//                        calendarIDs.append(calendar)
//                        eventsData.append(contentsOf: events)
//
//                        if calendarIDs.count == ids.count {
//                            callback(eventsData)
//                        }
//                    }
//                }
//            } else {
//                Logger.info("Empty Calendar IDs with user: \(String(describing: self.googleUser?.profile.email))")
//            }
//        }
//    }
//
//    private func queryEvent(query: GTLRCalendarQuery_EventsList, calendar: String,
//                            callback: @escaping(_ events: [GoogleEventItem], _ error: Error?, _ calendar: String) -> Void) {
//        self.service.executeQuery(query, completionHandler: { _, response, error in
//            self.isAllowed = false
//            var events: [GoogleEventItem] = []
//
//            if let responses = response as? GTLRCalendar_Events {
//                if let items = responses.items {
//                    self.isAllowed = true
//                    items.forEach({ event in
//                        let eventItem = GoogleEventItem(item: event, calendar: calendar)
//                        events.append(eventItem)
//                    })
//                }
//            }
//
//            callback(events, error, calendar)
//        })
//    }
}
