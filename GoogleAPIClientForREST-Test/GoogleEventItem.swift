//
//  DTGoogleEventItem.swift
//  Tester
//
//  Created by Didats Triadi on 07/08/19.
//  Copyright © 2019 Rimbunesia. All rights reserved.
//

import GoogleAPIClientForREST

public struct GoogleEventItem {
    public var location: String
    public var status: String
    public var summary: String
    public var start: Date?
    public var end: Date?
    public var id: String
    public var calendarID: String

    init(item: GTLRCalendar_Event, calendar: String) {
        self.calendarID = calendar
        self.location = item.location ?? ""
        self.status = item.status ?? ""
        self.summary = item.summary ?? ""
        self.id = item.iCalUID ?? ""
        var dateStart: Date?
        var dateEnd: Date?
        if let start = item.start {
            if let dateTime = start.dateTime?.date {
                dateStart = dateTime
            } else {
                dateStart = start.date?.date
            }
        }

        if let end = item.end {
            if let dateTime = end.dateTime?.date {
                dateEnd = dateTime
            } else {
                dateEnd = end.date?.date
            }
        }

        self.start = dateStart
        self.end = dateEnd
    }
}
